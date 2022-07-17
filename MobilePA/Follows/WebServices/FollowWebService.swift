//
//  FollowWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 11/07/2022.
//

import Foundation

class FollowWebService: FollowService {
    func getUserFollowedById(completion: @escaping ([Follow]) -> Void) {
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let currentUser = idCurentUser else {
            return
        }
        
        let urlParse = "http://52.208.34.20:3000/api/follows/following/" + currentUser
        
        guard let url = URL(string: urlParse)
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
            print(json)
            let follows  = json.compactMap{ follow in
                Follow(dict: follow)
            }
            
            DispatchQueue.main.async {
                completion(follows)
            }
        }
    
        dataTask.resume()
    }
    
    func createFollow(idUser: Int) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/follows") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let token = UserDefaults.standard.string(forKey: "token")
        
        guard let userToken = token else {
            return
        }
        
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let currentUser = idCurentUser else {
            return
        }
        
        let body: [String: Any?] = [
            "idUserFollowing": Int(currentUser),
            "idUserFollowed": idUser
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(response)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func deleteFollow(idFollow: Int){
        let url = "http://52.208.34.20:3000/api/follows/" + String(idFollow)
        
        guard let url = URL(string: url) else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let token = UserDefaults.standard.string(forKey: "token")
        
        guard let userToken = token else {
            return
        }
        
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                print(response)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getFollowByUserFollowingAndUserFollowed(completion: @escaping (Follow) -> Void, idUserFollowed : Int){
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let currentUser = idCurentUser else {
            return
        }
        
        let url = "http://52.208.34.20:3000/api/follows?idUserFollowing=" + currentUser + "&idUserFollowed=" + String(idUserFollowed)
        
        guard let url = URL(string: url)
        else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any] else {
                return
            }
            
            guard let followObject = Follow(dict:json) else {
                return
            }
            
            DispatchQueue.main.async {
                completion(followObject)
            }
        }
        dataTask.resume()
    }
}
