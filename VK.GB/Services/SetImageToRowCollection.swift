
import UIKit

class SetImageToRowCollection: Operation {
    
    private let indexPath: IndexPath
    private weak var collectionView: UICollectionView?
    private var cell: InfoFriendsCollectionViewCell?
    
    init(cell: InfoFriendsCollectionViewCell, indexPath: IndexPath, collectionView: UICollectionView) {
        
        self.indexPath = indexPath
        self.collectionView = collectionView
        self.cell = cell
    }
    
    override func main() {
        
        guard let collectionView = collectionView,
            let cell = cell,
            let getCacheImage = dependencies[0] as? GetCacheImage,
            let image = getCacheImage.outputImage else { return }
        
        if let newIndexPath = collectionView.indexPath(for: cell),
            newIndexPath == indexPath {
            cell.photoFriend.image = image
        } else if collectionView.indexPath(for: cell) == nil {
            cell.photoFriend.image = image
        }
    }
}
