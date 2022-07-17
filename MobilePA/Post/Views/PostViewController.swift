//
//  ViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 09/07/2022.
//

import UIKit

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewPost: UITableView!
    private let refreshControl = UIRefreshControl()
      
    var postService: PostService = PostWebService()
    let cellSpacingHeight: CGFloat = 5
    var posts: [Post] = [] {
        didSet {
            self.tableViewPost.reloadData() // recharge la tableview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        self.tableViewPost.register(PostTableViewCell.nib(), forCellReuseIdentifier: PostTableViewCell.identifier)
        
        self.postService.getPosts{ posts in
            self.posts = posts
        }
        
        self.tableViewPost.delegate = self
        self.tableViewPost.dataSource = self
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PostTableViewCell.identifier, for: indexPath) as! PostTableViewCell
        
        let isLiked = getIdLike(likes: self.posts[indexPath.row].likes)
        
        cell.isliked = isLiked
        cell.configure(with: self.posts[indexPath.row], isLiked: isLiked)
        cell.delegate = self
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }
    
    func getIdLike(likes: [Like]) -> Bool {
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return false
        }
        
        for like in likes {
            if like.idUser == Int(idUser) {
                return true
            }
        }
        return false
    }
    

}

extension PostViewController: PostTableViewCellDelegate {
    func goToRemarksOfPost(idPost: Int) {
        let remarks = RemarksViewController()
       
        remarks.idPost = idPost
        self.navigationController?.pushViewController(remarks, animated: true)
    }
    
    func goToProfile(idUser: Int) {
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let currentUser = idCurentUser else {
            return
        }
        
        if idUser != Int(currentUser) {
            let userProfile = ProfileUserViewController()
           
            userProfile.idUser = idUser
            self.navigationController?.pushViewController(userProfile, animated: true)
        }
    }
}

