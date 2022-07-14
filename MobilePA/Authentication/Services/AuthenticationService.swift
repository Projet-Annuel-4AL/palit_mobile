//
//  AuthenticationService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 13/07/2022.
//

import Foundation

protocol AuthenticationService {
    func login(mail: String, password: String)
    
}
