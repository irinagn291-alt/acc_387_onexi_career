from pathlib import Path
from datetime import datetime,timezone,timedelta
import json,re,shutil,subprocess,sys
p=Path(__file__).resolve().parents[1];qa=p/'QA';results={}
for tag,folder in [('phone03','iPhone-final'),('ipad01','iPad')]:
 summary=qa/(tag+'-summary.json');row={'status':'queued','tests':None,'shared_cache_verified':False}
 if (qa/(tag+'.log')).exists():row['status']='running'
 try:
  data=json.loads(summary.read_text());row['tests']={k:data.get(k) for k in ['result','passedTests','failedTests','totalTestCount']}
  a=json.loads((qa/(tag+'-saved-career.json')).read_text());b=json.loads((qa/(tag+'-widget-cache.json')).read_text())
  row['shared_cache_verified']=a==b and bool(a.get('careers')) and any(c['id']==a.get('active') and c['matches']>=2 for c in a['careers'])
  row['status']='passed' if data.get('result')=='Passed' and row['shared_cache_verified'] else 'failed'
 except (OSError,ValueError,KeyError):
  if summary.exists() and summary.stat().st_size:row['status']='incomplete'
 manifest=qa/(tag+'-attachments')/'manifest.json'
 if manifest.exists():
  try:
   dest=qa/folder;dest.mkdir(exist_ok=True)
   for group in json.loads(manifest.read_text()):
    for image in group.get('attachments',[]):
     src=manifest.parent/image['exportedFileName']
     if src.suffix.lower()!='.png':continue
     name=image.get('suggestedHumanReadableName',src.name).split('_0_')[0]
     name=re.sub(r'[^A-Za-z0-9_.-]','_',name)
     if not name.endswith('.png'):name+='.png'
     shutil.copyfile(src,dest/name)
   row['screenshots']=str(dest.relative_to(p))
  except (OSError,ValueError,KeyError):pass
 results[tag]=row
now=datetime.now(timezone(timedelta(hours=3))).isoformat(timespec='seconds')
status={'updated_at_moscow':now,'jobs':results,'physical_device_tested':False,'new_render_snapshots_visually_reviewed':False}
(qa/'STATUS.json').write_text(json.dumps(status,ensure_ascii=False,indent=2))
r=p/'REPORT.md';text=r.read_text();line='- Подписанный QA iPhone / iPad: '+('оба прогона прошли по 8 тестов; файлы карьеры и App Group совпали.' if all(x['status']=='passed' for x in results.values()) else 'задания ожидают или выполняют проверки в общем пуле; выполнением это не считается.')+' Актуальное состояние: `QA/STATUS.json`. Автоматически экспортированные снимки требуют финальной визуальной сверки. Обновлено '+now+'.'
text=re.sub(r'^- Подписанный QA iPhone / iPad[^\n]*',line,text,flags=re.M);r.write_text(text)
for script in ['audit.py','package.py']:
 with (qa/('collect-'+script+'.log')).open('w') as log:subprocess.run([sys.executable,str(p/'Design'/script)],cwd=p,stdout=log,stderr=subprocess.STDOUT)
print(json.dumps(status,ensure_ascii=False))
