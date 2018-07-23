import UIKit

let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImageView {
    
    func loadImageUsingUrlString(urlString: String) {
        
        let url = URL(string: urlString)
        
        image = nil
        
        if let imageFromCache = imageCache.object(forKey: urlString as NSString) {
            self.image = imageFromCache as? UIImage
            return
        }
        
        DispatchQueue.global().async {
            URLSession.shared.dataTask(with: url!) { data, respones, error in
                
                if error != nil {
                    print(error!)
                    return
                }
                DispatchQueue.main.async(execute: {
                    if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: urlString as NSString)
                        self.image = downloadedImage
                    }
                })
                
            }.resume()
        }
    }
}
