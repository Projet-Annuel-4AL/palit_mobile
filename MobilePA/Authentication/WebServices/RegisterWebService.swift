//
//  RegisterWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 16/07/2022.
//

import Foundation

class RegisterWebService : RegisterService {
    func register(firstname: String, lastname: String, mail: String, password: String) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/auth/register") else {
            
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let body: [String: AnyHashable] = [
            "firstName": firstname,
            "lastName": lastname,
            "mail": mail,
            "password": password
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
                
                guard let responseParsed = response as? [String: Any] else {
                    return
                }
                
                if let httpCode = responseParsed["statusCode"] {
                    
                } else if let token = responseParsed["access_token"] {
                    
                }
                
            } catch {
            }
        }
        task.resume()
        
        return
    }

}
