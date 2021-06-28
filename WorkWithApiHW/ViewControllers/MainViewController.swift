//
//  MainViewController.swift
//  WorkWithApiHW
//
//  Created by Igor Makeev on 27.06.2021.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource {
    
    var dataSource = [Model]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        
        getData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let data = dataSource[indexPath.row]
        
        cell.textLabel?.text = data.title
        cell.detailTextLabel?.text = data.body
        
        return cell
    }
}
extension MainViewController {
    
    private func getData() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        URLSession.shared.dataTask(with: url) {(data, _, error) in
    
            guard let data = data else { return }
            
            do {
                self.dataSource = try JSONDecoder().decode([Model].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }
}

