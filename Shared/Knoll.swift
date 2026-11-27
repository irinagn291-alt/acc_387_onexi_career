import Foundation

struct Vq9: Codable, Identifiable, Equatable {
 var id = UUID(); var k:String; var y:Int; var c:String
}
struct Lz3: Codable, Identifiable, Equatable {
 var id:Int; var n:String; var p=0; var w=0; var d=0; var gf=0; var ga=0
 var pts:Int { w*3+d }; var gd:Int { gf-ga }
 mutating func f(_ a:Int,_ b:Int) { p+=1; gf+=a; ga+=b; if a>b {w+=1} else if a==b {d+=1} }
}
struct Nd6: Codable, Identifiable, Equatable {
 var id=UUID(); var s:Int; var r:Int; var a:String; var b:String; var x:Int; var y:Int; var g:Int; var h:Int; var z:Double; var e:[String]; var t:Int
 var f:String { x>y ? "W" : (x==y ? "D" : "L") }
}
struct Qh4: Codable, Identifiable, Equatable {
 var id=UUID(); var y:Int; var c:String; var rank:Int; var pts:Int; var g:Int; var a:Int
}
struct Mv7: Codable, Identifiable, Equatable {
 var id=UUID(); var n:String; var j:Int; var role:Int; var tier=0; var year=1; var round=0
 var skills:[Int]; var energy=100; var practice=8; var recovery=false
 var matches=0; var goals=0; var assists=0; var reputation=0; var clean=0
 var sg=0; var sa=0; var sc=0; var sr:Double=0
 var seed:UInt64; var history:[Nd6]=[]; var cups:[Vq9]=[]; var seasons:[Qh4]=[]
 var table:[Lz3]=[]; var next:Date=Date().addingTimeInterval(86400); var last:Nd6?
 static let clubs=["Lumen Academy","Harbor Athletic","Northbridge FC","Aster City","Summit United"]
 static let fields=["finishing","passing","pace","defending","stamina"]
 static let positions=["striker","midfielder","defender"]
 static let tiers=["academy","district","professional","premier","elite"]
 init(_ name:String,_ shirt:Int,_ position:Int,seed:UInt64=UInt64.random(in:1...UInt64.max)) {
  n=String(name.trimmingCharacters(in:.whitespacesAndNewlines).prefix(30)); j=max(1,min(99,shirt)); role=max(0,min(2,position)); self.seed=max(1,seed)
  skills=[44,44,44,44,44]; skills[[0,1,3][role]]=54; skills[2]=48
  u0()
 }
 var club:String { Self.clubs[tier] }; var ovr:Int { skills.reduce(0,+)/5 }
 var complete:Bool { round>=14 }
 var sorted:[Lz3] { table.sorted { a,b in if a.pts != b.pts {return a.pts>b.pts}; if a.gd != b.gd {return a.gd>b.gd}; if a.gf != b.gf {return a.gf>b.gf}; return a.id<b.id } }
 var rank:Int { (sorted.firstIndex(where:{$0.id==0}) ?? 7)+1 }
 var form:[String] { Array(history.suffix(5).map(\.f)) }
 var average:Double { round>0 ? sr/Double(round) : 0 }
 var cost:[Int] { skills.map { 2+max(0,$0-40)/15 } }
 var offers:[Int] { guard complete, tier<4 else{return []}; let t=tier+1; return ovr >= 46+t*4 && matches>=t*14 && reputation>=t*10 ? [t] : [] }
 var nextPair:(Int,Int) { guard !complete else{return (0,1)}; return schedule(round).first(where:{$0.0==0 || $0.1==0}) ?? (0,1) }
 var rival:Int { let p=nextPair; return p.0==0 ? p.1 : p.0 }
 var opponent:String { table.indices.contains(rival) ? table[rival].n : "—" }
 var valid:Bool { skills.count==5 && skills.allSatisfy{(1...99).contains($0)} && (0...4).contains(tier) && (0...2).contains(role) && (0...14).contains(round) && table.count==8 && table.map(\.id)==Array(0..<8) && (0...100).contains(energy) && practice>=0 && year>0 }
 mutating func u0() {
  let rivals=["Cedar Rovers","Vale Athletic","Orion FC","Riverside","Bluehaven","Atlas Town","Aurora SC"]
  table=[Lz3(id:0,n:club)]+rivals.enumerated().map{Lz3(id:$0.offset+1,n:$0.element)}
 }
 func schedule(_ r:Int)->[(Int,Int)] {
  var a=Array(0..<8)
  for _ in 0..<(r%7) { a.insert(a.removeLast(),at:1) }
  return (0..<4).map { i in let flip=((r%7)%2==1) != (r>=7); return flip ? (a[7-i],a[i]) : (a[i],a[7-i]) }
 }
 mutating func rnd()->Double { seed=seed &* 6364136223846793005 &+ 1442695040888963407; return Double(seed>>11)/9007199254740992 }
 mutating func poisson(_ rate:Double)->Int { let limit=exp(-rate); var p=1.0; var k=0; repeat { k+=1; p *= max(0.000001,rnd()) } while p>limit && k<9; return k-1 }
 mutating func train(_ i:Int)->Bool {
  guard !complete,skills.indices.contains(i),skills[i]<99,energy>=6,practice>=cost[i] else{return false}
  practice-=cost[i]; skills[i]+=1; energy-=6; return true
 }
 mutating func rest()->Bool { guard !complete,!recovery,energy<100 else{return false}; energy=min(100,energy+30); recovery=true; return true }
 mutating func play(_ tactic:Int)->Nd6? {
  guard !complete else{return nil}
  let t=max(0,min(2,tactic)); let pair=nextPair; let opp=opponent; let home=pair.0==0
  let team=Double(46+tier*10); let personal=Double(skills[[0,1,3][role]])
  let condition=0.62+Double(energy)*0.0038
  let edge=(Double(ovr)*0.45+personal*0.2+team*0.35)*condition-(team+Double(rival-4)*1.4)
  let rate=max(0.25,min(3.5,1.25+edge/32+(home ? 0.18:0)+(t==1 ? 0.28:0)-(t==2 ? 0.2:0)))
  let against=max(0.25,min(3.2,1.25-edge/50+(t==1 ? 0.25:0)-(t==2 ? 0.27:0)-Double(skills[3]-44)/160))
  let x=poisson(rate), y=poisson(against)
  var g=0,a=0
  if x>0 {for _ in 0..<x {if rnd()<[0.42,0.22,0.11][role]+Double(skills[0]-44)/260 {g+=1} else if rnd()<[0.22,0.52,0.2][role]+Double(skills[1]-44)/300 {a+=1}}}
  let rating=max(3.5,min(10,5.6+Double(g)*0.9+Double(a)*0.65+(x>y ? 0.7:0)+(role==2 && y==0 ? 0.8:0)+(rnd()-0.5)*1.2+Double(energy-70)/180))
  var events:[String]=[t==1 ? "eventAttack" : (t==2 ? "eventShape":"eventBalanced")]
  if g>0 {events.append("eventGoal")}; if a>0 {events.append("eventAssist")}; if y==0 {events.append("eventClean")}; events.append(x>y ? "eventWin" : (x==y ? "eventDraw":"eventLoss"))
  let out=Nd6(s:year,r:round+1,a:club,b:opp,x:x,y:y,g:g,h:a,z:rating,e:events,t:t)
  for p in schedule(round) {
   let hx:Int,hy:Int
   if p.0==0 {hx=x;hy=y} else if p.1==0 {hx=y;hy=x} else {hx=poisson(1.45);hy=poisson(1.15)}
   table[p.0].f(hx,hy); table[p.1].f(hy,hx)
  }
  round+=1; matches+=1; goals+=g; assists+=a; sg+=g; sa+=a; sr+=rating
  if y==0 {clean+=1;sc+=1}; reputation+=max(1,Int(rating)-4)
  practice+=4+(rating>=8 ? 2:0); energy=max(30,energy-(18-(skills[4]-40)/8)); recovery=false
  history.append(out); if history.count>200 {history.removeFirst()}; last=out; next=Date().addingTimeInterval(86400)
  if complete {
   seasons.append(Qh4(y:year,c:club,rank:rank,pts:table[0].pts,g:sg,a:sa))
   if rank==1 {award("champion")}; if sg>=10 {award("scorer")}; if sa>=8 {award("creator")}; if sc>=5 {award("guardian")}
  }
  return out
 }
 mutating func award(_ k:String) {if !cups.contains(where:{$0.k==k && $0.y==year}) {cups.append(Vq9(k:k,y:year,c:club))}}
 mutating func advance(_ destination:Int?=nil)->Bool {
  guard complete else{return false}; if let d=destination {guard offers.contains(d) else{return false};tier=d}
  year+=1; round=0; sg=0;sa=0;sc=0;sr=0;energy=100;recovery=false;last=nil;next=Date().addingTimeInterval(86400);u0();return true
 }
 var legends:[Bool] { [matches>=1,matches>=28,cups.contains{$0.k=="champion"},tier==4,matches>=100 && ovr>=80] }
}
struct Zy8: Codable {
 var careers:[Mv7]=[]; var active:UUID?; var reminders=false
 var selected:Int? {careers.firstIndex{$0.id==active}}
}
