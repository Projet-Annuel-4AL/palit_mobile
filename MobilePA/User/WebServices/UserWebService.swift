//
//  UserWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 11/07/2022.
//

import Foundation

class UserWebService: UserService {
        
    func getUserById(completion: @escaping (User) -> Void, idUser: Int) {
        let url = "http://52.208.34.20:3000/api/users/id/" + String(idUser)
        guard let url = URL(string: url)
        else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any] else {
                return
            }
            
            guard let userObject = User(dict:json) else {
                return
            }
            
            DispatchQueue.main.async {
                completion(userObject)
            }
        }
        dataTask.resume() // start request
    }
    
    func getUserByMail(completion: @escaping (User) -> Void, mail: String) {
        let url = "http://52.208.34.20:3000/api/users/" + mail
        guard let url = URL(string: url)
        else {
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [String: Any] else {
                return
            }
            
            guard let userObject = User(dict:json) else {
                return
            }
            
            DispatchQueue.main.async {
                completion(userObject)
            }
        }
        dataTask.resume() // start request
    }
    
    
}
