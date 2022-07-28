//
//  GroupUser.swift
//  MobilePA
//
//  Created by Lucas Angoston on 27/07/2022.
//

import Foundation

class GroupUser {
    let idGroup: Int
    let idUser: Int
    let group: Group
    
    internal init(idGroup: Int, idUser: Int, group: Group) {
        self.idGroup = idGroup
        self.idUser = idUser
        self.group = group
    }
    
    convenience init?(dict: [String: Any]) {
        guard let idGroup = dict["id"] as? Int,
              let idUser = dict["idUser"] as? Int,
              let group = dict["group"] as? [String: Any],
              let groupObject = Group(dict: group) else {
            return nil
        }
      
        self.init(idGroup: idGroup, idUser: idUser, group: groupObject)
    }
}
