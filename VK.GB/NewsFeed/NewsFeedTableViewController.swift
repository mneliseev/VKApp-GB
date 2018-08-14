
import UIKit

class NewsFeedTableViewController: UITableViewController {
    
    var news = [News]()
    var accesToken = ""
    var userId = ""
    let newsRequest = NewsFeedRequest()
    var heightCellCash: [IndexPath : CGFloat] = [:]
    let cellSpacingHeight: CGFloat = 15
    
    let queque: OperationQueue = {
        let queque = OperationQueue()
        queque.qualityOfService = .userInteractive
        return queque
    }()
    
    let dateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "dd MMMM yyyy HH:mm"
        return df
    }()
    var dateTextCache: [IndexPath: String] = [:]
    
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = #colorLiteral(red: 0.921431005, green: 0.9214526415, blue: 0.9214410186, alpha: 1)
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let height = heightCellCash[indexPath] else { return 44 }
        return height
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsFeedTableViewCell
        
        let newsCell = news[indexPath.section]
        
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
        
        if newsCell.attachmentsPhoto == "" {
            cell.newsImage.isHidden = true
        } else {
            cell.newsImage.isHidden = false
            let getPostImage = GetCacheImage(url: newsCell.attachmentsPhoto)
            getPostImage.completionBlock = {
                OperationQueue.main.addOperation {
                    cell.newsImage.image = getPostImage.outputImage
                }
            }
            queque.addOperation(getPostImage)
        }
        
        cell.newsDate.text = getCellDateText(forIndexPath: indexPath, andTimestamp: newsCell.newsDate)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func getCellDateText(forIndexPath indexPath: IndexPath, andTimestamp timestamp: Double) -> String {
        if let stringDate = dateTextCache[indexPath] {
            return stringDate
        } else {
            let date = Date(timeIntervalSince1970: timestamp)
            let stringDate = dateFormatter.string(from: date)
            dateTextCache[indexPath] = stringDate
            return stringDate
        }
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
