import UIKit

class AboutGroupInformTableViewController: UITableViewController {

    let informationRequest = GroupByIdRequest()
    var groupsId: String = ""
    var groupsById = [GroupsByID]()


    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 279
        informationRequest.getInformationAboutGroup(groupId: groupsId) { [weak self] inform in
            guard let strongSelf = self else { return }
            strongSelf.groupsById = inform
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupsById.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InformGroup", for: indexPath) as! AboutGroupInformTableViewCell
//
//        cell.nameGroup.text = groupsById[indexPath.row].name
//        cell.descriptionGroup.text = groupsById[indexPath.row].description

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}
