import SwiftUI
import WidgetKit

struct Zv94:TimelineEntry {var date:Date;var c:Mv7?}
struct Sq94:TimelineProvider {
 func placeholder(in context:Context)->Zv94 {Zv94(date:Date(),c:nil)}
 func getSnapshot(in context:Context,completion:@escaping(Zv94)->Void){completion(read())}
 func getTimeline(in context:Context,completion:@escaping(Timeline<Zv94>)->Void) {
  let e=read();var entries=[e]
  if let c=e.c,c.next > e.date,!c.complete {entries.append(Zv94(date:c.next,c:c))}
  completion(Timeline(entries:entries,policy:.after(Date().addingTimeInterval(1800))))
 }
 func read()->Zv94 {
  guard let u=FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:knGroup)?.appendingPathComponent("widget-career.json"),let d=try? Data(contentsOf:u),let z=try? JSONDecoder().decode(Zy8.self,from:d),let i=z.selected,z.careers[i].valid else{return Zv94(date:Date(),c:nil)}
  return Zv94(date:Date(),c:z.careers[i])
 }
}
#if CAREER_EXTENSION
@main struct Wr94:Widget {
 let kind="LumenCareerGlance94"
 var body:some WidgetConfiguration {StaticConfiguration(kind:kind,provider:Sq94()){e in Wv94(e:e).containerBackground(for:.widget){Color(red:7/255,green:20/255,blue:40/255)}}.configurationDisplayName(kc("widgetName")).description(kc("widgetDescription")).supportedFamilies([.systemSmall,.systemMedium,.systemLarge,.accessoryInline,.accessoryCircular,.accessoryRectangular])}
}
#endif
struct Wv94:View {
 var e:Zv94; var q:WidgetFamily?=nil; @Environment(\.widgetFamily) var f
 var body:some View {Group {if let c=e.c {
  switch q ?? f {
  case .accessoryInline: HStack {Image(systemName:"soccerball");if c.complete {Text(kc("seasonComplete"))}else if c.next > e.date {Text(kc("matchIn"));Text(c.next,style:.relative)}else{Text(kc("matchReady"))}}
  case .accessoryCircular: VStack {Image(systemName:"soccerball");if c.complete {Text("\(c.round)/14")}else if c.next > e.date{Text(c.next,style:.timer).font(.caption.monospacedDigit())}else{Text(kc("matchReady")).font(.caption2)}}
  case .accessoryRectangular:
   VStack(alignment:.leading) {
    Text(kc(c.complete ? "seasonComplete":"nextMatch")).font(.caption.bold())
    Text(c.complete ? c.club:c.opponent).font(.headline).lineLimit(1)
    if !c.complete {
     if c.next > e.date { HStack { Text(kc("matchIn")); Text(c.next,style:.relative) } }
     else { Text(kc("matchReady")) }
    }
   }.font(.caption)
  case .systemSmall: VStack(alignment:.leading,spacing:10){Label(kc("playerForm"),systemImage:"figure.soccer").font(.caption.bold()).foregroundStyle(.cyan);Text(c.n).font(.headline).lineLimit(1);Text("\(c.ovr)").font(.system(size:36,weight:.bold,design:.rounded));HStack(spacing:4){if c.form.isEmpty{Text(kc("noMatches")).font(.caption2)}else{ForEach(Array(c.form.enumerated()),id:\.offset){_,s in stamp(s)}}}}.foregroundStyle(.white)
  case .systemLarge: VStack(alignment:.leading,spacing:14){header(c);Divider();next(c);Divider();HStack {metric("matches","\(c.round)/14");Spacer();metric("goals","\(c.sg)");Spacer();metric("assists","\(c.sa)");Spacer();metric("trophies","\(c.cups.count)")};HStack {ForEach(Array(c.form.enumerated()),id:\.offset){_,s in stamp(s)};Spacer();Text(kf("positionNumber",c.rank)).font(.caption)};ProgressView(value:Double(c.round),total:14).tint(.cyan)}.foregroundStyle(.white)
  default: HStack(spacing:18){VStack(alignment:.leading,spacing:7){Text(c.n).font(.headline).lineLimit(1);Text(c.club).font(.caption).foregroundStyle(.cyan);Text(kf("seasonNumber",c.year)).font(.caption2);Text("\(c.ovr)").font(.largeTitle.bold())}.frame(maxWidth:.infinity,alignment:.leading);Divider();next(c).frame(maxWidth:.infinity,alignment:.leading)}.foregroundStyle(.white)
  }
 } else {
  switch q ?? f {
  case .accessoryCircular: Image(systemName:"soccerball").font(.title).accessibilityLabel(kc("widgetEmpty"))
  case .accessoryInline: Label("OneXI Career",systemImage:"soccerball")
  case .accessoryRectangular: VStack(alignment:.leading,spacing:4){Image(systemName:"soccerball");Text(kc("widgetEmpty")).font(.caption2).lineLimit(3)}
  default: VStack(alignment:.leading,spacing:8){Image(systemName:"soccerball");Text(kc("widgetEmpty")).font(.caption)}.foregroundStyle(.white)
  }
 }}.widgetURL(URL(string:"clubcareer94://career"))}

 func stamp(_ s:String)->some View {Text(kc("form"+s)).font(.caption2.bold()).frame(minWidth:20,minHeight:23).background(s=="W" ? Color.blue:Color.white.opacity(0.15),in:RoundedRectangle(cornerRadius:5)).accessibilityLabel(kc("result"+s))}
 func header(_ c:Mv7)->some View {HStack{VStack(alignment:.leading){Text(c.n).font(.title2.bold()).lineLimit(1);Text(c.club).font(.caption).foregroundStyle(.cyan)};Spacer();Text(kf("seasonNumber",c.year)).font(.caption)}}
 func metric(_ key:String,_ v:String)->some View {VStack(alignment:.leading){Text(v).font(.title3.bold());Text(kc(key)).font(.caption2)}}
 func next(_ c:Mv7)->some View {
  VStack(alignment:.leading,spacing:6) {
   Text(kc(c.complete ? "seasonComplete":"nextMatch")).font(.caption).foregroundStyle(.cyan)
   Text(c.complete ? kf("positionNumber",c.rank):c.opponent).font(.headline).lineLimit(2)
   if !c.complete {
    if c.next > e.date { HStack(spacing:4) { Text(kc("matchIn")); Text(c.next,style:.relative) }.font(.caption2) }
    else { Text(kc("matchReady")).font(.caption2) }
   }
  }
 }
}
