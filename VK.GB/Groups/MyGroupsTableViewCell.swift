import UIKit

class MyGroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var nameGroup: UILabel! 
    @IBOutlet weak var imageGroup: UIImageView!

    let insets: CGFloat = 5.0
    
    override func layoutSubviews() {
        nameGroup.translatesAutoresizingMaskIntoConstraints = false
        imageGroup.translatesAutoresizingMaskIntoConstraints = false
        super.layoutSubviews()
        imageMyGroupFrame()
        nameMyGroupFrame()
    }
    
    func setNameMyGroup(text: String) {
        nameGroup.text = text
        nameMyGroupFrame()
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
    
    private func imageMyGroupFrame() {
        let imageMyGroupFrameLenght: CGFloat = 50
        let imageMyGroupFrameSize = CGSize(width: imageMyGroupFrameLenght, height: imageMyGroupFrameLenght)
        let imageMyGroupImgOrig = CGPoint(x: insets, y: insets)
        imageGroup.frame = CGRect(origin: imageMyGroupImgOrig, size: imageMyGroupFrameSize)
        imageGroup.layer.cornerRadius = imageMyGroupFrameLenght / 2
        imageGroup.clipsToBounds = true
    }

    private func nameMyGroupFrame() {
        let nameMyGroupSize = getLabelSize(text: nameGroup.text!, font: nameGroup.font)
        let nameMyGroupX = insets * 14
        let nameMyGroupOrig = CGPoint(x: nameMyGroupX, y: insets * 4)
        nameGroup.frame = CGRect(origin: nameMyGroupOrig, size: nameMyGroupSize)
        nameGroup.numberOfLines = 1
        nameGroup.lineBreakMode = .byTruncatingTail
    }
}
