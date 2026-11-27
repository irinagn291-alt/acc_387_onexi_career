from pathlib import Path
import json,plistlib,uuid,re
p=Path(__file__).resolve().parents[1]
def plist(path,data):
 (p/path).write_bytes(plistlib.dumps(data,sort_keys=False))
base={'CFBundleDevelopmentRegion':'en','CFBundleDisplayName':'Club Career','CFBundleExecutable':'$(EXECUTABLE_NAME)','CFBundleIdentifier':'$(PRODUCT_BUNDLE_IDENTIFIER)','CFBundleInfoDictionaryVersion':'6.0','CFBundleName':'$(PRODUCT_NAME)','CFBundlePackageType':'APPL','CFBundleShortVersionString':'$(MARKETING_VERSION)','CFBundleVersion':'$(CURRENT_PROJECT_VERSION)','LSRequiresIPhoneOS':True,'UIApplicationSupportsIndirectInputEvents':True,'UILaunchScreen':{},'UIBackgroundModes':['remote-notification'],'UISupportedInterfaceOrientations':['UIInterfaceOrientationPortrait','UIInterfaceOrientationLandscapeLeft','UIInterfaceOrientationLandscapeRight'],'UISupportedInterfaceOrientations~ipad':['UIInterfaceOrientationPortrait','UIInterfaceOrientationPortraitUpsideDown','UIInterfaceOrientationLandscapeLeft','UIInterfaceOrientationLandscapeRight'],'CFBundleLocalizations':['en','de','pt-BR','fr','es','ru'],'CFBundleURLTypes':[{'CFBundleURLSchemes':['clubcareer94']}], 'NSSupportsLiveActivities':False}
plist('ClubCareer/Info.plist',base)
plist('Widgets/Info.plist',{'CFBundleDevelopmentRegion':'en','CFBundleDisplayName':'Club Career','CFBundleExecutable':'$(EXECUTABLE_NAME)','CFBundleIdentifier':'$(PRODUCT_BUNDLE_IDENTIFIER)','CFBundleInfoDictionaryVersion':'6.0','CFBundleName':'$(PRODUCT_NAME)','CFBundlePackageType':'XPC!','CFBundleShortVersionString':'$(MARKETING_VERSION)','CFBundleVersion':'$(CURRENT_PROJECT_VERSION)','NSExtension':{'NSExtensionPointIdentifier':'com.apple.widgetkit-extension'}})
plist('ClubCareer/Cairn.entitlements',{'com.apple.security.application-groups':['group.app.lumenpath.clubcareer.ember94'],'aps-environment':'development'})
plist('Widgets/Vista.entitlements',{'com.apple.security.application-groups':['group.app.lumenpath.clubcareer.ember94']})
privacy={'NSPrivacyTracking':False,'NSPrivacyCollectedDataTypes':[],'NSPrivacyAccessedAPITypes':[]}
plist('Shared/PrivacyInfo.xcprivacy',privacy)
assets=p/'ClubCareer/Assets.xcassets';assets.mkdir(exist_ok=True);(assets/'Contents.json').write_text(json.dumps({'info':{'author':'xcode','version':1}}))
appicon=assets/'CairnMark.appiconset';appicon.mkdir(exist_ok=True);(appicon/'Contents.json').write_text(json.dumps({'images':[{'filename':'CairnMark.png','idiom':'universal','platform':'ios','size':'1024x1024'}],'info':{'author':'xcode','version':1}},indent=2))
objs={}
def obj(isa,**kw):
 k=uuid.uuid4().hex[:24].upper();objs[k]={'isa':isa,**kw};return k
files={}
def ref(path,ft):
 if path not in files: files[path]=obj('PBXFileReference',lastKnownFileType=ft,path=path,sourceTree='<group>')
 return files[path]
def phase(isa,paths):
 return obj(isa,buildActionMask=2147483647,files=[obj('PBXBuildFile',fileRef=ref(path,ft)) for path,ft in paths],runOnlyForDeploymentPostprocessing=0)
