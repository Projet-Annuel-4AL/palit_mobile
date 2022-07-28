//
//  Avatar.swift
//  MobilePA
//
//  Created by Lucas Angoston on 28/07/2022.
//

import Foundation

class Avatar {

    let url: String
    
    internal init(url: String ) {
        self.url = url
    }
    
    convenience init?(dict: [String: Any]){
        
        guard let url = dict["url"] as? String else {
            return nil
        }
        
        self.init(url: url)
    }
}
