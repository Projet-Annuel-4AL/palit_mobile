//
//  LikeWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 17/07/2022.
//

import Foundation

class LikeWebService: LikeService {
    func createlike(idPost: Int) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/likes") else {
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
            "idPost": idPost
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func deleteLike(idLike: Int){
        let url = "http://52.208.34.20:3000/api/likes/" + String(idLike)
        
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
                print(error)
            }
        }
        task.resume()
    }
    
}
