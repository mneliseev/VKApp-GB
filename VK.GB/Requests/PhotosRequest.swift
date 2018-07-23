import Foundation
import Alamofire
import SwiftyJSON
import RealmSwift

class PhotosRequest {
    
    let baseUrl = "https://api.vk.com"
    let path = "/method"
    
    func getPhotoUsersRequest(userId: String, idFriend: Int) {
        let pathMethod = "/photos.get"
        let url = baseUrl + path + pathMethod
        let parameters: Parameters = [
            "user_id": userId,
            "access_token": VKServices.token,
            "owner_id": idFriend,
            "album_id": "wall",
            "rev": "1",
            "v":"5.60"
        ]
        
        Alamofire.request(url, method: .get, parameters: parameters).validate().responseJSON(queue: .global(qos: .userInteractive)) { response in
            switch response.result {
            case .success(let value):
                let photos = JSON(value)["response"]["items"].compactMap({ Photos(json: $0.1) })
                RealmActions.savePhotos(photos)
            case .failure(let error):
                print(error)
            }
        }
    }
}
