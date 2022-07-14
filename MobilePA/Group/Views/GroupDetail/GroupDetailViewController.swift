//
//  GroupDetailViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class GroupDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var groupTableview: UITableView!
    @IBOutlet weak var groupTitle: UILabel!
    //@IBOutlet weak var descriptionButton: UIButton!
    
    var groupService: GroupService = GroupWebService()
    let cellSpacingHeight: CGFloat = 5
    var group: Group!
    var posts: [GroupPost] = [] {
        didSet {
            self.groupTableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.groupTableview.delegate = self
        self.groupTableview.dataSource = self
        
        self.setGroupDetail()
        
        self.groupTableview.register(GroupDetailTableViewCell.nib(), forCellReuseIdentifier: GroupDetailTableViewCell.identifier)
        
        guard let groupDetail = self.group else {
            return
        }
        
        self.groupService.getPostsByIdGroup(completion: { posts in
            self.posts = posts
        }, idGroup: groupDetail.idGroup)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = groupTableview.dequeueReusableCell(withIdentifier: GroupDetailTableViewCell.identifier, for: indexPath) as! GroupDetailTableViewCell
        
        cell.configure(with: posts[indexPath.row])
        print(posts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    @IBAction func showDescription(){
        let alert = UIAlertController(title: "Description", message: group.description, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func setGroupDetail(){
        self.groupTitle.text = self.group.name
        self.groupTitle.numberOfLines = 0
        self.groupTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
