import XCTest
import UIKit
import SwiftUI
import WidgetKit

final class Os94:XCTestCase {
 @MainActor func testWidgetLayouts() throws {
  XCTAssertEqual(kc("playerForm"),"Player form")
  var c=Mv7("Layout QA",9,1,seed:94);for _ in 0..<4 {_=c.play(0)}
  let sizes:[(WidgetFamily,CGFloat,CGFloat)]=[(.systemSmall,170,170),(.systemMedium,340,170),(.systemLarge,340,360),(.accessoryInline,260,32),(.accessoryCircular,76,76),(.accessoryRectangular,172,76)]
  for (family,width,height) in sizes { for empty in [false,true] {
   let content=Wv94(e:Zv94(date:Date(),c:empty ? nil:c),q:family).environment(\.colorScheme,.dark).environment(\.locale,Locale(identifier:"en_US")).padding(family == .systemSmall || family == .systemMedium || family == .systemLarge ? 14:2).frame(width:width,height:height).background(Color(red:7/255,green:20/255,blue:40/255))
   let renderer=ImageRenderer(content:content);renderer.scale=3
   let img=try XCTUnwrap(renderer.uiImage);XCTAssertGreaterThan(img.size.width,0)
   let attachment=XCTAttachment(image:img);attachment.name=(empty ? "widget-empty-":"widget-")+String(describing:family);attachment.lifetime = .keepAlways;add(attachment)
  }}
 }

