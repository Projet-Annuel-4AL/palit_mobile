//
//  RegisterService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 16/07/2022.
//

import Foundation

protocol RegisterService {
    func register(firstname: String, lastname: String, mail: String, password: String)
    
}