shared=[('Shared/Knoll.swift','sourcecode.swift'),('Shared/Rill.swift','sourcecode.swift')]
res=[('Shared/CareerWords.xcstrings','text.json.xcstrings'),('Shared/InfoPlist.xcstrings','text.json.xcstrings'),('Shared/PrivacyInfo.xcprivacy','text.xml')]
common={'SWIFT_VERSION':'5.0','IPHONEOS_DEPLOYMENT_TARGET':'17.6','TARGETED_DEVICE_FAMILY':'1,2','SDKROOT':'iphoneos','SUPPORTED_PLATFORMS':'iphoneos iphonesimulator','MARKETING_VERSION':'1.2.1','CURRENT_PROJECT_VERSION':'2127','CODE_SIGN_STYLE':'Automatic','SWIFT_EMIT_LOC_STRINGS':'NO','CLANG_ENABLE_MODULES':'YES','ENABLE_USER_SCRIPT_SANDBOXING':'YES','SUPPORTS_MACCATALYST':'NO','SUPPORTS_MAC_DESIGNED_FOR_IPHONE_IPAD':'NO','DEBUG_INFORMATION_FORMAT':'dwarf','GCC_OPTIMIZATION_LEVEL':'0','SWIFT_OPTIMIZATION_LEVEL':'-Onone'}
def configs(extra):
 xs=[]
 for name in ['Develop94','Deliver94']:
  s=common|extra
  s=s|({'SWIFT_ACTIVE_COMPILATION_CONDITIONS':'DEBUG','ENABLE_TESTABILITY':'YES'} if name=='Develop94' else {'SWIFT_OPTIMIZATION_LEVEL':'-O','GCC_OPTIMIZATION_LEVEL':'s','DEBUG_INFORMATION_FORMAT':'dwarf-with-dsym'})
  if extra.get('SWIFT_ACTIVE_COMPILATION_CONDITIONS'):s['SWIFT_ACTIVE_COMPILATION_CONDITIONS']=s.get('SWIFT_ACTIVE_COMPILATION_CONDITIONS','')+' '+extra['SWIFT_ACTIVE_COMPILATION_CONDITIONS']
  xs.append(obj('XCBuildConfiguration',buildSettings=s,name=name))
 return obj('XCConfigurationList',buildConfigurations=xs,defaultConfigurationIsVisible=0,defaultConfigurationName='Deliver94')
prod=[]
def target(name,bundle,paths,resources,info,ent=None,typ='application'):
 product=obj('PBXFileReference',explicitFileType='wrapper.application' if typ=='application' else ('wrapper.app-extension' if typ=='app-extension' else 'wrapper.cfbundle'),includeInIndex=0,path=name+('.app' if typ=='application' else ('.appex' if typ=='app-extension' else '.xctest')),sourceTree='BUILT_PRODUCTS_DIR');prod.append(product)
 s={'PRODUCT_NAME':name,'PRODUCT_BUNDLE_IDENTIFIER':bundle,'INFOPLIST_FILE':info,'GENERATE_INFOPLIST_FILE':'NO'}
 if ent:s['CODE_SIGN_ENTITLEMENTS']=ent
 if typ=='app-extension':s|={'SKIP_INSTALL':'YES','APPLICATION_EXTENSION_API_ONLY':'YES','SWIFT_ACTIVE_COMPILATION_CONDITIONS':'CAREER_EXTENSION'}
 if typ=='application':s|={'ASSETCATALOG_COMPILER_APPICON_NAME':'CairnMark','LD_RUNPATH_SEARCH_PATHS':'$(inherited) @executable_path/Frameworks'}
 if typ=='bundle.ui-testing':s|={'GENERATE_INFOPLIST_FILE':'YES','TEST_TARGET_NAME':'CairnXI','SWIFT_ACTIVE_COMPILATION_CONDITIONS':'CAREER_CHECKS'};s.pop('INFOPLIST_FILE')
 t=obj('PBXNativeTarget',buildConfigurationList=configs(s),buildPhases=[phase('PBXSourcesBuildPhase',paths),phase('PBXFrameworksBuildPhase',[]),phase('PBXResourcesBuildPhase',resources)],buildRules=[],dependencies=[],name=name,productName=name,productReference=product,productType='com.apple.product-type.'+typ)
 return t,product
