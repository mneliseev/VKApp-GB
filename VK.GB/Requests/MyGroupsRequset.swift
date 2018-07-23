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
        Alamofire.request(url, method: .get, parameters: parametres).validate().responseJSON(queue: .global(qos: .userInteractive)) { response in
            switch response.result {
            case .success(let value):
                let groups = JSON(value)["response"]["items"].compactMap({ Groups(json: $0.1) })
                RealmActions.saveGroups(groups)
            case .failure(let error):
                print(error)
            }
        }
    }
}
