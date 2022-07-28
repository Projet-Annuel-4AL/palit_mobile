//
//  PostWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 09/07/2022.
//

import Foundation

class PostWebService: PostService {
        
    func getPosts(completion: @escaping ([Post]) -> Void) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/posts")
        else {
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [ [String: Any] ] else {
                completion([])
                return
            }
    
            let posts  = json.compactMap{ post in
                Post(dict: post)
            }
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        dataTask.resume() // start request
    }
    
    func getPostsByIdUser(completion: @escaping([Post]) -> Void, idUser: Int){
        let url = "http://52.208.34.20:3000/api/posts/id/" + String(idUser)
        
        guard let url = URL(string: url)
        else {
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [ [String: Any] ] else {
                completion([])
                return
            }
            
            let posts  = json.compactMap{ post in
                Post(dict: post)
            }
            DispatchQueue.main.async {
                completion(posts)
            }
        }
        dataTask.resume()
    }
}
