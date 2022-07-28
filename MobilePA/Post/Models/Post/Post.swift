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
    let createdDate: String
    //let idVideo: Int
    //let idPicture: Int
    let user: User
    let code: PostCode
    let text: PostText
    let likes: [Like]
    let remarks: [Remark]
    
    internal init(idPost: Int, title: String, createdDate:String, user: User, code: PostCode, text: PostText, likes: [Like], remarks: [Remark]) {
        self.idPost = idPost
        self.title = title
        self.createdDate = createdDate
        self.user = user
        self.code = code
        self.text = text
        self.likes = likes
        self.remarks = remarks
    }
    
    
    convenience init?(dict: [String: Any]){
        
        
        guard let idPost = dict["id"] as? Int,
              let title = dict["title"] as? String,
              let createdDate = dict["createdDate"] as? String,
              let user = dict["user"] as? [String: Any],
              let userObject = User(dict: user),
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
        
        
        if let text = dict["text"] as? [String: Any] {
            guard let textObject = PostText(dict: text) else {
                return nil
            }
            
            let codeObject = PostCode(idPostCode: 0, language: "", content: "")
            self.init(idPost: idPost, title: title, createdDate: createdDate , user: userObject,code: codeObject ,text: textObject, likes: likesObjects, remarks: remarksObjects)
        }
        else {
            guard let code = dict["code"] as? [String: Any] else{
                return nil
            }
        
            guard let codeObject = PostCode(dict: code) else {
                return nil
            }
            
            let textObject = PostText(idPostText: 0, content: "")
            self.init(idPost: idPost, title: title, createdDate: createdDate , user: userObject,code: codeObject ,text: textObject, likes: likesObjects, remarks: remarksObjects)
        }
    }
}
