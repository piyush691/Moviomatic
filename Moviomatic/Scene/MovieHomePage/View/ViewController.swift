//
//  ViewController.swift
//  Moviomatic
//
//  Created by Piyush Agrawal on 02/04/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    lazy var viewModel: ViewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: true)
        // Do any additional setup after loading the view.
        view.backgroundColor = .black
        tableView.register(CollectionTableViewCell.nib(), forCellReuseIdentifier: "CollectionTableViewCell")
        viewModel.loadData() {[weak self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                guard let self = self else {
                    return
                }
                self.tableView.reloadData()
            }
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MovieContentSegue" {
            if let vc = segue.destination as? MovieContentVC {
                vc.info = sender as? Result
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate, CategoryRowDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.modelData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    func  tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x:0, y:0, width:tableView.frame.size.width, height:25))
        let label = UILabel(frame: CGRect(x:10, y:0, width:tableView.frame.size.width, height:35))
        label.font = UIFont.systemFont(ofSize: 25)
        label.text = viewModel.modelData[section].title
        view.addSubview(label);
        view.backgroundColor = .black;
        label.textColor = .white
        return view
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CollectionTableViewCell", for: indexPath) as! CollectionTableViewCell
        lazy var tableViewModel = TableViewModel()
        tableViewModel.setParam(viewModel, indexPath.section)
        cell.configure(with: tableViewModel)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 320
    }
    
    func cellTapped(_ info: Result) {
        self.performSegue(withIdentifier: "MovieContentSegue", sender: info)
    }
}

