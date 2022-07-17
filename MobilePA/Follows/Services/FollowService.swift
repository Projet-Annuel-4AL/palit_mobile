//
//  FollowService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 11/07/2022.
//

import Foundation


protocol FollowService{
    func getUserFollowedById(completion: @escaping ([Follow]) -> Void)
    
    func createFollow(idUser: Int)
    
    func deleteFollow(idFollow: Int)
    
    func getFollowByUserFollowingAndUserFollowed(completion: @escaping (Follow) -> Void, idUserFollowed: Int)
}
