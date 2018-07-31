import UIKit

class AllGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var imageGroup: UIImageView!
    @IBOutlet weak var nameGroup: UILabel!

    let insets: CGFloat = 5.0
    
    override func layoutSubviews() {
        imageGroup.translatesAutoresizingMaskIntoConstraints = false
        nameGroup.translatesAutoresizingMaskIntoConstraints = false
        super.layoutSubviews()
        imageAllGroupFrame()
        nameAllGroupFrame()
    }
    
    func setNameAllGroup(text: String) {
        nameGroup.text = text
        nameAllGroupFrame()
    }
    
    func setImageAllGroup(image: UIImage) {
        imageGroup.image = image
        imageAllGroupFrame()
    }
    
    private func getLabelSize(text: String, font: UIFont) -> CGSize {
        let maxWidth = bounds.width - insets * 13
        let textBlock = CGSize(width: maxWidth, height: 40)
        let rect = text.boundingRect(with: textBlock, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        let width = Double(rect.size.width)
        let height = Double(rect.size.height)
        let size = CGSize(width: ceil(width), height: ceil(height))
        return size
    }
    
    private func imageAllGroupFrame() {
        let imageAllGroupLength: CGFloat = 50
        let imageAllGroupSize = CGSize(width: imageAllGroupLength, height: imageAllGroupLength)
        let imageAllGroupImgOrig = CGPoint(x: insets, y: insets)
        imageGroup.frame = CGRect(origin: imageAllGroupImgOrig, size: imageAllGroupSize)
        imageGroup.layer.cornerRadius = imageAllGroupLength / 2
        imageGroup.clipsToBounds = true
    }
    
    private func nameAllGroupFrame() {
        let nameAllGroupSize = getLabelSize(text: nameGroup.text!, font: nameGroup.font)
        let nameAllGroupX = insets * 14
        let nameAllGroupOrig = CGPoint(x: nameAllGroupX, y: insets * 4)
        nameGroup.frame = CGRect(origin: nameAllGroupOrig, size: nameAllGroupSize)
        nameGroup.numberOfLines = 1
        nameGroup.lineBreakMode = .byTruncatingTail
    }
}
