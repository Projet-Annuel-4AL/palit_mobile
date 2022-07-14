//
//  AuthenticationWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 13/07/2022.
//

import Foundation
import SwiftBCrypt

class AuthenticationWebService: AuthenticationService {
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
                } else if let token = responseParsed["access_token"] {
                    let userToken: String = token as! String
                    let userData = self.decode(jwtToken: userToken)
                    
                    let id = userData["sub"]
                    let username = userData["username"]
                    let mail = userData["mail"]
                    
                    self.defaults.set(id, forKey: "id")
                    self.defaults.set(username, forKey: "username")
                    self.defaults.set(mail, forKey: "mail")
                }
                
            } catch {
            }
        }
        task.resume()
        
        return
    }
    
    func decode(jwtToken jwt: String) -> [String: Any] {
      let segments = jwt.components(separatedBy: ".")
      return decodeJWTPart(segments[1]) ?? [:]
    }

    func base64UrlDecode(_ value: String) -> Data? {
      var base64 = value
        .replacingOccurrences(of: "-", with: "+")
        .replacingOccurrences(of: "_", with: "/")

      let length = Double(base64.lengthOfBytes(using: String.Encoding.utf8))
      let requiredLength = 4 * ceil(length / 4.0)
      let paddingLength = requiredLength - length
      if paddingLength > 0 {
        let padding = "".padding(toLength: Int(paddingLength), withPad: "=", startingAt: 0)
        base64 = base64 + padding
      }
      return Data(base64Encoded: base64, options: .ignoreUnknownCharacters)
    }

    func decodeJWTPart(_ value: String) -> [String: Any]? {
      guard let bodyData = base64UrlDecode(value),
        let json = try? JSONSerialization.jsonObject(with: bodyData, options: []), let payload = json as? [String: Any] else {
          return nil
      }

      return payload
    }
}
