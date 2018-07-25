
import UIKit

class NewsFeedTableViewController: UITableViewController {
    
    var news = [News]()
    var accesToken = ""
    var userId = ""
    let newsRequest = NewsFeedRequest()
    var heightCellCash: [IndexPath : CGFloat] = [:]
    
    let queque: OperationQueue = {
        let queque = OperationQueue()
        queque.qualityOfService = .userInteractive
        return queque
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        newsRequest.getNewsRequest(userId: userId, accesToken: accesToken) { [weak self] news in
            self?.news = news
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = heightCellCash[indexPath] else { return 44 }
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsFeedTableViewCell
        
        let newsCell = news[indexPath.row]
        cell.index = indexPath
        cell.delegate = self
        
        cell.setNewsText(text: newsCell.newsText)
        cell.setPostAuthorName(text: newsCell.newsAuthor)
        
        cell.newsLikesCount.text = "\(newsCell.newsLikesCount)"
        cell.newsRepostCount.text = "\(newsCell.newsRepostsCount)"
        cell.newsCommentCount.text = "\(newsCell.newsCommentsCount)"
        cell.newsViewCount.text = "\(newsCell.newsViewsCount)"
        
        if !newsCell.newsPhotoAuthor.isEmpty {
            let getCacheImage = GetCacheImage(url: newsCell.newsPhotoAuthor)
            let setImageToRow = SetImageToRowTableView(cell: cell, indexPath: indexPath, tableView: tableView)
            setImageToRow.addDependency(getCacheImage)
            queque.addOperation(getCacheImage)
            OperationQueue.main.addOperation(setImageToRow)
        } else {
            cell.imageFriend.image = nil
        }

//        if newsCell.attachmentsPhoto == "" {
//            cell.newsImage.isHidden = true
//        } else {
//            cell.newsImage.isHidden = false
//            let getPostImage = GetCacheImage(url: newsCell.attachmentsPhoto)
//            getPostImage.completionBlock = {
//                OperationQueue.main.addOperation {
//                    cell.newsImage.image = getPostImage.outputImage
//                }
//            }
//            queque.addOperation(getPostImage)
//        }
        
        cell.newsDate.text = ""
        cell.update()
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension NewsFeedTableViewController: PostCellHeightDelegate {
    
    func setHeight(_ height: CGFloat, _ index: IndexPath) {
        heightCellCash[index] = height
        tableView.beginUpdates()
        tableView.reloadRows(at: [index], with: .automatic)
        tableView.endUpdates()
    }
}
