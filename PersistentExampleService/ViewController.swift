//
//  ViewController.swift
//  PersistentExampleService
//
//  Created by Stanly Shiyanovskiy on 22.07.17.
//  Copyright © 2017 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    
    var spinner: UIActivityIndicatorView!
    var array = Set<Mitre>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // спиннер предзагрузки данных в таблицу
        spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.color = UIColor.gray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        spinner.startAnimating()
        tableView.addSubview(spinner)
        spinner.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: tableView.centerYAnchor).isActive = true
        
        // потянули-обновили
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.backgroundColor = .white
        tableView.refreshControl?.tintColor = .gray
        tableView.refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        loadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = self.tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MyCustomCell {
            let tempArr = Array(array)
            cell.configureCell(mitre: tempArr[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
    func loadData() {
        PersistentService.getMitres() { (mitres: [Mitre]) -> () in
            for m in mitres {
                self.array.insert(m)
            }
            print("Loaded!\nThere are \(self.array.count) cells in table view")
            DispatchQueue.main.async {
                self.spinner.stopAnimating()
                self.tableView.refreshControl?.endRefreshing()
                self.tableView.reloadData()
            }
        }
    }
}

