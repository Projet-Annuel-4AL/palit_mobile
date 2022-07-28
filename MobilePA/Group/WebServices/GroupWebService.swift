//
//  Groups.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

class GroupWebService: GroupService {
    func getGroups(completion: @escaping ([Group]) -> Void) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/groups")
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
            
            let groups  = json.compactMap{ group in
                Group(dict: group)
            }
            DispatchQueue.main.async {
                completion(groups)
            }
        }
        dataTask.resume() // start request
    }
    
    func getPostsByIdGroup(completion: @escaping ([GroupPost]) -> Void, idGroup: Int) {
        let url = "http://52.208.34.20:3000/api/relation-group-post/posts/" + String(idGroup)
        
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
                GroupPost(dict: post)
            }
            
            DispatchQueue.main.async {
                completion(posts)
            }
        }
    
        dataTask.resume()
    }
    
    func joinGroup(idGroup: Int) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/relation-group-user") else {
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
        
        guard let idUser = idCurentUser else {
            return
        }
        
        let body: [String: Any?] = [
            "idUser": Int(idUser),
            "idGroup": idGroup
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
    
    func quitGroup(idGroup: Int) {
        let url = "http://52.208.34.20:3000/api/relation-group-user/" + String(idGroup)
        
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
    
    func creategroup(name: String, description: String, theme: String) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/groups") else {
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
            "name": name,
            "theme": theme,
            "description": description,
            "idGroupOwner": Int(currentUser)
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
    
    func deleteGroup(idGroup: Int) {
        let url = "http://52.208.34.20:3000/api/groups/" + String(idGroup)
        
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
                
            } catch {
            }
        }
        task.resume()
    }
    
    func getGroupByUserIdAndIdGroup(completion: @escaping (GroupUser) -> Void, idUser: String, idGroup: Int){
        let url = "relation-group-user?idUser=" + idUser + "&idGroup=" + String(idGroup)
        
        guard let url = URL(string: url)
        else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any] else {
                return
            }
            
            guard let groups = GroupUser(dict:json) else {
                return
            }
            
            DispatchQueue.main.async {
                completion(groups)
            }
        }
    
        dataTask.resume() // start request
    }
    
    func getGroupsByUserId(completion: @escaping ([GroupUser]) -> Void, idUser: String){
        let url = "http://52.208.34.20:3000/api/relation-group-user/groups/" + idUser
        
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
            
            let groups  = json.compactMap{ group in
                GroupUser(dict: group)
            }
            
            DispatchQueue.main.async {
                completion(groups)
            }
        }
    
        dataTask.resume() // start request
    }
}
