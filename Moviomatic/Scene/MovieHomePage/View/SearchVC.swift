//
//  SearchVC.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 24/04/22.
//

import UIKit

class SearchVC: UIViewController, UISearchBarDelegate {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var tableView: UITableView!
    var recentSearch = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.register(RecentTableViewCell.nib(), forCellReuseIdentifier: "RecentTableViewCell")
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            if let vc = segue.destination as? SelectedGenreVC {
                vc.query = (sender as! String)
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBar.text!.isEmpty {
            let searchText: String = searchBar.text!
            searchBar.text = nil
            if !recentSearch.contains(where: {$0.caseInsensitiveCompare(searchText) == .orderedSame}) {
                recentSearch.append(searchText)
            }
            self.performSegue(withIdentifier: "SearchSegue", sender: searchText)
        }
    }
}
extension SearchVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:25))
        let label = UILabel(frame: CGRect(x:10, y:0, width:tableView.frame.size.width, height:35))
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = "Recent search"
        view.addSubview(label);
        view.backgroundColor = .black;
        label.textColor = .white
        return view
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recentSearch.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let myCell = tableView.dequeueReusableCell(withIdentifier: "RecentTableViewCell", for: indexPath) as! RecentTableViewCell
        myCell.lblText.text = recentSearch[indexPath.row]
        return myCell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SearchSegue", sender: recentSearch[indexPath.row])
    }
}
