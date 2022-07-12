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
    
    var postService: PostService = PostWebService()
    let cellSpacingHeight: CGFloat = 5
    var group: Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGroupDetail()
        
        self.groupTableview.register(GroupDetailTableViewCell.nib(), forCellReuseIdentifier: GroupDetailTableViewCell.identifier)
        
        self.groupTableview.delegate = self
        self.groupTableview.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupDetailTableViewCell.identifier, for: indexPath) as! GroupDetailTableViewCell
        
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 9
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
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
