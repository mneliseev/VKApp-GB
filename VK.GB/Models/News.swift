import Foundation
import SwiftyJSON

class News {

    //Фотографии новостей
    
    var id: Int = 0
    var ownerId: Int = 0
    var smallImage: String = ""
    var bigImage: String = ""
    
    //Фото и название группы или пользователя
    var newsAuthor: String = ""
    var newsPhotoAuthor: String = ""
    var newsPostId: Int = 0
    
    var attachmentsPhoto: String = ""
    var attachmentSize: String = ""
    
    var newsSourceId: Int = 0
    var postId: Int = 0
    var newsDate: String = ""
    var newsText: String = ""
    var newsCommentsCount: Int = 0
    var newsLikesCount: Int = 0
    var newsRepostsCount: Int = 0
    var newsViewsCount: Int = 0
    
    init(json: JSON) {

        newsText = json["text"].stringValue
        newsSourceId = json["source_id"].intValue
        postId = json["post_id"].intValue
        
//        let unixTime = json["date"].doubleValue
//        self.newsDate = timeAgoSince(unixTime)
        
        attachmentsPhoto = json["attachments"][0]["photo"]["sizes"][3]["url"].stringValue
       
        newsCommentsCount = json["comments"]["count"].intValue
        newsLikesCount = json["likes"]["count"].intValue
        newsRepostsCount = json["reposts"]["count"].intValue
        newsViewsCount = json["views"]["count"].intValue
    }
    
    init(jsonAuthorProfiles json: JSON) {
        newsAuthor = json["first_name"].stringValue + " " + json["last_name"].stringValue
        newsPhotoAuthor = json["photo_100"].stringValue
        newsPostId = json["id"].intValue
    }
    
    init(jsonAuthorGroups json: JSON) {
        newsAuthor = json["name"].stringValue
        newsPhotoAuthor = json["photo_100"].stringValue
        newsPostId = json["id"].intValue
    }
    
//    init(jsonAttachment json: JSON) {
//        id = json["attachments", 0, "photo", "id"].intValue
//        ownerId = json["attachments", 0, "photo", "owner_id"].intValue
//        smallImage = json["attachments", 0, "photo", "photo_130"].stringValue
//        bigImage = json["attachments", 0, "photo", "photo_604"].stringValue
//    }
}
