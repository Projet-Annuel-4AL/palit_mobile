//
//  Group.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

class Group {
    let idGroup: Int
    let name: String
    let theme: String
    let description: String
    let idUser: Int
    
    internal init(idGroup: Int, name: String, theme: String, description: String, idUser: Int) {
        self.idGroup = idGroup
        self.name = name
        self.theme = theme
        self.description = description
        self.idUser = idUser
    }
    
    convenience init?(dict: [String: Any]) {
        guard let idGroup = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let theme = dict["theme"] as? String,
              let description = dict["description"] as? String,
              let idUser = dict["idGroupOwner"] as? Int else {
            return nil
        }
      
        self.init(idGroup: idGroup, name: name, theme: theme, description: description, idUser: idUser)
    }
}
