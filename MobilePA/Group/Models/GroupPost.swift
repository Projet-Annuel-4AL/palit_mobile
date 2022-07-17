//
//  GroupPost.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import Foundation

class GroupPost {
    let idGroupPost: Int
    let idPost: String
    let idGroup: String
    let post: Post
    
    internal init(idGroupPost: Int, idPost: String, idGroup: String, post: Post) {
        self.idGroupPost = idGroupPost
        self.idPost = idPost
        self.idGroup = idGroup
        self.post = post
    }
    
    convenience init?(dict: [String: Any]) {
        guard let idGroupPost = dict["id"] as? Int,
              let idPost = dict["idPost"] as? String,
              let idGroup = dict["idGroup"] as? String,
              let post = dict["post"] as? [String:Any],
              let postObject = Post(dict: post) else {
            return nil
        }
      
        self.init(idGroupPost: idGroupPost, idPost: idPost, idGroup: idGroup, post: postObject)
    }
}
