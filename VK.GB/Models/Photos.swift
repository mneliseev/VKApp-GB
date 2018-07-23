import Foundation
import SwiftyJSON
import RealmSwift

class Photos: Object {
    @objc dynamic var idUser: Int = 0
    @objc dynamic var photos: String!
    
    convenience init(json: JSON) {
        self.init()
        idUser = json["owner_id"].intValue
        photos = json["photo_604"].stringValue
    }
}
