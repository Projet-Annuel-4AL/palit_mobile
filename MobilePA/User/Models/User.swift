//
//  User.swift
//  MobilePA
//
//  Created by Lucas Angoston on 09/07/2022.
//

import Foundation

class User {

    let idUser: Int
    let firstName: String
    let lastName: String
    let mail: String
    let password: String
    
    internal init(idUser: Int, firstName: String, lastName: String, mail: String, password: String) {
        self.idUser = idUser
        self.firstName = firstName
        self.lastName = lastName
        self.mail = mail
        self.password = password
    }
    
    
    convenience init?(dict: [String: Any]){
        guard let idUser = dict["id"] as? Int,
              let firstName = dict["firstName"] as? String,
              let lastName = dict["lastName"] as? String,
              let mail = dict["mail"] as? String,
              let password = dict["password"] as? String else {
            return nil
        }
        
        
        self.init(idUser: idUser, firstName: firstName, lastName: lastName, mail: mail, password: password)
    }
}
