//
//  GroupService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

protocol GroupService{
    func getGroups(completion: @escaping ([Group]) -> Void)
    
    func getPostsByIdGroup(completion: @escaping ([GroupPost]) -> Void, idGroup: Int)
    
    func joinGroup(idGroup: Int)
    
    func quitGroup(idGroup: Int)
    
    func creategroup(name: String, description: String, theme: String)
    
    func deleteGroup(idGroup: Int)
    
    func getGroupsByUserId(completion: @escaping ([GroupUser]) -> Void, idUser: String)
    
    func getGroupByUserIdAndIdGroup(completion: @escaping (GroupUser) -> Void, idUser: String, idGroup: Int)
}
