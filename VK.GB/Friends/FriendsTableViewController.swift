import UIKit
import Alamofire
import RealmSwift

class FriendsTableViewController: UITableViewController {
    
    var token: NotificationToken?
    var userId = ""
    var accessToken = ""
    var friends: Results<Friends>? = {
        let realm = try! Realm()
        return realm.objects(Friends.self).sorted(byKeyPath: "lastName")
    }()
    
    var friendsRequest = FriendsRequest()
    
    let queque: OperationQueue = {
        let queque = OperationQueue()
        queque.qualityOfService = .userInteractive
        return queque
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendsRequest.getFriendsRequest(userId: userId)
        pairTableAndRealm()
    }
    
    func pairTableAndRealm() {
        token = friends?.observe( { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update:
                tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
                break
            }
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return friends?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellFriends", for: indexPath) as? FriendsTableViewCell
        
        guard let friends = friends, let userPhotoCell = cell else { return UITableViewCell() }
        
        let friend = friends[indexPath.row]
        
        userPhotoCell.setNameFriend(text: friend.name)
        userPhotoCell.imageFriend.layer.cornerRadius = 25
        userPhotoCell.imageFriend.clipsToBounds = true
        
        let getCacheImage = GetCacheImage(url: friend.image)
        let setImageToRow = SetImageToRowTableView(cell: userPhotoCell, indexPath: indexPath, tableView: tableView)
        setImageToRow.addDependency(getCacheImage)
        queque.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)
        
        return userPhotoCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let share = UITableViewRowAction(style: .default, title: "Поделиться") { (action, indexPath) in
            let defaultText = self.friends![indexPath.row].firstName + " " + self.friends![indexPath.row].lastName
            if let image = self.friends?[indexPath.row].image {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }
        let delete = UITableViewRowAction(style: .default, title: "Удалить") { (action, indexPath) in
            RealmActions.deleteFriend([self.friends![indexPath.row]])
        }
        share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete, share]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "photoSegue" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let dvc = segue.destination as! InfoFriendsCollectionViewController
                dvc.idFriend = friends![indexPath.row].id
                dvc.userId = userId
            }
        }
    }
}

















