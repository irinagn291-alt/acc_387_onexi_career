import Foundation
func kc(_ key:String)->String { NSLocalizedString(key,tableName:"CareerWords",bundle:kx94,value:key,comment:"") }
func kf(_ key:String,_ values:CVarArg...)->String {String(format:kc(key),locale:Locale.current,arguments:values)}
let knGroup="group.app.lumenpath.clubcareer.ember94"

#if CAREER_CHECKS
let kx94:Bundle = { let q=Bundle(for:Os94.self);return q.url(forResource:"en",withExtension:"lproj").flatMap{Bundle(url:$0)} ?? q }()
#else
let kx94=Bundle.main
#endif
