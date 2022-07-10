//
//  Remark.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

class Remark {
    
    let idRemark: Int
    let content: String
    let idUser: Int
    let idPost: Int
    
    internal init(idRemark: Int, content: String, idUser: Int, idPost: Int) {
        self.idRemark = idRemark
        self.content = content
        self.idUser = idUser
        self.idPost = idPost
    }
    
    convenience init?(dict: [String: Any]){
        guard let idRemark = dict["id"] as? Int,
              let content = dict["content"] as? String,
              let idUser = dict["idUser"] as? Int,
              let idPost = dict["idPost"] as? Int else {
            return nil
        }
        
        self.init(idRemark: idRemark, content: content, idUser: idUser, idPost: idPost)
    }
}
