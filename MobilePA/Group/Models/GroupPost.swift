//
//  GroupPost.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import Foundation

class GroupPost {
    let idGroupPost: Int
    let idPost: Int
    let idGroup: Int
    let post: Post
    
    internal init(idGroupPost: Int, idPost: Int, idGroup: Int, post: Post) {
        self.idGroupPost = idGroupPost
        self.idPost = idPost
        self.idGroup = idGroup
        self.post = post
    }
    
    convenience init?(dict: [String: Any]) {
        guard let idGroupPost = dict["id"] as? Int,
              let idPost = dict["idPost"] as? Int,
              let idGroup = dict["idGroup"] as? Int,
              let post = dict["post"] as? [String: Any],
              let postObject = Post(dict: post) else {
            return nil
        }
      
        self.init(idGroupPost: idGroupPost, idPost: idPost, idGroup: idGroup, post: postObject)
    }
}
