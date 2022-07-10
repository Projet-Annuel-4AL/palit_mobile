//
//  PostText.swift
//  MobilePA
//
//  Created by Lucas Angoston on 09/07/2022.
//

import Foundation

class PostText {
    let idPostText: Int
    let content: String
    
    internal init(idPostText: Int, content: String) {
        self.idPostText = idPostText
        self.content = content
    }
    
    convenience init?(dict: [String: Any]){
        guard let idPostText = dict["id"] as? Int,
              let content = dict["content"] as? String else {
            return nil
        }
        
        self.init(idPostText: idPostText, content: content)
    }
}
