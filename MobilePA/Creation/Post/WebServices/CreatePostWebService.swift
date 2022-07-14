//
//  CreatePostWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import Foundation

class CreatePostWebService: CreatePostService {
    func createTextPost(){
        guard let url = URL(string: "http://52.208.34.20:3000/api/texts") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let body: [String: AnyHashable] = [
            "content": "IOS, on the road !"
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
}
