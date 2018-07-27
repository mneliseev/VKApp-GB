import Foundation
import Realm
import RealmSwift

class ResponseFriends: Codable {
    let response: UserFriendsResponse
}

class UserFriendsResponse: Codable {
    let count: Int = 0
    let items: [Friends]
}

class Friends: Object, Codable {
    @objc dynamic var id: Int = 0
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var image: String = ""
    @objc dynamic var name: String {
        get {
            return lastName + " " + firstName
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case firstName = "first_name"
        case lastName = "last_name"
        case image = "photo_100"
    }
}
