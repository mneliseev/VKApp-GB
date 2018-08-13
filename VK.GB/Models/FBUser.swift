
import Foundation
import Firebase

struct UserFB {
    var id: String
    
    var toAnyObject: Any {
        return [
            "UserId": id,
        ]
    }
}

