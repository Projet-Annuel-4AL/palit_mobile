//
//  AuthenticationWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 13/07/2022.
//

import Foundation
import SwiftBCrypt

class LoginWebService: LoginService {
    let defaults = UserDefaults.standard
    
    func login(mail: String, password: String) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/auth/login") else {
            
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
        let body: [String: AnyHashable] = [
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
                
                
                guard let responseParsed = response as? [String: Any] else {
                    return
                }
                
                if let httpCode = responseParsed["statusCode"] {
                    return
                } else if let token = responseParsed["access_token"] {
                    let userToken: String = token as! String
                    
                    let jwtTokenService = JwtTokenService()
                    
                    let userData = jwtTokenService.decode(jwtToken: userToken)
                    
                    let id = userData["sub"]
                    let username = userData["username"]
                    let mail = userData["mail"]
                    
                    self.defaults.set(id, forKey: "id")
                    self.defaults.set(username, forKey: "username")
                    self.defaults.set(mail, forKey: "mail")
                    self.defaults.set(userToken, forKey: "token")
                }
                
            } catch {
                
            }
        }
        task.resume()
        
        return
    }
}
