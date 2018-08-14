import UIKit
import RealmSwift

private let reuseIdentifier = "CellFriendsInfo"

class InfoFriendsCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var token: NotificationToken?
    var userId = ""
    var photosFriend: Results<Photos> = {
        let realm = try? Realm()
        return realm!.objects(Photos.self).sorted(byKeyPath: "ownerID")
    }()
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? InfoFriendsCollectionViewCell
        
        guard let friendPhotoCell = cell else { return UICollectionViewCell() }
        
        let photo = photosFriend[indexPath.row]
        
        let getCacheImage = GetCacheImage(url: photo.image)
        let setImageToRow = SetImageToRowCollection(cell: friendPhotoCell, indexPath: indexPath, collectionView: collectionView)
        setImageToRow.addDependency(getCacheImage)
        queque.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)
        
        return friendPhotoCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellSize = CGSize(width: (collectionView.bounds.width - 2)/3, height: 100)
        return cellSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets
    {
        let sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        return sectionInset
    }
    
    func pairTableAndRealm() {
        token = photosFriend.observe({ [weak self] change in
            guard let collection = self?.collectionView else {
                return
            }
            switch change {
            case RealmCollectionChange.initial:
                collection.reloadData()
            case RealmCollectionChange.update(_, let delete, let insert, let update):
                collection.performBatchUpdates({
                    collection.deleteItems(at: delete.map { IndexPath(row: $0, section:0) })
                    collection.insertItems(at: insert.map { IndexPath(row: $0, section:0) })
                    collection.reloadItems(at: update.map { IndexPath(row: $0, section:0) })
                }, completion: nil)
            case .error(let error):
                print(error.localizedDescription)
            }
        })
    }
    
}
