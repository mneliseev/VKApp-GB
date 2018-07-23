import Foundation
import SwiftyJSON
import RealmSwift

class Friends: Object {
    @objc dynamic var idFriend: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var imageUrl: String!
    @objc dynamic var name: String {
        get {
            return lastName + " " + firstName
        }
    }
    
    convenience init(json: JSON) {
        self.init()
        
        idFriend = json["id"].intValue
        firstName = json["first_name"].stringValue
        lastName = json["last_name"].stringValue
        imageUrl = json["photo_100"].stringValue
    }
}
