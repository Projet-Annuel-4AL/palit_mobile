//
//  UserService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 11/07/2022.
//

import Foundation


protocol UserService{
    func getUserById(completion: @escaping (User) -> Void, idUser: Int)
}
