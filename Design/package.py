from pathlib import Path
from zipfile import ZipFile,ZIP_DEFLATED
import hashlib,json
p=Path(__file__).resolve().parents[1];d=p/'Delivery';d.mkdir(exist_ok=True)
files=[]
for folder in ['ClubCareer','Shared','Widgets','Tests','ClubCareer.xcodeproj','Design']:
 files += [q for q in (p/folder).rglob('*') if q.is_file() and not any(x in q.parts for x in ['xcuserdata','__pycache__']) and q.name!='.DS_Store']
files += [p/'REPORT.md',p/'.gitignore',p/'QA/foreground.sh',p/'QA/collect.py',p/'QA/STATUS.json',p/'QA/static-audit.json']
for q in sorted((p/'QA').glob('*-summary.json')):
 try:
  if json.loads(q.read_text()).get('result')=='Passed':files.append(q)
 except (ValueError,OSError):pass
with ZipFile(d/'ClubCareer-Source-v1.2.1.zip','w',ZIP_DEFLATED) as z:
 for q in files:z.write(q,Path('ClubCareer')/q.relative_to(p))
a=p/'Build/ClubCareer-final-unsigned.xcarchive'
with ZipFile(d/'ClubCareer-iOS-unsigned-v1.2.1.zip','w',ZIP_DEFLATED) as z:
 for q in a.rglob('*'):
  if q.is_file():z.write(q,q.relative_to(a.parent))
checks={q.name:hashlib.sha256(q.read_bytes()).hexdigest() for q in d.glob('*.zip')}
(d/'SHA256.json').write_text(json.dumps(checks,indent=2));print(json.dumps(checks,indent=2))
