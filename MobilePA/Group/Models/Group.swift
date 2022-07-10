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
    
    internal init(idGroup: Int, name: String, theme: String, description: String) {
        self.idGroup = idGroup
        self.name = name
        self.theme = theme
        self.description = description
    }
    
    convenience init?(dict: [String: Any]) {
        guard let idGroup = dict["id"] as? Int,
              let name = dict["name"] as? String,
              let theme = dict["theme"] as? String,
              let description = dict["description"] as? String else {
            return nil
        }
      
        self.init(idGroup: idGroup, name: name, theme: theme, description: description)
    }
}
