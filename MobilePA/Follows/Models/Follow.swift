//
//  Follow.swift
//  MobilePA
//
//  Created by Lucas Angoston on 11/07/2022.
//

import Foundation

class Follow {
    let idFollow: Int
    let idUserFollowing: Int
    let idUserFollowed: Int
    let followedUser: User
    var description: String {
        return "idFollow: \(self.idFollow), idUserFollowing: \(self.idUserFollowing)"
    }

    internal init(idFollow: Int, idUserFollowing: Int, idUserFollowed: Int, followedUser: User) {
        self.idFollow = idFollow
        self.idUserFollowing = idUserFollowing
        self.idUserFollowed = idUserFollowed
        self.followedUser = followedUser
    }
    
    convenience init?(dict: [String: Any]){
        guard let idFollow = dict["id"] as? Int,
              let idUserFollowing = dict["idUserFollowing"] as? Int,
              let idUserFollowed = dict["idUserFollowed"] as? Int,
              let followedUser = dict["followedUser"] as? [String:Any],
              let followedUserObject = User(dict: followedUser) else {
            return nil
        }
        
        
        self.init(idFollow: idFollow, idUserFollowing: idUserFollowing, idUserFollowed: idUserFollowed, followedUser: followedUserObject)
        
    }
}
