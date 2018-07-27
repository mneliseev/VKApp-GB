import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class MyGroupsRequest {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    
    func getGroupsRequest(userId: String, accesToken: String) {
        let pathMethod = "/groups.get"
        let url = baseUrl + path + pathMethod
        let parametres: Parameters = [
            "user_id": userId,
            "access_token": VKServices.token,
            "extended": "1",
            "v": "5.80"
        ]
        
        Alamofire.request(url, parameters: parametres).responseData(queue: .global(qos: .userInteractive)) { response in
            let json = response.data
            do {
                let myGroup = try JSONDecoder().decode(ResponseGroup.self, from: json!)
                RealmActions.saveGroups(myGroup.response.items)
            } catch let jsonError {
                print("Ошибка получения данных", jsonError)
            }
        }
    }
}
