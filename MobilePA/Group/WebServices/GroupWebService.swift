//
//  Groups.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import Foundation

class GroupWebService: GroupService {
        
    func getGroups(completion: @escaping ([Group]) -> Void) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/groups")
        else {
            completion([])
            return
        }
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [ [String: Any] ] else {
                completion([])
                return
            }
            print(json)
            
            let groups  = json.compactMap{ group in
                Group(dict: group)
            }
            DispatchQueue.main.async {
                completion(groups)
            }
        }
        dataTask.resume() // start request
    }
}
