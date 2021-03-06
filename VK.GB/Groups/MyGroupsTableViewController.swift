import UIKit
import RealmSwift
import Firebase
import FirebaseDatabase

class MyGroupsTableViewController: UITableViewController {
    
    var token: NotificationToken?
    var allGroupRequest = AllGroupsRequest()
    var myGroups: Results<Group>? = {
        let realm = try! Realm()
        return realm.objects(Group.self)
    }()
    var userId = ""
    var accesToken = ""
    var groupsRequest = MyGroupsRequest()
    
    let queque: OperationQueue = {
        let queque = OperationQueue()
        queque.qualityOfService = .userInteractive
        return queque
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        groupsRequest.getGroupsRequest(userId: userId, accesToken: accesToken)
        pairTableAndRealm()
    }
    
    func pairTableAndRealm() {
        token = myGroups?.observe( { [weak self] (changes: RealmCollectionChange) in
            guard let tableView = self?.tableView else { return }
            switch changes {
            case .initial:
                tableView.reloadData()
            case .update:
                tableView.reloadData()
            case .error(let error):
                print(error.localizedDescription)
            }
        })
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGroups!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellMyGroups", for: indexPath) as? MyGroupsTableViewCell
        
        guard let myGroups = myGroups, let userGroupCell = cell else { return UITableViewCell() }
        let group = myGroups[indexPath.row]

        userGroupCell.nameGroup.text = group.name

        let getCacheImage = GetCacheImage(url: group.image)
        let setImageToRow = SetImageToRowTableView(cell: cell!, indexPath: indexPath, tableView: tableView)
        setImageToRow.addDependency(getCacheImage)
        queque.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)
        
        return userGroupCell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let share = UITableViewRowAction(style: .default, title: "Поделиться") { (_, _) in
            let defaultText = "Хорошая группа " + self.myGroups![indexPath.row].name
            if let image = self.myGroups?[indexPath.row].image {
                let activityController = UIActivityViewController(activityItems: [defaultText, image], applicationActivities: nil)
                self.present(activityController, animated: true, completion: nil)
            }
        }

        let delete = UITableViewRowAction(style: .default, title: "Удалить") {_,_ in
            RealmActions.deleteGroup([self.myGroups![indexPath.row]])
            self.allGroupRequest.leaveGroup(groupId: self.myGroups![indexPath.row].id)
        }
        share.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        delete.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        return [delete, share]

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "InformationGroup" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let informVC = segue.destination as! AboutGroupInformTableViewController
                informVC.groupsId = "\(myGroups![indexPath.row].id)"
            }
        }
    }
    

    
     @IBAction func addGroup(segue: UIStoryboardSegue) {
        
        if segue.identifier == "addGroup" {
            let allGroupsController = segue.source as! AllGroupsTableViewController

            if let indexPath = allGroupsController.tableView.indexPathForSelectedRow {
                let newGroup = allGroupsController.allGroups[indexPath.row]
                if !(myGroups?.contains(where: { $0.id == newGroup.id }))! {
                    allGroupRequest.joinGroup(groupId: newGroup.id)
                    RealmActions.addGroupFromSearchToRealm([newGroup])
                    
                    let dbLink = Database.database().reference()
                    dbLink.child("Новая группа").setValue(newGroup.name)
                }
                return
            }
        }
    }
}

