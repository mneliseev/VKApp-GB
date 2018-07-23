import UIKit
import RealmSwift

private let reuseIdentifier = "CellFriendsInfo"

class InfoFriendsCollectionViewController: UICollectionViewController {

    var token: NotificationToken?
    var userId = ""
    var photosFriend: Results<Photos>!
    var idFriend = 0
    let photoRequest = PhotosRequest()
    
    let queque: OperationQueue = {
        let queque = OperationQueue()
        queque.qualityOfService = .userInteractive
        return queque
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Фотографии"
        
        navigationItem.largeTitleDisplayMode = .never
        
        photoRequest.getPhotoUsersRequest(userId: userId, idFriend: idFriend)
        pairTableAndRealm()
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosFriend.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! InfoFriendsCollectionViewCell
        
        let photo = photosFriend[indexPath.row]
        
        let getCacheImage = GetCacheImage(url: photo.photos)
        let setImageToRow = SetImageToRowCollection(cell: cell, indexPath: indexPath, collectionView: collectionView)
        setImageToRow.addDependency(getCacheImage)
        queque.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)

        return cell
    }
    
//    func pairTableAndRealm() {
//        guard let realm = try? Realm() else { return }
//        photosFriend = realm.objects(Photos.self)
//        token = photosFriend.observe( { [weak self] (changes: RealmCollectionChange) in
//            guard let collectionView = self?.collectionView else { return }
//            switch changes {
//            case .initial:
//                collectionView.reloadData()
//            case .update:
//                collectionView.reloadData()
//            case .error(let error):
//                print(error.localizedDescription)
//            }
//        })
//    }
    
    func pairTableAndRealm() {
        guard let realm = try? Realm() else { return }
        photosFriend = realm.objects(Photos.self)
        token = photosFriend.observe( { [weak self] changes in
            guard let collectionView = self?.collectionView else { return }
            switch changes {
            case .initial:
                collectionView.reloadData()
            case .update(_, let delete, let insert, let update):
                collectionView.performBatchUpdates({
                    collectionView.insertItems(at: insert.map { IndexPath(row: $0, section: 0) })
                    collectionView.deleteItems(at: delete.map { IndexPath(row: $0, section: 0) })
                    collectionView.reloadItems(at: update.map { IndexPath(row: $0, section: 0) })
                }, completion: nil)
            case .error(let error):
                print(error.localizedDescription)
            }
        })
    }
}
