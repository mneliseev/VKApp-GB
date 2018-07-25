import Foundation
import SwiftyJSON

class News {

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

        newsSourceId = json["source_id"].intValue
        postId = json["post_id"].intValue
        
        newsText = json["text"].stringValue
        if newsText == "" {
            self.newsText = json["copy_history"][0]["text"].stringValue
        }
        
        if let photoNews = json["attachments"][0]["photo"]["sizes"][3]["url"].string {
            self.attachmentsPhoto = photoNews
        } else if let photoNews = json["copy_history"][0]["attachments"][0]["doc"]["preview"]["photo"]["sizes"][2]["src"].string {
            self.attachmentsPhoto = photoNews
        } else if let photoNews = json["attachments"][0]["video"]["photo_640"].string {
            self.attachmentsPhoto = photoNews
        } else if let photoNews = json["copy_history"][0]["attachments"][0]["photo"]["sizes"][4]["url"].string {
            self.attachmentsPhoto = photoNews
        } else if let photoNews = json["attachments"][0]["link"]["photo"]["sizes"][5]["url"].string {
            self.attachmentsPhoto = photoNews
        } else {
            self.attachmentsPhoto = ""
        }
       
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
}
