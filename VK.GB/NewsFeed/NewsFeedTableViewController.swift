
import UIKit

class NewsFeedTableViewController: UITableViewController {

    var news = [News]()
    var accesToken = ""
    var userId = ""
    let newsRequest = NewsFeedRequest()
    
    let queque: OperationQueue = {
        let queque = OperationQueue()
        queque.qualityOfService = .userInteractive
        return queque
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        
        
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsFeedTableViewCell
        
        let newsCell = news[indexPath.row]
        
        cell.newsText.text = newsCell.newsText
        cell.newsLikesCount.text = "\(newsCell.newsLikesCount)"
        cell.newsRepostCount.text = "\(newsCell.newsRepostsCount)"
        cell.newsCommentCount.text = "\(newsCell.newsCommentsCount)"
        cell.newsViewCount.text = "\(newsCell.newsViewsCount)"
        
        cell.nameFriend.text = newsCell.newsAuthor
        

        
        if !newsCell.newsPhotoAuthor.isEmpty {
            cell.imageFriend.loadImageUsingUrlString(urlString: newsCell.newsPhotoAuthor)
        } else {
            cell.imageFriend.image = nil
        }
        cell.imageFriend.layer.cornerRadius = 30
        cell.imageFriend.clipsToBounds = true
        
        if !newsCell.attachmentsPhoto.isEmpty {
            let getCacheImage = GetCacheImage(url: newsCell.attachmentsPhoto)
            let setImageToRow = SetImageToRowTableView(cell: cell, indexPath: indexPath, tableView: tableView)
            setImageToRow.addDependency(getCacheImage)
            queque.addOperation(getCacheImage)
            OperationQueue.main.addOperation(setImageToRow)
//            cell.newsImage.loadImageUsingUrlString(urlString: newsCell.attachmentsPhoto)
        }
        
        cell.newsDate.text = ""
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
