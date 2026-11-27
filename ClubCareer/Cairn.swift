import Foundation
import SwiftUI
import WidgetKit
import UserNotifications

@MainActor final class Br8:ObservableObject {
 @Published var z=Zy8(); @Published var fault:String?; @Published var permission=""; @Published var saving=false
 private var u:URL {FileManager.default.urls(for:.applicationSupportDirectory,in:.userDomainMask)[0].appendingPathComponent("Cairn94",isDirectory:true).appendingPathComponent("journey.json")}
 var current:Mv7? {guard let i=z.selected else{return nil};return z.careers[i]}
 init() {
  do {if FileManager.default.fileExists(atPath:u.path) {let d=try Data(contentsOf:u); let v=try JSONDecoder().decode(Zy8.self,from:d);guard v.careers.allSatisfy(\.valid) else{throw CocoaError(.fileReadCorruptFile)};z=v}}
  catch {fault=kc("saveDamaged")}
  #if DEBUG
  if ProcessInfo.processInfo.arguments.contains("-qa-fresh") {z=Zy8();persist()}
  #endif
 }
 func change(_ f:(inout Mv7)->Void) {guard let i=z.selected else{return};f(&z.careers[i]);persist()}
 func create(_ n:String,_ j:Int,_ p:Int) {guard z.careers.count<4,!n.trimmingCharacters(in:.whitespacesAndNewlines).isEmpty else{return};let c=Mv7(n,j,p);z.careers.append(c);z.active=c.id;persist()}
 func select(_ id:UUID) {z.active=id;persist()}
 func remove(_ id:UUID) {z.careers.removeAll{$0.id==id};if z.active==id {z.active=z.careers.first?.id};persist()}
 func persist() {
  do {try FileManager.default.createDirectory(at:u.deletingLastPathComponent(),withIntermediateDirectories:true);let data=try JSONEncoder().encode(z);try data.write(to:u,options:[.atomic,.completeFileProtectionUntilFirstUserAuthentication])
   if let shared=FileManager.default.containerURL(forSecurityApplicationGroupIdentifier:knGroup) {try data.write(to:shared.appendingPathComponent("widget-career.json"),options:[.atomic,.completeFileProtectionUntilFirstUserAuthentication])}
   WidgetCenter.shared.reloadAllTimelines();Task {await reschedule()}
  } catch {fault=kc("saveFailed")}
 }
 func checkPermission() async {let s=await UNUserNotificationCenter.current().notificationSettings();permission=kc(s.authorizationStatus == .denied ? "permissionDenied" : (s.authorizationStatus == .authorized ? "permissionAllowed":"permissionOff"))}
 func enable(_ b:Bool) async {
  if b {do {let ok=try await UNUserNotificationCenter.current().requestAuthorization(options:[.alert,.sound]);z.reminders=ok;if !ok {permission=kc("permissionDenied")}} catch {fault=kc("notificationError");z.reminders=false}}
  else {z.reminders=false};persist();await checkPermission()
 }
 func reschedule() async {
  let center=UNUserNotificationCenter.current();center.removePendingNotificationRequests(withIdentifiers:["career.next94","career.finish94"])
  guard z.reminders,let c=current,!c.complete else{return}
  let auth=await center.notificationSettings();guard auth.authorizationStatus == .authorized || auth.authorizationStatus == .provisional else{return}
  let items:[(String,String,String,Date)]=[("career.next94",kc("nextMatch"),kf("reminderBody",c.n,c.opponent),c.next),("career.finish94",kc("seasonFinish"),kc("finishReminder"),c.next.addingTimeInterval(Double(14-c.round-1)*86400))]
  for (id,title,body,date) in items where date>Date() {
   let content=UNMutableNotificationContent();content.title=title;content.body=body;content.sound = ProcessInfo.processInfo.environment["GF_SILENT_QA"] == "1" ? nil : .default
   let parts=Calendar.current.dateComponents([.year,.month,.day,.hour,.minute],from:date)
   do {try await center.add(UNNotificationRequest(identifier:id,content:content,trigger:UNCalendarNotificationTrigger(dateMatching:parts,repeats:false)))} catch {fault=kc("notificationError")}
  }
 }
}
