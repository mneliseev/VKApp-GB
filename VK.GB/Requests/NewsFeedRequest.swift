import Foundation
import Alamofire
import SwiftyJSON

class NewsFeedRequest {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    
    func getNewsRequest(userId: String, accesToken: String, completion: @escaping ([News]) -> ()) {
        let pathMethod = "/newsfeed.get"
        let url = baseUrl + path + pathMethod
        let parameters: Parameters = [
            "access_token": VKServices.token,
            "filters": "post",
            "count": "20",
            "v":"5.74"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseJSON(queue: .global(qos: .userInteractive)) { response in
            switch response.result {
            case .success(let value):
                let news = JSON(value)["response"]["items"].compactMap({ News(json: $0.1) })
                let newsProfiles = JSON(value)["response"]["profiles"].compactMap({ News(jsonAuthorProfiles: $0.1) })
                let newsGroups = JSON(value)["response"]["groups"].compactMap({ News(jsonAuthorGroups: $0.1) })
                
                for i in 0..<news.count {
                    if news[i].newsSourceId < 0 {
                        for y in 0..<newsGroups.count {
                            if news[i].newsSourceId * -1 == newsGroups[y].newsPostId {
                                news[i].newsAuthor = newsGroups[y].newsAuthor
                                news[i].newsPhotoAuthor = newsGroups[y].newsPhotoAuthor
                                news[i].newsPostId = newsGroups[y].newsPostId
                            }
                        }
                    } else {
                        for x in 0..<newsProfiles.count {
                            if news[i].newsSourceId == newsProfiles[x].newsPostId {
                                news[i].newsAuthor = newsProfiles[x].newsAuthor
                                news[i].newsPhotoAuthor = newsProfiles[x].newsPhotoAuthor
                                news[i].newsPostId = newsProfiles[x].newsPostId
                            }
                        }
                    }
                }
                
                completion(news)
            case .failure(let error):
                print(error)
            }
        }
    }
}
