import UIKit

class AllGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageGroup: UIImageView! {
        didSet {
            imageGroup.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var nameGroup: UILabel! {
        didSet {
            nameGroup.translatesAutoresizingMaskIntoConstraints = false
        }
    }

    let insets: CGFloat = 5.0
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageFriendFrame()
        nameFriendFrame()
    }
    
    func setNameFriend(text: String) {
        nameGroup.text = text
        nameFriendFrame()
    }
    
    func setImageFriend(image: UIImage) {
        imageGroup.image = image
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
        imageGroup.frame = CGRect(origin: postAuthorImgOrig, size: postAuthorPhotoSize)
        imageGroup.layer.cornerRadius = postAuthorPhotoLength / 2
        imageGroup.clipsToBounds = true
    }
    
    private func nameFriendFrame() {
        let postAuthorNameSize = getLabelSize(text: nameGroup.text!, font: nameGroup.font)
        let postAuthorNameX = insets * 3 + self.bounds.origin.x + imageGroup.bounds.width
        let postAuthorNameOrig = CGPoint(x: postAuthorNameX, y: insets * 4)
        nameGroup.frame = CGRect(origin: postAuthorNameOrig, size: postAuthorNameSize)
        nameGroup.numberOfLines = 0
        nameGroup.lineBreakMode = .byWordWrapping
        nameGroup.sizeToFit()
    }
}
