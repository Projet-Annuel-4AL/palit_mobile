//
//  ProfileViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class ProfileViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var currentUserPostsTableView: UITableView!
    
    var idUser: Int!
    let cellSpacingHeight: CGFloat = 5
    var postService: PostService = PostWebService()
    var postsByUser: [Post] = [] {
        didSet {
            self.currentUserPostsTableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentUserPostsTableView.delegate = self
        self.currentUserPostsTableView.dataSource = self
        
        self.title = "Profil"
        
        self.setUser()
        
        
        self.currentUserPostsTableView.register(ProfileCurrentUserTableViewCell.nib(), forCellReuseIdentifier: ProfileCurrentUserTableViewCell.identifier)
        
        guard let idCurrentUser = self.idUser else {
            return
        }
        
        self.postService.getPostsByIdUser(completion: { posts in
            self.postsByUser = posts
        }, idUser: idCurrentUser)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsByUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileCurrentUserTableViewCell.identifier, for: indexPath) as! ProfileCurrentUserTableViewCell
        
        cell.configure(with: postsByUser[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
    }
    
    private func setUser(){
        guard let username = UserDefaults.standard.string(forKey: "username") else {
            return
        }
        
        guard let idUser = UserDefaults.standard.string(forKey: "id") else {
            return
        }
        
        
        
        self.userName.text = username
        self.idUser = Int(idUser)
    }
}
