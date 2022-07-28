//
//  CreatePostPictureWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 16/07/2022.
//

import Foundation

class CreatePostPictureWebService: CreatePostPictureService {
    func createPostPicture(title: String, idPicture: Int){
        guard let url = URL(string: "http://52.208.34.20:3000/api/posts") else {
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
            "title": title,
            "idVideo": nil,
            "idText": nil,
            "idCode": nil,
            "idPicture": idPicture,
            "idUser": Int(idUser)
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
    
    func createPicture(title: String, content: String){
        guard let url = URL(string: "http://52.208.34.20:3000/api/texts") else {
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
        
        let body: [String: AnyHashable] = [
            "content": content
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
                guard let responseParsed = response as? [String: Any] else {
                    return
                }
                print(responseParsed)
                
                if let id = responseParsed["id"] {
                    self.createPostPicture(title: title, idPicture: id as! Int)
                }
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
