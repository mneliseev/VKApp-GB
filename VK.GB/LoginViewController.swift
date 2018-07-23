//import UIKit
//
//class LoginViewController: UIViewController {
//
//    @IBOutlet weak var buttonInput: UIButton!
//    @IBOutlet weak var scrollView: UIScrollView!
//    @IBOutlet weak var loginInput: UITextField!
//    @IBOutlet weak var passwordInput: UITextField!
//    var gradientLayer: CAGradientLayer! {
//        didSet {
//            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
//            let startColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
//            let endColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
//            gradientLayer.colors = [startColor, endColor]
//            gradientLayer.locations = [0, 1]
//        }
//    }
//
//    override func viewDidLayoutSubviews() {
//        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
//    }
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        gradientLayer = CAGradientLayer()
//        view.layer.insertSublayer(gradientLayer, at: 0)
//
//        buttonInput.layer.cornerRadius = 10
//        buttonInput.clipsToBounds = true
//
//        let hideKeyBoardGesture = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
//        scrollView.addGestureRecognizer(hideKeyBoardGesture)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//
//        NotificationCenter.default.addObserver(self, selector: #selector(kbDidShow), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(kbDidHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//
//        NotificationCenter.default.removeObserver(self)
//    }
//
//    @objc func kbDidShow(notification: Notification) {
//
//        let info = notification.userInfo! as NSDictionary
//        let kbSize = (info.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
//        let contentInset = UIEdgeInsetsMake(0, 0, kbSize.height, 0)
//        scrollView.contentInset = contentInset
//    }
//
//    @objc func kbDidHide(notification: Notification) {
//        let contentInset = UIEdgeInsets.zero
//        scrollView.contentInset = contentInset
//    }
//
//    @objc func hideKeyboard() {
//        self.scrollView.endEditing(true)
//    }
//
//    @IBAction func loginButtonPressed(_ sender: UIButton) {
//        checkUserData()
//    }
//
//    func checkUserData() {
//        let login = loginInput.text!
//        let password = passwordInput.text!
//
//        if login == "admin" && password == "111" {
//            performSegue(withIdentifier: "segueToApp", sender: nil)
//        } else {
//            showLoginError()
//        }
//    }
//
//    func showLoginError() {
//        let alert = UIAlertController(title: "Ошибка", message: "Вы ввели неверные данные", preferredStyle: .alert)
//        let actionOk = UIAlertAction(title: "Хорошо", style: .cancel, handler: nil)
//        alert.addAction(actionOk)
//        present(alert, animated: true, completion: nil)
//    }
//}
//
//
//
//
//
//
//
//
//
//
//
//
//
//
