//
//  RemarksViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class RemarksViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableViewRemark: UITableView!
    @IBOutlet weak var contentTextField: UITextField!
    @IBOutlet weak var submitRemark: UIButton!
    
    var remarkService: RemarkService = RemarkWebService()
    var userService: UserService = UserWebService()
    
    let cellSpacingHeight: CGFloat = 5
    var idPost: Int!
    var remarks: [RemarkPost] = [] {
        didSet {
            self.tableViewRemark.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Commentaires"
        
        self.tableViewRemark.register(RemarkTableViewCell.nib(), forCellReuseIdentifier: RemarkTableViewCell.identifier)
        
        self.remarkService.getRemarksByPost(completion: { remarks in
            self.remarks = remarks
        }, idPost: self.idPost)
        
        self.tableViewRemark.delegate = self
        self.tableViewRemark.dataSource = self
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return remarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RemarkTableViewCell.identifier, for: indexPath) as! RemarkTableViewCell
        
        cell.configure(with: remarks[indexPath.row])
        
        return cell
    }
    
    @IBAction func handleRemark(){
        guard let content  = self.contentTextField.text else {
            return
        }
    
        remarkService.createRemark(idPost: idPost, content: content)
    }
    
    private func configure(with model: Post){
        self.idPost = model.idPost
    }
}
