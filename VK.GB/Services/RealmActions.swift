import Foundation
import RealmSwift

class RealmActions {
    
    static func saveFriends(_ friends: [Friends]) {
        do {
            let realm = try Realm()
//            print(realm.configuration.fileURL)
            let oldFriends = realm.objects(Friends.self)
            realm.beginWrite()
            realm.delete(oldFriends)
            realm.add(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func saveGroups(_ groups: [Group]) {
        do {
            let realm = try Realm()
            let oldGroups = realm.objects(Group.self)
            realm.beginWrite()
            realm.delete(oldGroups)
            realm.add(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func savePhotos(_ photos: [Photos]) {
        do {
            let realm = try Realm()
            let oldPhotos = realm.objects(Photos.self)
            realm.beginWrite()
            realm.delete(oldPhotos)
            realm.add(photos)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func addGroupFromSearchToRealm(_ groups: [Group]) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(groups)
            }
        } catch {
            print(error)
        }
    }
    
    static func deleteGroup(_ groups: [Group]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(groups)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }
    
    static func deleteFriend(_ friends: [Friends]) {
        do {
            let realm = try Realm()
            realm.beginWrite()
            realm.delete(friends)
            try realm.commitWrite()
        } catch {
            print(error)
        }
    }

//    static func loadFriends(userId: String) -> Friends? {
//        do {
//            let realm = try Realm()
//            let users = realm.objects(Friends.self).filter("id == %@", userId)
//            return Array(users).first
//        } catch {
//            print(error)
//        }
//        return nil
//    }
//
//    static func loadPhotosData(userId: String) -> Results<Photos>? {
//        if let owner = RealmActions.loadFriends(userId: userId) {
//            do {
//                let realm = try Realm()
//                return realm.objects(Photos.self).filter("owner == %@", owner)
//            } catch {
//                print(error)
//            }
//        }
//        return nil
//    }
//    static func loadPhotosData() -> [Photos] {
//        do {
//            let realm = try Realm()
//            let photos = realm.objects(Photos.self).filter("ownerID == %@")
//            return Array(photos)
//        } catch {
//            print(error)
//        }
//        return []
//    }
}

