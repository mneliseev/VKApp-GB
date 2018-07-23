
import UIKit

class SetImageToRowTableView: Operation {
    
    private let indexPath: IndexPath
    private weak var tableView: UITableView?
    private var cell: UITableViewCell?
    
    init(cell: UITableViewCell, indexPath: IndexPath, tableView: UITableView) {
        
        self.indexPath = indexPath
        self.tableView = tableView
        self.cell = cell
    }
    
    override func main() {
        
        guard let tableView = tableView,
            let cell = cell,
            let getCacheImage = dependencies[0] as? GetCacheImage,
            let image = getCacheImage.outputImage else { return }
        
        if let newIndexPath = tableView.indexPath(for: cell),
            newIndexPath == indexPath {
            setImage(image, toCell: cell)
        } else if tableView.indexPath(for: cell) == nil {
            setImage(image, toCell: cell)
        }
    }
    
    private func setImage(_ image: UIImage, toCell cell: UITableViewCell) {
        if let newsCell = cell as? NewsFeedTableViewCell {
            newsCell.imageFriend.image = image
            newsCell.newsImage.image = image
        } else if let myGroupsCell = cell as? MyGroupsTableViewCell {
            myGroupsCell.imageGroup.image = image
        } else if let allGroupsCell = cell as? AllGroupsTableViewCell {
            allGroupsCell.imageGroup.image = image
        } else if let friends = cell as? FriendsTableViewCell {
            friends.imageFriend.image = image
        }
    }
}
