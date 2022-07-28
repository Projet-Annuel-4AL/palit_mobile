//
//  PostCode.swift
//  MobilePA
//
//  Created by Lucas Angoston on 18/07/2022.
//

import Foundation

class PostCode {
    let idPostCode: Int
    let language: String
    let content: String
    
    internal init(idPostCode: Int, language: String, content: String) {
        self.idPostCode = idPostCode
        self.language = language
        self.content = content
    }
    
    convenience init?(dict: [String: Any]){
        guard let idPostCode = dict["id"] as? Int,
              let language = dict["language"] as? String,
              let content = dict["content"] as? String else {
            return nil
        }
        
        self.init(idPostCode: idPostCode, language: language, content: content)
    }
}
