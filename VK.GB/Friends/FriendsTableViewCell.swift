import UIKit

class FriendsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageFriend: UIImageView!
    @IBOutlet weak var nameFriend: UILabel!
    
    let insets: CGFloat = 5.0
    
    override func layoutSubviews() {
        imageFriend.translatesAutoresizingMaskIntoConstraints = false
        nameFriend.translatesAutoresizingMaskIntoConstraints = false
        super.layoutSubviews()
        imageFriendFrame()
        nameFriendFrame()
    }
    
    func setNameFriend(text: String) {
        nameFriend.text = text
        nameFriendFrame()
    }
    
    func setImageFriend(image: UIImage) {
        imageFriend.image = image
        imageFriendFrame()
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
    
    private func imageFriendFrame() {
        let postAuthorPhotoLength: CGFloat = 50
        let postAuthorPhotoSize = CGSize(width: postAuthorPhotoLength, height: postAuthorPhotoLength)
        let postAuthorImgOrig = CGPoint(x: insets, y: insets)
        imageFriend.frame = CGRect(origin: postAuthorImgOrig, size: postAuthorPhotoSize)
        imageFriend.layer.cornerRadius = postAuthorPhotoLength / 2
        imageFriend.clipsToBounds = true
    }
    
    private func nameFriendFrame() {
        let postAuthorNameSize = getLabelSize(text: nameFriend.text!, font: nameFriend.font)
        let postAuthorNameX = insets * 3 + self.bounds.origin.x + imageFriend.bounds.width
        let postAuthorNameOrig = CGPoint(x: postAuthorNameX, y: insets * 4)
        nameFriend.frame = CGRect(origin: postAuthorNameOrig, size: postAuthorNameSize)
        nameFriend.numberOfLines = 0
        nameFriend.lineBreakMode = .byWordWrapping
        nameFriend.sizeToFit()
    }
}
