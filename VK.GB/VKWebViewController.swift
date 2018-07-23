import UIKit
import WebKit

let userDefaults = UserDefaults.standard

class VKWebViewController: UIViewController {
    
    var userId = ""
    var accessToken = VKServices.token

    @IBOutlet weak var webview: WKWebView! {
        didSet {
            webview.navigationDelegate = self
        }
    }
    let authorizationRequest = VKServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webview.load(VKServices.authRequest())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tabbarVC = segue.destination as! UITabBarController
        let navFriendsTVC = tabbarVC.viewControllers?.first as! UINavigationController
        let friendsTVC = navFriendsTVC.viewControllers.first as! FriendsTableViewController
        friendsTVC.userId = userId
        
        let navGroupsTVC = tabbarVC.viewControllers?[1] as! UINavigationController
        let groupsTVC = navGroupsTVC.viewControllers.first as! MyGroupsTableViewController
        groupsTVC.userId = friendsTVC.userId
        groupsTVC.userId = userId
        groupsTVC.accesToken = accessToken
        
        let navNewsTVC = tabbarVC.viewControllers?[2] as! UINavigationController
        let newsTVC = navNewsTVC.viewControllers.first as! NewsFeedTableViewController
        newsTVC.userId = userId
        newsTVC.accesToken = accessToken
    }
}

extension VKWebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment else  {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=")}
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        VKServices.token = params["access_token"]!
        userId = params["user_id"]!
        decisionHandler(.cancel)
        performSegue(withIdentifier: "segueToApp", sender: nil)
    }
}










