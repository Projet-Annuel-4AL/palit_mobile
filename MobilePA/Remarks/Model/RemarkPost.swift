//
//  Remark.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

class RemarkPost {
    let idRemark: Int
    let content: String
    let user: User
    let idPost: Int

    internal init(idRemark: Int, content: String, user: User, idPost: Int) {
        self.idRemark = idRemark
        self.content = content
        self.user = user
        self.idPost = idPost
    }

    convenience init?(dict: [String: Any]){
        guard let idRemark = dict["id"] as? Int,
              let content = dict["content"] as? String,
              let user = dict["user"] as? [String: Any],
              let userObject = User(dict: user),
              let idPost = dict["idPost"] as? Int else {
            return nil
        }
        
        self.init(idRemark: idRemark, content: content, user: userObject, idPost: idPost)
    }
   
}



