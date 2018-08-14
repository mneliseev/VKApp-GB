
import UIKit

class NewsFeedTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    @IBOutlet weak var newsDate: UILabel!
    @IBOutlet weak var newsText: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsLikesCount: UILabel!
    @IBOutlet weak var newsRepostCount: UILabel!
    @IBOutlet weak var newsCommentCount: UILabel!
    @IBOutlet weak var newsViewCount: UILabel!
    @IBOutlet weak var newsIconLikes: UIImageView!
    @IBOutlet weak var newsIconRepost: UIImageView!
    @IBOutlet weak var newsIconView: UIImageView!
    @IBOutlet weak var newsIconComment: UIImageView!
    @IBOutlet weak var postView: UIView!
    
    var attachment: News?
    
    weak var delegate: PostCellHeightDelegate?
    var index: IndexPath?
    
    let insets: CGFloat = 10.0
    let insetsX: CGFloat = 5.0
    
    override func setNeedsLayout() {
        super.setNeedsLayout()
        [imageFriend, nameFriend, newsDate, newsText, newsImage, newsLikesCount, newsRepostCount, newsCommentCount, newsViewCount, newsIconLikes, newsIconRepost, newsIconView, newsIconComment, postView].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        [imageFriend, nameFriend, newsDate, newsText, newsImage, newsLikesCount, newsRepostCount, newsCommentCount, newsViewCount, newsIconLikes, newsIconRepost, newsIconView, newsIconComment, postView].forEach { $0?.backgroundColor = .white }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postAuthorPhotoFrame()
        postAuthorNameFrame()
        postTextFrame()
        postImageFrame()
        postViewFrame()
        postIconLikeFrame()
        postCountLikeFrame()
        postIconRepostFrame()
        postCountRepostFrame()
        postIconCommentFrame()
        postCountCommentFrame()
        postIconViewersFrame()
        postCountViewersFrame()
        postDateFrame()
        
        cellCurrentHeight()
    }
    
    
    func cellCurrentHeight() {
        let heigth = imageFriend.frame.size.height + newsText.frame.size.height + newsImage.frame.size.height + postView.frame.size.height + insets * 6
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
    
    func setNewsImage(image: UIImage) {
        newsImage.image = image
        postImageFrame()
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
    
    func getDateSize(text: String, font: UIFont) -> CGSize{
        let maxWidth = bounds.width - 5 * insets - 50
        let textBlock = CGSize(width: maxWidth, height: (50 - 3 * insets)/2)
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
        let postAuthorNameSize = getDateSize(text: nameFriend.text!, font: nameFriend.font)
        let labelX = 4 * insets + 45
        let labelY = insets + 5
        let labelOrigin = CGPoint(x: labelX, y: labelY)
        nameFriend.frame = CGRect(origin: labelOrigin, size: postAuthorNameSize)
    }
    
    private func postDateFrame() {
        let postDateSize = getDateSize(text: newsDate.text!, font: newsDate.font)
        let labelX = 4 * insets + 45
        let labelY = 4 * insets + 3
        let labelOrigin = CGPoint(x: labelX, y: labelY)
        newsDate.frame = CGRect(origin: labelOrigin, size: postDateSize)
    }
    
    private func postTextFrame() {
        let postTextSize = getLabelSize(text: newsText.text!, font: newsText.font)
        let postTextX = insets
        let postTextY = imageFriend.frame.origin.y + imageFriend.frame.size.height + insets
        let postTextOrigin = CGPoint(x: ceil(postTextX), y: ceil(postTextY))
        newsText.frame = CGRect(origin: postTextOrigin, size: postTextSize)
        newsText.numberOfLines = 0
        newsText.backgroundColor = .white
    }
    
    private func postImageFrame() {
        let iconSizeLength: CGFloat = 208
        var iconSize = CGSize(width: 0, height: 0)
        if !newsImage.isHidden {
            iconSize = CGSize(width: iconSizeLength, height: iconSizeLength)
        }
        let imageX = bounds.midX - iconSizeLength/2
        let imageY = newsText.frame.origin.y + newsText.frame.size.height + insets
        let iconOrigin = CGPoint(x: imageX, y: imageY)
        newsImage.frame = CGRect(origin: iconOrigin, size: iconSize)
    }
    
    private func postViewFrame(){
        let viewWidth = bounds.width - insets * 2
        let viewHeight: CGFloat  = 24
        let viewSize = CGSize(width: viewWidth, height: viewHeight)
        let viewY = newsImage.frame.origin.y + newsImage.frame.height + insets * 2
        let viewOrigin = CGPoint(x: 0, y: viewY)
        postView.frame = CGRect(origin: viewOrigin, size: viewSize)
    }
    
    private func postIconLikeFrame() {
        let postIconLikeLength: CGFloat = 24
        let postIconLikeSize = CGSize(width: postIconLikeLength, height: postIconLikeLength)
        let postIconLikeOrig = CGPoint(x: 20, y: 0)
        newsIconLikes.frame = CGRect(origin: postIconLikeOrig, size: postIconLikeSize)
    }
    
    private func postCountLikeFrame(){
        let postCountLikeLength: CGFloat = 24
        let postCountLikeSize = CGSize(width: 35, height: postCountLikeLength)
        let postountLikeX = insets * 6
        let postIconLikeOrig = CGPoint(x: postountLikeX, y: 0)
        newsLikesCount.frame = CGRect(origin: postIconLikeOrig, size: postCountLikeSize)
        newsLikesCount.textAlignment = .left
    }
    
    private func postIconRepostFrame() {
        let postIconRepostLength: CGFloat = 24
        let postIconRepostSize = CGSize(width: postIconRepostLength, height: postIconRepostLength)
        let postIconRepostOrig = CGPoint(x: 90, y: 0)
        newsIconRepost.frame = CGRect(origin: postIconRepostOrig, size: postIconRepostSize)
    }
    
    private func postCountRepostFrame(){
        let postCountRepostLength: CGFloat = 24
        let postCountRepostSize = CGSize(width: 35, height: postCountRepostLength)
        let postCountRepostLikeX = insets * 13
        let postCountRepostOrig = CGPoint(x: postCountRepostLikeX, y: 0)
        newsRepostCount.frame = CGRect(origin: postCountRepostOrig, size: postCountRepostSize)
        newsRepostCount.textAlignment = .left
    }
    
    private func postIconCommentFrame() {
        let postIconCommentLength: CGFloat = 24
        let postIconCommentSize = CGSize(width: postIconCommentLength, height: postIconCommentLength)
        let postIconCommentOrig = CGPoint(x: 160, y: 0)
        newsIconComment.frame = CGRect(origin: postIconCommentOrig, size: postIconCommentSize)
    }
    
    private func postCountCommentFrame(){
        let postCountCommentLength: CGFloat = 24
        let postCountCommentSize = CGSize(width: 35, height: postCountCommentLength)
        let postCountCommentLikeX = insets * 20
        let postCountCommentOrig = CGPoint(x: postCountCommentLikeX, y: 0)
        newsCommentCount.frame = CGRect(origin: postCountCommentOrig, size: postCountCommentSize)
        newsCommentCount.textAlignment = .left
    }
    
    private func postIconViewersFrame() {
        let postIconViewersLength: CGFloat = 24
        let postIconViewersSize = CGSize(width: postIconViewersLength, height: postIconViewersLength)
        let postIconViewersOrig = CGPoint(x: 260, y: 0)
        newsIconView.frame = CGRect(origin: postIconViewersOrig, size: postIconViewersSize)
    }
    
    private func postCountViewersFrame(){
        let postCountViewersLength: CGFloat = 24
        let postCountViewersSize = CGSize(width: 35, height: postCountViewersLength)
        let postCountViewersLikeX = insets * 30 - 3
        let postCountViewersOrig = CGPoint(x: postCountViewersLikeX, y: 0)
        newsViewCount.frame = CGRect(origin: postCountViewersOrig, size: postCountViewersSize)
        newsViewCount.textAlignment = .left
    }
}
