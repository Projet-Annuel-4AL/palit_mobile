//
//  Post.swift
//  palitMobile
//
//  Created by Lucas Angoston on 09/07/2022.
//

import Foundation

class Post {
    
    let idPost: Int
    let title: String
    //let createdDate: Date
    //let idVideo: Int
    //let idPicture: Int
    let user: User
    //let code: Code
    let text: PostText
    let likes: [Like]
    let remarks: [Remark]
    
    internal init(idPost: Int, title: String, user: User, text: PostText, likes: [Like], remarks: [Remark]) {
        self.idPost = idPost
        self.title = title
        self.user = user
        self.text = text
        self.likes = likes
        self.remarks = remarks
        //self.createdDate = createdDate
    }
    
    
    convenience init?(dict: [String: Any]){
        guard let idPost = dict["id"] as? Int,
              let title = dict["title"] as? String,
              let user = dict["user"] as? [String: Any],
              let userObject = User(dict: user),
              let text = dict["text"] as? [String: Any],
              let textObject = PostText(dict: text),
              let likes = dict["likes"] as? [[String: Any]],
              let remarks = dict["remarks"] as? [[String: Any]] else {
            return nil
        }
        
        let likesObjects = likes.compactMap { like in
            return Like(dict: like)
        }
        
        let remarksObjects = remarks.compactMap { remark in
            return Remark(dict: remark)
        }
        
        self.init(idPost: idPost, title: title, user: userObject, text: textObject, likes: likesObjects, remarks: remarksObjects)
    }
}
