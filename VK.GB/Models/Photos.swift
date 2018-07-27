import Foundation
import Realm
import RealmSwift

class ResponsePhotoFriends: Codable {
    let response: UserPhotoResponse
}

class UserPhotoResponse: Codable {
    let count: Int = 0
    let items: [Photos]
}

class Photos: Object, Codable {
    @objc dynamic var ownerID: Int = 0
    @objc dynamic var image: String = ""
    
    enum CodingKeys: String, CodingKey {
        case ownerID = "owner_id"
        case image = "photo_604"
    }
}

