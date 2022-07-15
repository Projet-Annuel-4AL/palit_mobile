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
    
    @IBAction func logOut(){
        let alert = UIAlertController(title: "Déconnection", message: "Voulez-vous être déconnecté ?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Default action"), style: .cancel, handler: nil ))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: ""), style: .destructive, handler: self.handleLogOut))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func handleLogOut(alert: UIAlertAction){
        UserDefaults.standard.removeObject(forKey: "mail")
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "username")
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = storyboard.instantiateViewController(identifier: "LoginNavigationController")
        
        // This is to get the SceneDelegate object from your view controller
        // then call the change root view controller function to change to main tab bar
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(loginViewController)
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
