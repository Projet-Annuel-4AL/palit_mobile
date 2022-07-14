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
        
        cell.configure(with: self.posts[indexPath.row])
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
    
    

}

extension PostViewController: PostTableViewCellDelegate {
    func goToProfile(idUser: Int) {
        let userProfile = ProfileUserViewController()
       
        userProfile.idUser = idUser
        self.navigationController?.pushViewController(userProfile, animated: true)
    }
    
    func goToRemarksOfPost() {
        let remarks = RemarksViewController()
       
        self.navigationController?.pushViewController(remarks, animated: true)
    }
}

