import UIKit

class InfoFriendsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var photoFriend: UIImageView!
    
    override func layoutSubviews() {
        photoFriend.translatesAutoresizingMaskIntoConstraints = false
        super.layoutSubviews()
        setImageFrame()
    }
    
    func setFriendsImage(_ image: UIImage) {
        photoFriend.image = image
        setImageFrame()
    }
    
    private func setImageFrame() {
        let imageSizeLenght: CGFloat = self.frame.width
        let imageSize = CGSize(width: ceil(imageSizeLenght), height: ceil(imageSizeLenght))
        let position: CGFloat = 0.0
        let origin = CGPoint(x: position, y: position)
        let frame = CGRect(origin: origin, size: imageSize)
        photoFriend.frame = frame
    }
}
