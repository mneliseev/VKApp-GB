import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class FriendsRequest {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    
    func getFriendsRequest(userId: String) {
        
        let pathMethod = "/friends.get"
        let url = baseUrl + path + pathMethod
        let parametres: Parameters = [
            "user_id": userId,
            "access_token": VKServices.token,
            "order": "name",
            "fields": "uid, first_name, last_name, photo_100",
            "v": "5.80"
        ]
        
        Alamofire.request(url, method: .get, parameters: parametres).validate().responseJSON(queue: .global(qos:.userInteractive)) { response in
            switch response.result {
            case .success(let value):
                let users = JSON(value)["response"]["items"].compactMap({ Friends(json: $0.1) })
                RealmActions.saveFriends(users)
            case .failure(let error):
                print(error)
            }
        }
    }
}
