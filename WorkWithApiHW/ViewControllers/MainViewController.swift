//
//  MainViewController.swift
//  WorkWithApiHW
//
//  Created by Igor Makeev on 27.06.2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    let networkManager = NetworkManager()
    var dataSource = [Model]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        networkManager.getPosts { (result) in
            
            switch result {
            case .success(let posts):
                self.dataSource = posts
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let post = dataSource[indexPath.row]
        
        cell.textLabel?.text = post.title
        cell.detailTextLabel?.text = post.body
        
        return cell
    }
}

