import SwiftUI

private let qInk=Color(red:7/255,green:20/255,blue:40/255)
private let qBlue=Color(red:77/255,green:166/255,blue:1)
private let qCard=Color(red:14/255,green:35/255,blue:63/255)

@main struct Jv94:App {
 @StateObject private var b=Br8()
 var body:some Scene {WindowGroup {Fz94().environmentObject(b).preferredColorScheme(.dark).tint(qBlue)}}
}
struct Fz94:View {
 @EnvironmentObject var b:Br8
 @State private var tab=0; @State private var settings=false; @State private var report:Nd6?
 var body:some View {
  Group {if let c=b.current {
   TabView(selection:$tab) {
    NavigationStack {Qw94(c:c,report:$report).navigationTitle("OneXI Career").navigationBarTitleDisplayMode(.inline).toolbar {ToolbarItem(placement:.topBarTrailing) {Button {settings=true} label:{Image(systemName:"slider.horizontal.3")}.accessibilityLabel(kc("settings")).accessibilityIdentifier("settings")}}}.tabItem{Label(kc("career"),systemImage:"sportscourt.fill")}.tag(0)
    NavigationStack {Ak94(c:c)}.tabItem{Label(kc("training"),systemImage:"figure.run")}.tag(1)
    NavigationStack {Ep94(c:c)}.tabItem{Label(kc("clubs"),systemImage:"shield.lefthalf.filled")}.tag(2)
    NavigationStack {Xh94(c:c)}.tabItem{Label(kc("legacy"),systemImage:"trophy.fill")}.tag(3)
   }.id(c.id).sheet(isPresented:$settings){Ub94()}.sheet(item:$report){Rk94(r:$0)}
  } else {NavigationStack {Wj94()}}}
  .alert(kc("notice"),isPresented:Binding(get:{b.fault != nil},set:{if !$0 {b.fault=nil}})) {Button(kc("ok")){b.fault=nil}} message:{Text(b.fault ?? "")}
  .onOpenURL {url in if url.scheme=="clubcareer94" {tab=0}}
  .onReceive(NotificationCenter.default.publisher(for:UIApplication.didBecomeActiveNotification)){_ in Task{await b.checkPermission();await b.reschedule()}}
 }
}
struct Wj94:View {
 @EnvironmentObject var b:Br8; @Environment(\.dismiss) var dismiss
 @State private var name="";@State private var number=9;@State private var position=0
 var body:some View {
  ScrollView {VStack(alignment:.leading,spacing:25) {
   HStack {Image(systemName:"soccerball").font(.system(size:30)); Text("OneXI Career").font(.caption.weight(.heavy)).tracking(3)}.foregroundStyle(qBlue)
   Text(kc("createTitle")).font(.system(.largeTitle,design:.rounded,weight:.bold))
   Text(kc("createIntro")).foregroundStyle(.secondary)
   ZStack {Cw94().frame(height:140);HStack {Spacer();Image(systemName:"figure.soccer").font(.system(size:90,weight:.light)).foregroundStyle(.white);Spacer()}}.accessibilityHidden(true)
   VStack(alignment:.leading,spacing:15) {
    Text(kc("playerName")).font(.headline)
    TextField(kc("namePlaceholder"),text:$name).textContentType(.nickname).padding(14).background(qInk,in:RoundedRectangle(cornerRadius:12)).accessibilityIdentifier("playerName")
    Stepper(value:$number,in:1...99){HStack {Text(kc("shirt"));Spacer();Text(String(format:"%02d",number)).font(.title2.monospaced().bold())}}
   }.padding(20).background(qCard,in:RoundedRectangle(cornerRadius:22))
   Text(kc("choosePosition")).font(.headline)
   ForEach(0..<3,id:\.self) {i in Button {position=i} label:{HStack {Image(systemName:["scope","arrow.triangle.branch","shield.fill"][i]).frame(width:28);VStack(alignment:.leading,spacing:4){Text(kc(Mv7.positions[i])).font(.headline);Text(kc(["strikerHint","midfielderHint","defenderHint"][i])).font(.caption).foregroundStyle(.secondary)};Spacer();Image(systemName:position==i ? "checkmark.circle.fill":"circle")}.padding(16).background(position==i ? qBlue.opacity(0.18):qCard,in:RoundedRectangle(cornerRadius:16)).overlay(RoundedRectangle(cornerRadius:16).stroke(position==i ? qBlue:.clear))}.buttonStyle(.plain).accessibilityIdentifier("position\(i)")}
   Button {b.create(name,number,position);dismiss()} label:{Label(kc("beginCareer"),systemImage:"arrow.right").frame(maxWidth:.infinity).padding(9)}.buttonStyle(.borderedProminent).disabled(name.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty).accessibilityIdentifier("beginCareer")
   Text(kc("offlinePromise")).font(.caption).foregroundStyle(.secondary)
  }.padding(24).frame(maxWidth:650).frame(maxWidth:.infinity)}.background(qInk).navigationTitle(kc("newCareer")).navigationBarTitleDisplayMode(.inline)
 }
}
struct Cw94:View {
 var body:some View {GeometryReader {g in ZStack {
  RoundedRectangle(cornerRadius:20).fill(LinearGradient(colors:[Color(red:17/255,green:64/255,blue:143/255),qInk],startPoint:.topLeading,endPoint:.bottomTrailing))
  Path {p in let r=CGRect(x:20,y:16,width:g.size.width-40,height:g.size.height-32);p.addRoundedRect(in:r,cornerSize:CGSize(width:5,height:5));p.move(to:CGPoint(x:g.size.width/2,y:16));p.addLine(to:CGPoint(x:g.size.width/2,y:g.size.height-16));p.addEllipse(in:CGRect(x:g.size.width/2-28,y:g.size.height/2-28,width:56,height:56))}.stroke(.white.opacity(0.15),lineWidth:1)
 }} }
}
struct Qw94:View {
 @Environment(\.horizontalSizeClass) var hc
 @EnvironmentObject var b:Br8; var c:Mv7; @Binding var report:Nd6?
 @State private var tactic=0; @State private var schedule=false;@State private var info=false
 var body:some View {
  ScrollView {VStack(alignment:.leading,spacing:24) {
   HStack {VStack(alignment:.leading,spacing:5){Text(kf("seasonNumber",c.year).uppercased()).font(.caption.weight(.bold)).tracking(2).foregroundStyle(qBlue);Text(kc("yourJourney")).font(.system(.largeTitle,design:.rounded,weight:.bold))};Spacer();Button{info=true}label:{Image(systemName:"info.circle").font(.title3)}.accessibilityLabel(kc("howItWorks"))}
   HStack(spacing:18) {
    ZStack {RoundedRectangle(cornerRadius:18).fill(.white.opacity(0.12)).frame(width:82,height:96);VStack(spacing:6){Image(systemName:"tshirt.fill").font(.system(size:32));Text(String(format:"%02d",c.j)).font(.title3.monospaced().bold())}}.accessibilityHidden(true)
    VStack(alignment:.leading,spacing:7){Text(c.n).font(.title2.bold());Text(c.club).font(.subheadline);Text(kc(Mv7.positions[c.role])).font(.caption).foregroundStyle(.white.opacity(0.7))};Spacer(minLength:0)
    VStack(spacing:3){Text("\(c.ovr)").font(.system(size:34,weight:.heavy,design:.rounded));Text(kc("overall")).font(.caption2)}
   }.padding(22).frame(maxWidth:.infinity,alignment:.leading).background(LinearGradient(colors:[Color(red:17/255,green:64/255,blue:143/255),Color(red:17/255,green:48/255,blue:95/255)],startPoint:.topLeading,endPoint:.bottomTrailing),in:RoundedRectangle(cornerRadius:26))
   LazyVGrid(columns:hc == .regular ? [GridItem(.flexible(),spacing:20),GridItem(.flexible())]:[GridItem(.flexible())],alignment:.leading,spacing:20) {
    VStack(alignment:.leading,spacing:17) {
     HStack {Label(kc(c.complete ? "seasonComplete":"nextMatch"),systemImage:c.complete ? "flag.checkered":"soccerball").font(.headline);Spacer();Text(kf("roundCount",min(14,c.round+1))).font(.caption).foregroundStyle(qBlue)}
     if c.complete {
      Text(kf("seasonResult",c.rank,c.table[0].pts)).font(.title2.bold())
      Text(kc("seasonCompleteHint")).foregroundStyle(.secondary)
      NavigationLink {Ep94(c:c)} label:{Text(kc("reviewClubs")).frame(maxWidth:.infinity).padding(8)}.buttonStyle(.borderedProminent)
     } else {
      HStack {VStack(alignment:.leading,spacing:8){Text(c.club).font(.title3.bold());Text(kc("versus")).font(.caption).foregroundStyle(.secondary);Text(c.opponent).font(.title3.bold())};Spacer();Image(systemName:"shield.lefthalf.filled").font(.system(size:44)).foregroundStyle(qBlue.opacity(0.7)).accessibilityHidden(true)}
      Text(kc("playAnytime")).font(.caption).foregroundStyle(.secondary)
      Picker(kc("matchApproach"),selection:$tactic){ForEach(0..<3,id:\.self){Text(kc(["balanced","attacking","composed"][$0])).tag($0)}}.pickerStyle(.segmented)
      Text(kc(["balancedHint","attackingHint","composedHint"][tactic])).font(.caption).foregroundStyle(.secondary).fixedSize(horizontal:false,vertical:true)
      Button {b.change{report=$0.play(tactic)}} label:{Label(kc("playMatch"),systemImage:"play.fill").font(.headline).frame(maxWidth:.infinity).padding(9)}.buttonStyle(.borderedProminent).accessibilityIdentifier("playMatch")
     }
    }.kPanel()
    VStack(alignment:.leading,spacing:18) {
     HStack {Text(kc("seasonPulse")).font(.headline);Spacer();Text(kc(Mv7.tiers[c.tier])).font(.caption).foregroundStyle(qBlue)}
     HStack {Km94(value:"\(c.round)/14",label:"matches");Spacer();Km94(value:"\(c.sg)",label:"goals");Spacer();Km94(value:"\(c.sa)",label:"assists")}
     ProgressView(value:Double(c.round),total:14).tint(qBlue)
     HStack {Label(kf("positionNumber",c.rank),systemImage:"chart.bar.fill");Spacer();Text(kf("pointsCount",c.table[0].pts))}.font(.subheadline)
     Divider();Text(kc("recentForm")).font(.caption).foregroundStyle(.secondary)
     if c.form.isEmpty {Text(kc("noMatches")).font(.subheadline).foregroundStyle(.secondary)} else {HStack {ForEach(Array(c.form.enumerated()),id:\.offset){_,f in Qp94(f:f)};Spacer();Text(c.average.formatted(.number.precision(.fractionLength(1)))).font(.title3.bold()).accessibilityLabel(kf("ratingValue",c.average))}}
     Button {schedule=true} label:{Label(kc("fixturesTable"),systemImage:"list.bullet.rectangle")}.font(.subheadline).accessibilityIdentifier("fixturesTable")
    }.kPanel()
   }
   HStack {Text(kc("matchJournal")).font(.title2.bold());Spacer();Text(kf("matchesCount",c.matches)).font(.caption).foregroundStyle(.secondary)}
   if c.history.isEmpty {Label(kc("journalEmpty"),systemImage:"pencil.and.list.clipboard").foregroundStyle(.secondary).padding(.bottom)}
   ForEach(c.history.suffix(8).reversed()) {r in Button {report=r} label:{HStack(spacing:12){Qp94(f:r.f);VStack(alignment:.leading,spacing:4){Text(r.b).font(.headline);Text(kf("journalRound",r.s,r.r)).font(.caption).foregroundStyle(.secondary)};Spacer();Text("\(r.x) : \(r.y)").font(.title3.monospaced().bold());Image(systemName:"chevron.right").font(.caption).foregroundStyle(.secondary)}.padding(16).background(qCard,in:RoundedRectangle(cornerRadius:16))}.buttonStyle(.plain)}
  }.padding(22).frame(maxWidth:1150).frame(maxWidth:.infinity)}.background(qInk).sheet(isPresented:$schedule){NavigationStack{Jk94(c:c)}}.sheet(isPresented:$info){NavigationStack{ScrollView{VStack(alignment:.leading,spacing:24){ForEach(["rule1","rule2","rule3","rule4","rule5"],id:\.self){Text(kc($0))}}.padding(24)}.navigationTitle(kc("howItWorks")).toolbar{ToolbarItem(placement:.confirmationAction){Button(kc("done")){info=false}}}}}
 }
}
struct Km94:View {var value:String;var label:String;var body:some View {VStack(alignment:.leading,spacing:5){Text(value).font(.system(.title,design:.rounded,weight:.bold)).monospacedDigit();Text(kc(label)).font(.caption).foregroundStyle(.secondary)}}}
struct Qp94:View {var f:String;var body:some View {Text(kc("form"+f)).font(.caption.bold()).frame(minWidth:30,minHeight:32).padding(.horizontal,3).background(f=="W" ? qBlue.opacity(0.3):.white.opacity(f=="D" ? 0.15:0.06),in:RoundedRectangle(cornerRadius:9)).foregroundStyle(f=="W" ? qBlue:.white).accessibilityLabel(kc("result"+f))}}
extension View {func kPanel()->some View {self.padding(21).frame(maxWidth:.infinity,alignment:.leading).background(qCard,in:RoundedRectangle(cornerRadius:24))}}
struct Rk94:View {
 let r:Nd6;@Environment(\.dismiss) var dismiss
 var body:some View {NavigationStack {ScrollView {VStack(spacing:24){Text(kf("journalRound",r.s,r.r).uppercased()).font(.caption.weight(.bold)).tracking(2).foregroundStyle(qBlue);Text(kc("result"+r.f)).font(.largeTitle.bold());HStack {Text(r.a).frame(maxWidth:.infinity);Text("\(r.x) : \(r.y)").font(.system(size:48,weight:.heavy,design:.rounded)).monospacedDigit().layoutPriority(1);Text(r.b).frame(maxWidth:.infinity)}.font(.headline).padding(.vertical,16)
    HStack {Km94(value:r.z.formatted(.number.precision(.fractionLength(1))),label:"rating");Spacer();Km94(value:"\(r.g)",label:"goals");Spacer();Km94(value:"\(r.h)",label:"assists")}.kPanel()
    VStack(alignment:.leading,spacing:18){Text(kc("matchStory")).font(.title2.bold());ForEach(Array(r.e.enumerated()),id:\.offset){i,e in HStack(alignment:.top){Text(String(format:"%02d",min(90,12+i*18))).monospacedDigit().foregroundStyle(qBlue);Text(kc(e)).frame(maxWidth:.infinity,alignment:.leading)}}}.kPanel()
    Text(kc("simulationNote")).font(.caption).foregroundStyle(.secondary)
    Button(kc("continueCareer")){dismiss()}.buttonStyle(.borderedProminent).accessibilityIdentifier("continueCareer")
   }.padding(24).frame(maxWidth:700).frame(maxWidth:.infinity)}.background(qInk).navigationTitle(kc("matchReport")).navigationBarTitleDisplayMode(.inline).toolbar{ToolbarItem(placement:.confirmationAction){Button(kc("done")){dismiss()}}}}
}
}
struct Ak94:View {
 @EnvironmentObject var b:Br8;var c:Mv7;@State private var feedback=""
 var body:some View {ScrollView{VStack(alignment:.leading,spacing:24){Text(kc("trainingTitle")).font(.largeTitle.bold());Text(kc("trainingIntro")).foregroundStyle(.secondary)
   HStack{Km94(value:"\(c.practice)",label:"practicePoints");Spacer();Km94(value:"\(c.energy)%",label:"fitness")}.kPanel()
   ForEach(0..<5,id:\.self){i in VStack(alignment:.leading,spacing:13){HStack {Image(systemName:["scope","point.3.connected.trianglepath.dotted","bolt.fill","shield.fill","heart.fill"][i]).foregroundStyle(qBlue);Text(kc(Mv7.fields[i])).font(.headline);Spacer();Text("\(c.skills[i])").font(.title2.monospaced().bold())};ProgressView(value:Double(c.skills[i]),total:99);HStack{Text(c.skills[i]>=99 ? kc("mastered"):kf("trainingCost",c.cost[i])).font(.caption).foregroundStyle(.secondary);Spacer();Button {b.change{_=$0.train(i)};feedback=kf("trainedSkill",kc(Mv7.fields[i]))}label:{Label(kc("train"),systemImage:"plus")}.buttonStyle(.bordered).disabled(c.complete || c.skills[i]>=99 || c.practice<c.cost[i] || c.energy<6).accessibilityIdentifier("train\(i)")}}.kPanel()}
   if !feedback.isEmpty {Text(feedback).foregroundStyle(qBlue).accessibilityIdentifier("trainingFeedback")}
   Button {b.change{_=$0.rest()}}label:{Label(kc("recovery"),systemImage:"leaf.fill").frame(maxWidth:.infinity).padding(8)}.buttonStyle(.borderedProminent).disabled(c.complete || c.recovery || c.energy==100).accessibilityIdentifier("recovery")
   Text(kc("recoveryHint")).font(.caption).foregroundStyle(.secondary)
  }.padding(22).frame(maxWidth:750).frame(maxWidth:.infinity)}.background(qInk).navigationTitle(kc("training")).navigationBarTitleDisplayMode(.inline)}
}
struct Ep94:View {
 @EnvironmentObject var b:Br8;var c:Mv7;@State private var destination:Int?;@State private var confirm=false
 var body:some View {ScrollView {VStack(alignment:.leading,spacing:23){Text(kc("clubPath")).font(.largeTitle.bold());Text(kc("transferIntro")).foregroundStyle(.secondary)
   ForEach(0..<5,id:\.self){i in HStack(alignment:.top,spacing:16){ZStack{Circle().fill(i<=c.tier ? qBlue:qCard).frame(width:44,height:44);Image(systemName:i<c.tier ? "checkmark":"shield.fill").foregroundStyle(i<=c.tier ? qInk:qBlue)};VStack(alignment:.leading,spacing:7){Text(Mv7.clubs[i]).font(.headline);Text(kc(Mv7.tiers[i])).font(.caption).foregroundStyle(qBlue)
    if i==c.tier {Text(kc("currentClub")).font(.caption)} else if i>c.tier {Text(kf("clubRequirement",46+i*4,i*14,i*10)).font(.caption).foregroundStyle(.secondary)}
    if c.offers.contains(i) {Button(kc("acceptOffer")){destination=i;confirm=true}.buttonStyle(.borderedProminent).accessibilityIdentifier("offer\(i)")}
   };Spacer(minLength:0)}.kPanel()}
   HStack{Km94(value:"\(c.ovr)",label:"overall");Spacer();Km94(value:"\(c.matches)",label:"matches");Spacer();Km94(value:"\(c.reputation)",label:"reputation")}.kPanel()
   if c.complete {Button(kc("stayNextSeason")){b.change{_=$0.advance()}}.buttonStyle(.borderedProminent).accessibilityIdentifier("nextSeason")} else {Text(kc("offersWindow")).font(.subheadline).foregroundStyle(.secondary)}
  }.padding(22).frame(maxWidth:800).frame(maxWidth:.infinity)}.background(qInk).navigationTitle(kc("clubs")).navigationBarTitleDisplayMode(.inline).confirmationDialog(kc("transferConfirm"),isPresented:$confirm,titleVisibility:.visible){Button(kc("acceptOffer")){if let d=destination {b.change{_=$0.advance(d)}}};Button(kc("cancel"),role:.cancel){}} message:{Text(kc("transferConfirmHint"))}}
}
struct Xh94:View {var c:Mv7
 var body:some View {ScrollView{VStack(alignment:.leading,spacing:24){Text(kc("legacyTitle")).font(.largeTitle.bold());HStack {Km94(value:"\(c.goals)",label:"careerGoals");Spacer();Km94(value:"\(c.assists)",label:"assists");Spacer();Km94(value:"\(c.cups.count)",label:"trophies")}.kPanel()
   Text(kc("legends")).font(.title2.bold());ForEach(0..<5,id:\.self){i in HStack(spacing:14){Image(systemName:c.legends[i] ? "star.circle.fill":"circle.dashed").font(.title).foregroundStyle(c.legends[i] ? qBlue:.secondary);VStack(alignment:.leading,spacing:4){Text(kc("legend\(i)")).font(.headline);Text(kc("legendHint\(i)")).font(.caption).foregroundStyle(.secondary)};Spacer()}.kPanel()}
   Text(kc("trophyCabinet")).font(.title2.bold());if c.cups.isEmpty {Text(kc("trophyEmpty")).foregroundStyle(.secondary)}
   ForEach(c.cups.reversed()){v in HStack {Image(systemName:"trophy.fill").font(.largeTitle).foregroundStyle(.yellow);VStack(alignment:.leading,spacing:4){Text(kc(v.k)).font(.headline);Text(kf("seasonNumber",v.y)+" · "+v.c).font(.caption).foregroundStyle(.secondary)};Spacer()}.kPanel()}
   Text(kc("seasonArchive")).font(.title2.bold());if c.seasons.isEmpty {Text(kc("archiveEmpty")).foregroundStyle(.secondary)}
   ForEach(c.seasons.reversed()){s in VStack(alignment:.leading,spacing:8){Text(kf("seasonNumber",s.y)+" · "+s.c).font(.headline);Text(kf("archiveResult",s.rank,s.pts,s.g,s.a)).font(.subheadline).foregroundStyle(.secondary)}.kPanel()}
  }.padding(22).frame(maxWidth:850).frame(maxWidth:.infinity)}.background(qInk).navigationTitle(kc("legacy")).navigationBarTitleDisplayMode(.inline)}
}
struct Jk94:View {var c:Mv7;@Environment(\.dismiss) var dismiss
 var body:some View {ScrollView {VStack(alignment:.leading,spacing:22){Text(kc("leagueTable")).font(.title2.bold());Text(kc("tableLegend")).font(.caption).foregroundStyle(.secondary)
   ForEach(Array(c.sorted.enumerated()),id:\.element.id){rank,row in HStack {Text("\(rank+1)").frame(width:20);Text(row.n).fontWeight(row.id==0 ? .bold:.regular);Spacer();Text("\(row.p)").frame(width:24);Text("\(row.gd)").frame(width:30);Text("\(row.pts)").bold().frame(width:30)}.font(.subheadline).padding(12).background(row.id==0 ? qBlue.opacity(0.16):qCard,in:RoundedRectangle(cornerRadius:12))}
   Text(kc("fixtureList")).font(.title2.bold());ForEach(0..<14,id:\.self){r in let p=c.schedule(r).first{$0.0==0 || $0.1==0}!;let o=p.0==0 ? p.1:p.0
    HStack {Text(kf("roundNumber",r+1)).foregroundStyle(.secondary);Spacer();Text(c.table[o].n);Text(kc(p.0==0 ? "home":"away")).font(.caption).foregroundStyle(qBlue)}.padding(.vertical,8)}
  }.padding(22).frame(maxWidth:800).frame(maxWidth:.infinity)}.background(qInk).navigationTitle(kc("fixturesTable")).navigationBarTitleDisplayMode(.inline).toolbar{ToolbarItem(placement:.confirmationAction){Button(kc("done")){dismiss()}}}}
}
struct Ub94:View {
 @EnvironmentObject var b:Br8;@Environment(\.dismiss) var dismiss;@State private var create=false;@State private var deleting:UUID?;@State private var confirm=false;@State private var time=Date().addingTimeInterval(86400)
 var body:some View {NavigationStack {Form {
  Section(kc("careers")) {ForEach(b.z.careers){c in HStack {Button {b.select(c.id);dismiss()}label:{VStack(alignment:.leading,spacing:4){Text(c.n);Text(c.club+" · "+kf("seasonNumber",c.year)).font(.caption).foregroundStyle(.secondary)}};Spacer();if c.id==b.z.active {Image(systemName:"checkmark.circle.fill").foregroundStyle(qBlue)};Button(role:.destructive){deleting=c.id;confirm=true}label:{Image(systemName:"trash")}.buttonStyle(.borderless).accessibilityLabel(kf("deleteNamed",c.n))}}
   Button(kc("newCareer")){create=true}.disabled(b.z.careers.count>=4).accessibilityIdentifier("newCareer")
  }
  Section {Toggle(kc("matchReminders"),isOn:Binding(get:{b.z.reminders},set:{v in Task {await b.enable(v)}})).accessibilityIdentifier("reminderToggle");Text(kc("reminderExplainer")).font(.caption).foregroundStyle(.secondary);if !b.permission.isEmpty {Text(b.permission).font(.caption).foregroundStyle(.secondary)}
   DatePicker(kc("nextReminder"),selection:$time,in:Date()...,displayedComponents:[.date,.hourAndMinute]).disabled(b.current?.complete ?? true)
   Button(kc("saveReminder")){b.change{$0.next=time}}.disabled(b.current?.complete ?? true)
   Text(kc("reminderScheduleHint")).font(.caption).foregroundStyle(.secondary)
  } header:{Text(kc("notifications"))}
  Section(kc("privacy")){Text(kc("privacyText"));Text(kc("deleteHint")).font(.caption).foregroundStyle(.secondary)}
  Section(kc("about")){Text(kc("aboutText"));Text("1.2.1 (2127)").font(.caption).foregroundStyle(.secondary)}
 }.navigationTitle(kc("settings")).toolbar {ToolbarItem(placement:.confirmationAction){Button(kc("done")){dismiss()}}}.onAppear {time=max(b.current?.next ?? Date().addingTimeInterval(86400),Date().addingTimeInterval(60));Task {await b.checkPermission()}}.sheet(isPresented:$create){NavigationStack{Wj94().toolbar{ToolbarItem(placement:.cancellationAction){Button(kc("cancel")){create=false}}}}}.confirmationDialog(kc("deleteCareer"),isPresented:$confirm,titleVisibility:.visible){Button(kc("delete"),role:.destructive){if let id=deleting {b.remove(id)}};Button(kc("cancel"),role:.cancel){}}message:{Text(kc("deleteConfirm"))}}
}
}
