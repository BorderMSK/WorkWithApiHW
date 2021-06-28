//
//  NetworkManager.swift
//  WorkWithApiHW
//
//  Created by Igor Makeev on 28.06.2021.
//

import UIKit

enum PostsResult {
    case success(posts: [Model])
    case failure(error: Error)
}

class NetworkManager {
    
    let session = URLSession.shared
    let sessionConfiguration = URLSessionConfiguration.default
    let decoder = JSONDecoder()
    
    func getPosts(completion: @escaping (PostsResult) -> Void) {
        
       guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        session.dataTask(with: url) { [weak self] (data, response, error) in
            
            var result: PostsResult
            
            defer {
                DispatchQueue.main.async {
                    completion(result)
                }
            }
            
            guard let strongSelf = self else {
                result = .success(posts: [])
                
                return
            }
            
            if error == nil, let data = data{
                guard let posts = try? strongSelf.decoder.decode([Model].self, from: data) else {
                    
                    result = .success(posts: [])
                    
                    return
                }
                result = .success(posts: posts)
            }
            else{
                
                result = .failure(error: error!)
            }
        }.resume()
    }
}
