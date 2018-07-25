
import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    weak var delegate: PostCellHeightDelegate?
    var index: IndexPath?
    
    @IBOutlet weak var imageFriend: UIImageView! {
        didSet {
            imageFriend.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var nameFriend: UILabel! {
        didSet {
            nameFriend.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsDate: UILabel! {
        didSet {
            newsDate.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsText: UILabel! {
        didSet {
            newsText.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsImage: UIImageView! {
        didSet {
            newsImage.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsLikesCount: UILabel! {
        didSet {
            newsLikesCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsRepostCount: UILabel! {
        didSet {
            newsRepostCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsCommentCount: UILabel! {
        didSet {
            newsCommentCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsViewCount: UILabel! {
        didSet {
            newsViewCount.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsIconLikes: UIImageView! {
        didSet {
            newsIconLikes.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsIconRepost: UIImageView! {
        didSet {
            newsIconRepost.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsIconView: UIImageView! {
        didSet {
            newsIconView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var newsIconComment: UIImageView! {
        didSet {
            newsIconComment.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    
    let insets: CGFloat = 10.0
    let insetsX: CGFloat = 5.0
    
     //MARK: - Functions
    override func layoutSubviews() {
        super.layoutSubviews()
        postAuthorPhotoFrame()
        postAuthorNameFrame()
        postTextFrame()
    }
    
    
    func update() {
        let avatarPhoto = imageFriend.frame.size.height
        let bodyHeight = newsText.frame.size.height
        let heigth = 2 * insets + avatarPhoto + bodyHeight
        guard let index = index else { return }
        guard bounds.height != heigth else { return }
        delegate?.setHeight(heigth, index)
    }
   
    func setPostAuthorName(text: String) {
        nameFriend.text = text
        postAuthorNameFrame()
    }
    
    func setPostAuthorImage(image: UIImage) {
        imageFriend.image = image
        postAuthorPhotoFrame()
    }
    
    func setNewsText(text: String) {
        newsText.text = text
        postTextFrame()
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = bounds.width - insets * 2
        let textBlock = CGSize(width: maxWidth, height: CGFloat.greatestFiniteMagnitude)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    private func postAuthorPhotoFrame() {
        let postAuthorPhotoLength: CGFloat = 60
        let postAuthorPhotoSize = CGSize(width: postAuthorPhotoLength, height: postAuthorPhotoLength)
        let postAuthorImgOrig = CGPoint(x: insets, y: insets)
        imageFriend.frame = CGRect(origin: postAuthorImgOrig, size: postAuthorPhotoSize)
        imageFriend.layer.cornerRadius = postAuthorPhotoLength / 2
        imageFriend.clipsToBounds = true
    }
    
    private func postAuthorNameFrame() {
        let postAuthorNameSize = getLabelSize(text: nameFriend.text!, font: nameFriend.font)
        let postAuthorNameX = insets + self.bounds.origin.x + imageFriend.bounds.width + insetsX
        let postAuthorNameOrig = CGPoint(x: postAuthorNameX, y: insets + 3)
        nameFriend.frame = CGRect(origin: postAuthorNameOrig, size: postAuthorNameSize)
        nameFriend.numberOfLines = 0
        nameFriend.lineBreakMode = .byWordWrapping
        nameFriend.sizeToFit()
    }
    
    private func postTextFrame() {
        let postTextSize = getLabelSize(text: newsText.text!, font: newsText.font)
        let postTextX = insets
        let postTextY = imageFriend.frame.origin.y + imageFriend.frame.size.height + insets
        let postTextOrigin = CGPoint(x: postTextX, y: postTextY)
        newsText.frame = CGRect(origin: postTextOrigin, size: postTextSize)
    }
}
