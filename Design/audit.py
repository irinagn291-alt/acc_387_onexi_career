from pathlib import Path
import re,json,hashlib,subprocess
p=Path(__file__).resolve().parents[1];root=p.parents[3]
project=(p/'ClubCareer.xcodeproj/project.pbxproj').read_text();ids=set(re.findall(r'\b[A-F0-9]{24}\b',project));clashes=[]; bundle_clashes=[]
def bids(text):return set(re.findall(r'PRODUCT_BUNDLE_IDENTIFIER\s*=\s*"?([a-zA-Z0-9_.-]+)',text))
owned_bids=bids(project)
paths=subprocess.check_output(['rg','--files',str(root/'output'),'-g','project.pbxproj','-g','!**/Build/**','-g','!**/DerivedData/**'],text=True).splitlines()
for path in paths:
 q=Path(path)
 if q.parent.parent==p:continue
 content=q.read_text(errors='ignore'); overlap=ids & set(re.findall(r'\b[A-F0-9]{24}\b',content))
 for a in owned_bids:
  for b in bids(content):
   if a==b or a.startswith(b+'.') or b.startswith(a+'.'):bundle_clashes.append({'own':a,'other':b,'project':str(q.relative_to(root))})
 if overlap:clashes.append({'project':str(q.relative_to(root)),'count':len(overlap)})
source=[*p.glob('ClubCareer/*.swift'),*p.glob('Shared/*.swift'),*p.glob('Widgets/*.swift'),*p.glob('Tests/*.swift')]
keys=json.loads((p/'Shared/CareerWords.xcstrings').read_text())['strings'];formats={}
for key,v in keys.items():
 vals=v['localizations'];assert len(vals)==6,key
 tokens=[re.findall(r'%(?:\d+\$)?(?:\.\d+)?[@df]',x['stringUnit']['value']) for x in vals.values()]
 assert all(t==tokens[0] for t in tokens),key
for q in [*source,p/'ClubCareer.xcodeproj/project.pbxproj',p/'ClubCareer/Info.plist',p/'Widgets/Info.plist']:
 assert '/Users/' not in q.read_text(),q
assert not clashes,clashes
assert not bundle_clashes,bundle_clashes
assert len(source)<=6,len(source)
for q in source:
 for k in re.findall(r'k[cf]\("([^"\\]+)"',q.read_text()):
  if k not in ['form','result'] and k not in keys:raise AssertionError(k)
report={'source_swift_files':len(source),'project_object_ids':len(ids),'other_projects_checked':len(paths)-1,'uuid_collisions':clashes,'bundle_identifiers':sorted(owned_bids),'bundle_identifier_conflicts':bundle_clashes,'localized_keys':len(keys),'locales':['en','de','pt-BR','fr','es','ru'],'format_specifiers_consistent':True,'machine_paths_in_source':False,'source_hashes':{str(q.relative_to(p)):hashlib.sha256(q.read_bytes()).hexdigest() for q in source}}
(p/'QA/static-audit.json').write_text(json.dumps(report,indent=2));print(json.dumps(report,indent=2))
