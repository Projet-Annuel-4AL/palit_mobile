//
//  RemarksWebService.swift
//  MobilePA
//
//  Created by Lucas Angoston on 16/07/2022.
//

import Foundation

class RemarkWebService: RemarkService {
    func getRemarksByPost(completion: @escaping ([RemarkPost]) -> Void, idPost: Int){
        let url = "http://52.208.34.20:3000/api/remarks/posts/" + String(idPost)
        
        guard let url = URL(string: url) else {
            completion([])
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, res, err in
            guard let fetchData = data,
                  let json = try? JSONSerialization.jsonObject(with: fetchData) as? [ [String: Any] ] else {
                completion([])
                return
            }
            
            let remarks  = json.compactMap{ remark in
                RemarkPost(dict: remark)
            }
            DispatchQueue.main.async {
                completion(remarks)
            }
        }
        dataTask.resume()
    }
    
    func createRemark(idPost: Int, content: String) {
        guard let url = URL(string: "http://52.208.34.20:3000/api/remarks") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let token = UserDefaults.standard.string(forKey: "token")
        
        guard let userToken = token else {
            return
        }
        
        request.setValue("Bearer \(userToken)", forHTTPHeaderField: "Authorization")
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        let body: [String: Any?] = [
            "idPost": idPost,
            "idUser": Int(idUser),
            "content": content,
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)

        let task = URLSession.shared.dataTask(with: request){
            data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do{
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                
            } catch {
                print(error)
            }
        }
        task.resume()
    }
}