 func testLeagueIntegrityAndPersistence() throws {
  for role in 0..<3 {
   var c=Mv7("River",9,role,seed:UInt64(role+42));var seen:[Int:Int]=[:]
   for round in 0..<14 {
    XCTAssertEqual(c.round,round);seen[c.rival,default:0]+=1
    if round<7 { let first=c.schedule(round),second=c.schedule(round+7);XCTAssertTrue(zip(first,second).allSatisfy{$0.0.0 == $0.1.1 && $0.0.1 == $0.1.0}) };let pairs=c.schedule(round);XCTAssertEqual(Set(pairs.flatMap{[$0.0,$0.1]}).count,8)
    let m=try XCTUnwrap(c.play(round%3));XCTAssertLessThanOrEqual(m.g+m.h,m.x);XCTAssertTrue((3.5...10).contains(m.z));XCTAssertTrue(c.valid)
   }
   XCTAssertEqual(seen.count,7);XCTAssertTrue(seen.values.allSatisfy{$0==2});XCTAssertTrue(c.table.allSatisfy{$0.p==14});XCTAssertEqual(c.table.reduce(0){$0+$1.gf},c.table.reduce(0){$0+$1.ga});XCTAssertEqual(c.seasons.count,1)
   XCTAssertNil(c.play(0));let data=try JSONEncoder().encode(c);XCTAssertEqual(try JSONDecoder().decode(Mv7.self,from:data),c)
   let goals=c.goals;XCTAssertTrue(c.advance());XCTAssertEqual(c.year,2);XCTAssertEqual(c.goals,goals);XCTAssertEqual(c.round,0);XCTAssertTrue(c.table.allSatisfy{$0.p==0})
  }
 }
 func testTrainingRecoveryAndOffers() {
  var c=Mv7("Nova",10,1,seed:9);let skill=c.skills[1],cost=c.cost[1]
  XCTAssertTrue(c.train(1));XCTAssertEqual(c.skills[1],skill+1);XCTAssertEqual(c.practice,8-cost);XCTAssertEqual(c.energy,94);XCTAssertTrue(c.rest());XCTAssertFalse(c.rest());XCTAssertFalse(c.train(9));XCTAssertFalse(c.advance(1))
  while !c.complete {_=c.play(0)};c.skills=Array(repeating:70,count:5);XCTAssertEqual(c.offers,[1]);XCTAssertTrue(c.advance(1));XCTAssertEqual(c.tier,1);XCTAssertEqual(c.club,"Harbor Athletic");XCTAssertEqual(c.matches,14)
 }
 func testLongCareerAndSkillImpact() {
  var weakWins=0,strongWins=0
  for seed in 1...200 {
   var a=Mv7("A",1,0,seed:UInt64(seed)),b=a;b.skills=Array(repeating:95,count:5)
   for _ in 0..<14 {if a.play(0)!.f=="W" {weakWins+=1};if b.play(0)!.f=="W" {strongWins+=1}}
  };XCTAssertGreaterThan(strongWins,weakWins)
  var c=Mv7("Long",99,2,seed:77);c.skills=Array(repeating:95,count:5)
  for _ in 0..<10 {for _ in 0..<14{_ = c.play(0)};if let d=c.offers.first{XCTAssertTrue(c.advance(d))}else{XCTAssertTrue(c.advance())}}
  XCTAssertEqual(c.matches,140);XCTAssertEqual(c.tier,4);XCTAssertTrue(c.legends[4]);XCTAssertEqual(c.seasons.count,10)
 }
}
@MainActor final class Ui94:XCTestCase {
 func shot(_ label:String) {let x=XCTAttachment(screenshot:XCUIApplication().screenshot());x.name=label;x.lifetime = .keepAlways;add(x)}
 func tap(_ app:XCUIApplication,_ id:String) {let a=app.buttons[id];for _ in 0..<6 {if a.isHittable {break};app.swipeUp()};XCTAssertTrue(a.waitForExistence(timeout:5),id);a.tap()}
 func selectTab(_ app: XCUIApplication, _ title: String) {
  let tab = app.buttons.matching(NSPredicate(format: "label == %@", title)).firstMatch
  XCTAssertTrue(tab.waitForExistence(timeout: 5), title)
  tab.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.5)).tap()
 }
 func refuse(_ app:XCUIApplication) {
  for host in [app,XCUIApplication(bundleIdentifier:"com.apple.springboard")] {
   let alert=host.alerts.firstMatch
   if alert.waitForExistence(timeout:2) {let deny=alert.buttons.matching(NSPredicate(format:"label CONTAINS[c] %@","Don")).firstMatch;if deny.exists {deny.tap();return}else if alert.buttons.count==2 {alert.buttons.firstMatch.tap();return}}
  }
 }
 func testFullJourney() {
  let app=XCUIApplication();app.launchArguments=["-qa-fresh","-AppleLanguages","(en)","-AppleLocale","en_US"];app.launch()
  XCTAssertTrue(app.textFields["playerName"].waitForExistence(timeout:15));shot("01-create")
  let field=app.textFields["playerName"];field.tap();field.typeText("Alex Rivera");app.swipeUp();tap(app,"beginCareer")
  XCTAssertTrue(app.buttons["playMatch"].waitForExistence(timeout:10));shot("02-career")
  if UIDevice.current.userInterfaceIdiom == .pad {XCUIDevice.shared.orientation = .landscapeLeft;shot("02b-ipad-landscape");XCUIDevice.shared.orientation = .portrait}

  tap(app,"playMatch");XCTAssertTrue(app.buttons["continueCareer"].waitForExistence(timeout:5));shot("03-match");tap(app,"continueCareer")
  selectTab(app, "Training");tap(app,"train0");XCTAssertTrue(app.staticTexts["trainingFeedback"].exists);shot("04-training");app.swipeUp();tap(app,"recovery")
  selectTab(app, "Clubs");shot("05-clubs");selectTab(app, "Legacy");shot("06-legacy")
  selectTab(app, "Career")
  for _ in 0..<13 {tap(app,"playMatch");tap(app,"continueCareer")}
  selectTab(app, "Legacy");app.swipeUp();shot("07-season-archive")
  selectTab(app, "Clubs");tap(app,"nextSeason");selectTab(app, "Career");shot("08-next-season")
  app.terminate();app.launchArguments=["-AppleLanguages","(en)"];app.launch();XCTAssertTrue(app.staticTexts["Alex Rivera"].waitForExistence(timeout:10));XCTAssertTrue(app.buttons["playMatch"].exists)
  tap(app,"settings");shot("09-settings")
  let toggle=app.switches["reminderToggle"];if toggle.exists {toggle.coordinate(withNormalizedOffset:CGVector(dx:0.92,dy:0.5)).tap();refuse(app);shot("09b-notifications-denied")}
  app.buttons["Done"].tap();XCTAssertTrue(app.buttons["playMatch"].exists)

 }
 func testLocalizedLaunches() {
  for (lang,title) in [("de","Dein erster Schritt nach oben."),("fr","Le premier pas vers les sommets."),("es","Tu primer paso hacia la cima."),("pt-BR","Seu primeiro passo para o sucesso.")] {
   let app=XCUIApplication();app.launchArguments=["-qa-fresh","-AppleLanguages","(\(lang))"];app.launch();XCTAssertTrue(app.staticTexts[title].waitForExistence(timeout:10));shot("locale-"+lang);app.terminate()
  }
 }
 func testRussianAndLargeText() {
  let app=XCUIApplication();app.launchArguments=["-qa-fresh","-AppleLanguages","(ru)","-AppleLocale","ru_RU","-UIPreferredContentSizeCategoryName","UICTContentSizeCategoryAccessibilityM"];app.launch();XCTAssertTrue(app.textFields["playerName"].waitForExistence(timeout:15));shot("10-russian-accessibility")
 }
 func testWidgetSnapshotAndNotificationDenial() {
  let app=XCUIApplication();app.launchArguments=["-qa-fresh","-AppleLanguages","(en)","-AppleLocale","en_US"];app.launch()
  let field=app.textFields["playerName"];XCTAssertTrue(field.waitForExistence(timeout:10));field.tap();field.typeText("Mila Stone");app.swipeUp();tap(app,"beginCareer");tap(app,"playMatch");tap(app,"continueCareer")
  tap(app,"settings");let toggle=app.switches["reminderToggle"];toggle.coordinate(withNormalizedOffset:CGVector(dx:0.92,dy:0.5)).tap()
  refuse(app)
  XCTAssertTrue(app.staticTexts["Notifications are disabled in system settings. All game features still work."].waitForExistence(timeout:5))
  shot("11-reminder-permission");app.buttons["Done"].tap();tap(app,"playMatch");tap(app,"continueCareer");shot("12-widget-source-career")
 }

}
