import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class AllGroupsRequest {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    
    func getSearchGroupRequest(searchText: String, completion: @escaping ([Group]) -> ()) {
        let pathMethod = "/groups.search"
        let url = baseUrl + path + pathMethod
        let parameters: Parameters = [
            "q": searchText.lowercased(),
            "access_token": VKServices.token,
            "sort": "3",
            "type": "group",
            "v":"5.73"
        ]

        Alamofire.request(url, parameters: parameters).responseData(queue: .global(qos: .userInteractive)) { response in
            let json = response.data
            do {
                let myGroup = try JSONDecoder().decode(ResponseGroup.self, from: json!)
                completion(myGroup.response.items)
            } catch let jsonError {
                print("Ошибка получения данных", jsonError)
            }
        }
    }
    
    func joinGroup(groupId: Int) {
        let pathMethod = "groups.join"
        
        let parameters: Parameters = [
            "group_id" : groupId,
            "access_token" : VKServices.token,
            "v" : "5.80"]
        let url = baseUrl + path + pathMethod
        
        Alamofire.request(url, parameters: parameters).responseData(queue: .global(qos: .userInteractive)) { response in
        }
    }
    
    func leaveGroup(groupId: Int) {
        let pathMethod = "groups.leave"
        
        let parameters: Parameters = [
            "group_id" : groupId,
            "access_token" : VKServices.token,
            "v" : "5.80"]
        let url = baseUrl + path + pathMethod
        
        Alamofire.request(url, parameters: parameters).responseData(queue: .global(qos: .userInteractive)) { response in
        }
    }
}
