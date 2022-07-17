//
//  LikeService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 17/07/2022.
//

import Foundation

protocol LikeService{
    func createlike(idPost: Int)
    
    func deleteLike(idLike: Int)
}
