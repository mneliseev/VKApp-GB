import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class GroupByIdRequest {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    
    func getInformationAboutGroup(groupId: String, completion: @escaping ([GroupsByID]) -> ()) {
        let pathMethod = "/groups.getById"
        let url = baseUrl + path + pathMethod
        let parameters: Parameters = [
            "group_id": groupId,
            "access_token": VKServices.token,
            "fields": "cover,description,members_count",
            "v":"5.80"
        ]
        
        Alamofire.request(url, parameters: parameters).responseData(queue: .global(qos: .userInteractive)) { response in
            let json = response.data
            do {
                let groupById = try JSONDecoder().decode(ResponseGroupByID.self, from: json!)
                completion(groupById.response)
            } catch let jsonError {
                print("Ошибка получения данных", jsonError)
            }
        }
    }
}

