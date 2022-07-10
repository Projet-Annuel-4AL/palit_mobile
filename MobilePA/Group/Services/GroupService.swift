//
//  GroupService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

protocol GroupService{
    func getGroups(completion: @escaping ([Group]) -> Void)
}
