//
//  PostService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 09/07/2022.
//

import Foundation

protocol PostService{
    func getPosts(completion: @escaping ([Post]) -> Void)
    
    func getPostsByIdUser(completion: @escaping([Post]) -> Void, idUser: Int)
}
