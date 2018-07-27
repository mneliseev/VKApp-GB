import Foundation
import Realm
import RealmSwift

class ResponseGroup: Codable {
    let response: UserGroupsResponse
}

class UserGroupsResponse: Codable {
    let count: Int
    let items: [Group]
}

class Group: Object, Codable {
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var image: String = ""
    
    public enum CodingKeys: String, CodingKey {
        case id
        case name
        case image = "photo_100"
    }
}
