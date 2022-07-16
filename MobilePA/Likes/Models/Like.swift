//
//  Like.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

class Like {
    
    let idLike: Int
    let idUser: Int
    let idPost: Int
    
    internal init(idLike: Int, idUser: Int, idPost: Int) {
        self.idLike = idLike
        self.idUser = idUser
        self.idPost = idPost
    }
    

    convenience init?(dict: [String: Any]){
        guard let idLike = dict["id"] as? Int,
              let idUser = dict["idUser"] as? Int,
              let idPost = dict["idPost"] as? Int else {
            return nil
        }
        
        self.init(idLike: idLike, idUser: idUser, idPost: idPost)
    }
}
