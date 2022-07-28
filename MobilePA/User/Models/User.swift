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
    let avatar: Avatar
    
    internal init(idUser: Int, firstName: String, lastName: String, mail: String, avatar: Avatar) {
        self.idUser = idUser
        self.firstName = firstName
        self.lastName = lastName
        self.mail = mail
        self.avatar = avatar
    }
    
    
    convenience init?(dict: [String: Any]){
        guard let idUser = dict["id"] as? Int,
              let firstName = dict["firstName"] as? String,
              let lastName = dict["lastName"] as? String,
              let mail = dict["mail"] as? String,
              let avatar = dict["avatar"] as? [String: Any],
              let avatarObject = Avatar(dict: avatar) else {
            return nil
        }
        
        self.init(idUser: idUser, firstName: firstName, lastName: lastName, mail: mail, avatar: avatarObject)
    }
}
