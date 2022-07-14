//
//  ProfileUserViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class ProfileUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var postsUserTableView: UITableView!
    @IBOutlet weak var userName: UILabel!

    let cellSpacingHeight: CGFloat = 5
    var idUser: Int!
    var userService: UserService = UserWebService()
    var postService: PostService = PostWebService()
    var postsByUser: [Post] = [] {
        didSet {
            self.postsUserTableView.reloadData()
        }
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.postsUserTableView.delegate = self
        self.postsUserTableView.dataSource = self

        self.title = "Profil"
        
        self.postsUserTableView.register(ProfileUserTableViewCell.nib(), forCellReuseIdentifier: ProfileUserTableViewCell.identifier)
        
        self.postService.getPostsByIdUser(completion: { posts in
            self.postsByUser = posts
        }, idUser: self.idUser)
        
        self.userService.getUserById(completion: { user in
            self.configure(with: user)
        }, idUser: self.idUser)
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postsByUser.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileUserTableViewCell.identifier, for: indexPath) as! ProfileUserTableViewCell
        
        cell.configure(with: postsByUser[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
    }
    
    private func configure(with model: User){
        self.userName.text = model.firstName
    }
}
