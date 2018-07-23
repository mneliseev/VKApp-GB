import Foundation

class ResponseGroupByID: Codable {
    let response: [GroupsByID]
    
    init(response: [GroupsByID]) {
        self.response = response
    }
}

class GroupsByID: Codable {
    let id: Int
    let name: String
    let cover: CoverGroup
    var description: String
    var membersCount: Int
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case cover
        case description
        case membersCount = "members_count"
    }
    
    init(id: Int, name: String, cover: CoverGroup, description: String, membersCount: Int) {
        self.id = id
        self.name = name
        self.cover = cover
        self.description = description
        self.membersCount = membersCount
    }
}


class CoverGroup: Codable {
    let images: [Image]
    
    init(images: [Image]) {
        self.images = images
    }
}

class Image: Codable {
    let url: String
    let width, height: Int
    
    init(url: String, width: Int, height: Int) {
        self.url = url
        self.width = width
        self.height = height
    }
}


