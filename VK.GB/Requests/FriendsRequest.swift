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
            "fields": "last_name, first_name, photo_100",
            "v": "5.80"
        ]
    
        Alamofire.request(url, parameters: parametres).responseData(queue: .global(qos: .userInteractive)) { response in
            let json = response.data
            do {
                let users = try JSONDecoder().decode(ResponseFriends.self, from: json!)
                RealmActions.saveFriends(users.response.items)
            } catch let jsonError {
                print("Ошибка получения данных", jsonError)
            }
        }
    }
}
