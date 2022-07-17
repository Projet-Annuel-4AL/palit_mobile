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
    @IBOutlet weak var followButton: UIButton!
    
    let cellSpacingHeight: CGFloat = 5
    var idUser: Int!
    var follows: [Follow] = []
    var userFollowed: Follow!
    var isFollowed = false
    var userService: UserService = UserWebService()
    var postService: PostService = PostWebService()
    var followService: FollowService = FollowWebService()
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
        
        self.followButton.tintColor = UIColor.systemRed
        self.followButton.setTitle("Suivre", for: .normal)
        
        self.postsUserTableView.register(ProfileUserTableViewCell.nib(), forCellReuseIdentifier: ProfileUserTableViewCell.identifier)
        
        self.followService.getUserFollowedById{ follows in
            self.setFollowButton(follows: follows)
        }
        
        self.followService.getFollowByUserFollowingAndUserFollowed(completion: { follow in
            self.userFollowed = follow
        }, idUserFollowed: self.idUser)
        
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
    
    @IBAction func handleFollow(){
        if self.isFollowed {
            self.followButton.tintColor = UIColor.systemRed
            self.followButton.setTitle("Suivre", for: .normal)
            self.isFollowed = false
            self.followService.deleteFollow(idFollow: self.userFollowed.idFollow)
        } else {
            self.followButton.tintColor = UIColor.systemGreen
            self.followButton.setTitle("Suivi", for: .normal)
            self.isFollowed = true
            self.followService.createFollow(idUser: self.idUser)
        }
    }
    
    private func setFollowButton(follows: [Follow]){
        for follow in follows {
            if follow.idUserFollowed == self.idUser {
                self.followButton.tintColor = UIColor.systemGreen
                self.followButton.setTitle("Suivi", for: .normal)
                self.isFollowed = true
            }
        }
    }
        
    private func configure(with model: User){
        self.userName.text = model.firstName
    }
}
