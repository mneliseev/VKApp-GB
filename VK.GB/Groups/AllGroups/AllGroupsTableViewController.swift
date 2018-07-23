import UIKit

class AllGroupsTableViewController: UITableViewController {
    
    var allGroups = [Groups]()
    var searchRequest = AllGroupsRequest()
    var searchController = UISearchController(searchResultsController: nil)
    
    let queque: OperationQueue = {
        let queque = OperationQueue()
        queque.qualityOfService = .userInteractive
        return queque
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Все группы"
        
        searchGroups()
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        if let textFieldInsideSearchBar = searchController.searchBar.getSubview(type: UITextField.self), let searchIconImageView = textFieldInsideSearchBar.leftView as? UIImageView {
            searchIconImageView.image = searchIconImageView.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
            searchIconImageView.tintColor = UIColor.blue
        }
        if let textFieldInsideSearchBar = searchController.searchBar.getSubview(type: UITextField.self) {
            textFieldInsideSearchBar.layer.backgroundColor = UIColor.white.cgColor
            textFieldInsideSearchBar.layer.cornerRadius = 10.0
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allGroups.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellAllGroups", for: indexPath) as! AllGroupsTableViewCell
        
        let allGroup = allGroups[indexPath.row]
        
        cell.nameGroup.text = allGroup.name

        let getCacheImage = GetCacheImage(url: allGroup.imageUrl)
        let setImageToRow = SetImageToRowTableView(cell: cell, indexPath: indexPath, tableView: tableView)
        setImageToRow.addDependency(getCacheImage)
        queque.addOperation(getCacheImage)
        OperationQueue.main.addOperation(setImageToRow)        
        cell.imageGroup.layer.cornerRadius = 20
        cell.imageGroup.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func searchGroups() {
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search group"
        searchController.searchBar.tintColor = .black
    }
}

extension AllGroupsTableViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard !searchController.searchBar.text!.isEmpty else {
            allGroups.removeAll()
            tableView.reloadData()
            return
        }
        
        searchRequest.getSearchGroupRequest(searchText: ((searchController.searchBar.text?.lowercased()))!, completion: { [weak self] (search) in
            self?.allGroups = search
            self?.tableView?.reloadData()
        })
    }
}

extension UIView {
    func getSubview<T>(type: T.Type) -> T? {
        let svs = subviews.flatMap { $0.subviews }
        let element = (svs.filter { $0 is T }).first
        return element as? T
    }
}
