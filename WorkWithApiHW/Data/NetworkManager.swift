//
//  NetworkManager.swift
//  WorkWithApiHW
//
//  Created by Igor Makeev on 28.06.2021.
//

import UIKit

class NetworkManager {
    
    let session = URLSession.shared
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    
    func getPosts() {
        
       guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            guard let strongSelf = self else { return }
            
            if error == nil, let parsData = data{
                guard let posts = try? strongSelf.decoder.decode([Model].self, from: parsData) else {
                    return
                }

            }
            else{
                print("Error: \(error?.localizedDescription)")
            }
            
        }.resume()
        
    }
}
