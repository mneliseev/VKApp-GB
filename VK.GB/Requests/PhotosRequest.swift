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
        
        Alamofire.request(url, parameters: parameters).responseData(queue: .global(qos: .userInteractive)) { response in
            let json = response.data
            do {
                let userPhoto = try JSONDecoder().decode(ResponsePhotoFriends.self, from: json!)
                RealmActions.savePhotos(userPhoto.response.items)
            } catch let jsonError {
                print("Ошибка получения данных", jsonError)
            }
        }
    }
}
