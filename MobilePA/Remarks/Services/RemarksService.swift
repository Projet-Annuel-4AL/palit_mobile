//
//  RemarksService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 16/07/2022.
//

import Foundation

protocol RemarkService{
    func getRemarksByPost(completion: @escaping ([RemarkPost]) -> Void, idPost: Int)
    
    func createRemark(idPost: Int, content: String)
}
