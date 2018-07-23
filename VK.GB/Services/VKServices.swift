import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class VKServices {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    static var token = ""
    
    static func authRequest() -> URLRequest {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "6395279"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "270342"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.73")
        ]
        
        let request = URLRequest(url: urlComponents.url!)
        return request
    }
}
// 2+4+8192+262144