app,appp=target('CairnXI','com.clubcareer.app',shared+[('ClubCareer/Cairn.swift','sourcecode.swift'),('ClubCareer/Flood.swift','sourcecode.swift')],res+[('ClubCareer/Assets.xcassets','folder.assetcatalog')],'ClubCareer/Info.plist','ClubCareer/Cairn.entitlements')
wid,wp=target('Vista94','com.clubcareer.app.glance',shared+[('Widgets/Vista.swift','sourcecode.swift')],res,'Widgets/Info.plist','Widgets/Vista.entitlements','app-extension')
test,tp=target('Orbit94','com.clubcareer.app.orbit',shared+[('Tests/Orbit.swift','sourcecode.swift'),('Widgets/Vista.swift','sourcecode.swift')],res,'',None,'bundle.ui-testing')
embed=obj('PBXCopyFilesBuildPhase',buildActionMask=2147483647,dstPath='',dstSubfolderSpec=13,files=[obj('PBXBuildFile',fileRef=wp,settings={'ATTRIBUTES':['RemoveHeadersOnCopy']})],name='Embed Career Glance',runOnlyForDeploymentPostprocessing=0);objs[app]['buildPhases'].append(embed)
products=obj('PBXGroup',children=prod,name='Products',sourceTree='<group>')
root=obj('PBXGroup',children=list(files.values())+[products],sourceTree='<group>')
proj=obj('PBXProject',attributes={'BuildIndependentTargetsInParallel':'YES','LastUpgradeCheck':'2720','ORGANIZATIONNAME':'Lumen Path Atelier 94','TargetAttributes':{app:{'SystemCapabilities':{'com.apple.ApplicationGroups.iOS':{'enabled':1},'com.apple.Push':{'enabled':1}}},wid:{'SystemCapabilities':{'com.apple.ApplicationGroups.iOS':{'enabled':1}}}}},buildConfigurationList=configs({}),compatibilityVersion='Xcode 14.0',developmentRegion='en',hasScannedForEncodings=0,knownRegions=['en','Base','de','pt-BR','fr','es','ru'],mainGroup=root,productRefGroup=products,projectDirPath='',projectRoot='',targets=[app,wid,test])
for t,dep in [(app,wid),(test,app)]:
 proxy=obj('PBXContainerItemProxy',containerPortal=proj,proxyType=1,remoteGlobalIDString=dep,remoteInfo=objs[dep]['name']);objs[t]['dependencies'].append(obj('PBXTargetDependency',target=dep,targetProxy=proxy))
def value(v,indent=0):
 if isinstance(v,dict):return '{\n'+''.join('\t'*(indent+1)+value(k)+' = '+value(x,indent+1)+';\n' for k,x in v.items())+'\t'*indent+'}'
 if isinstance(v,list):return '(\n'+''.join('\t'*(indent+1)+value(x,indent+1)+',\n' for x in v)+'\t'*indent+')'
 if isinstance(v,int):return str(v)
 return v if re.fullmatch(r'[A-Za-z0-9_./]+',v) else json.dumps(v)
project=p/'ClubCareer.xcodeproj';(project/'xcshareddata/xcschemes').mkdir(parents=True,exist_ok=True)
(project/'project.pbxproj').write_text('// !$*UTF8*$!\n'+value({'archiveVersion':1,'classes':{},'objectVersion':56,'objects':objs,'rootObject':proj})+'\n')
def buildref(t,pr):return f'<BuildableReference BuildableIdentifier="primary" BlueprintIdentifier="{t}" BuildableName="{objs[pr]["path"]}" BlueprintName="{objs[t]["name"]}" ReferencedContainer="container:ClubCareer.xcodeproj"/>'
(project/'xcshareddata/xcschemes/CairnXI.xcscheme').write_text(f'''<?xml version="1.0" encoding="UTF-8"?>
<Scheme LastUpgradeVersion="2720" version="1.3"><BuildAction parallelizeBuildables="YES" buildImplicitDependencies="YES"><BuildActionEntries><BuildActionEntry buildForTesting="YES" buildForRunning="YES" buildForProfiling="YES" buildForArchiving="YES" buildForAnalyzing="YES">{buildref(app,appp)}</BuildActionEntry></BuildActionEntries></BuildAction><TestAction buildConfiguration="Develop94" selectedDebuggerIdentifier="Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier="Xcode.IDEFoundation.Launcher.LLDB" shouldUseLaunchSchemeArgsEnv="YES"><Testables><TestableReference skipped="NO">{buildref(test,tp)}</TestableReference></Testables></TestAction><LaunchAction buildConfiguration="Develop94" selectedDebuggerIdentifier="Xcode.DebuggerFoundation.Debugger.LLDB" selectedLauncherIdentifier="Xcode.IDEFoundation.Launcher.LLDB" launchStyle="0" useCustomWorkingDirectory="NO" ignoresPersistentStateOnLaunch="NO" debugDocumentVersioning="YES" debugServiceExtension="internal" allowLocationSimulation="NO"><BuildableProductRunnable runnableDebuggingMode="0">{buildref(app,appp)}</BuildableProductRunnable></LaunchAction><ProfileAction buildConfiguration="Deliver94" shouldUseLaunchSchemeArgsEnv="YES" savedToolIdentifier="" useCustomWorkingDirectory="NO" debugDocumentVersioning="YES"><BuildableProductRunnable runnableDebuggingMode="0">{buildref(app,appp)}</BuildableProductRunnable></ProfileAction><AnalyzeAction buildConfiguration="Develop94"/><ArchiveAction buildConfiguration="Deliver94" revealArchiveInOrganizer="YES"/></Scheme>''')
print('Generated',len(objs),'unique objects')
