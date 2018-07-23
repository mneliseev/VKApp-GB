import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class AllGroupsRequest {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    
    func getSearchGroupRequest(searchText: String, completion: @escaping ([Groups]) -> ()) {
        let pathMethod = "/groups.search"
        let url = baseUrl + path + pathMethod
        let parameters: Parameters = [
            "q": searchText.lowercased(),
            "access_token": VKServices.token,
            "sort": "3",
            "type": "group",
            "v":"5.73"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseJSON(queue: .global(qos: .userInteractive)) { response in
            switch response.result {
            case .success(let value):
                let searchGroups = JSON(value)["response"]["items"].compactMap({ Groups(json: $0.1) })
                completion(searchGroups)
            case .failure(let error):
                print(error)
            }
        }
    }
}
