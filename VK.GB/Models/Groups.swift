import Foundation
import SwiftyJSON
import RealmSwift

class Groups: Object {
    
    @objc dynamic var groupId: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var imageUrl: String!
    
    convenience init(json: JSON) {
        self.init()
        
        groupId = json["id"].stringValue
        name = json["name"].stringValue
        imageUrl = json["photo_100"].stringValue
    }
    
//    override static func primaryKey() -> String? {
//        return "groupId"
//    }
}
