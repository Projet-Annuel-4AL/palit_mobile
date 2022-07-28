//
//  GroupsViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class GroupsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableViewGroup: UITableView!
    let cellSpacingHeight: CGFloat = 5
    
    var groupService: GroupService = GroupWebService()
    var groupsByUser: [GroupUser] = []
    var groups: [Group] = [] {
        didSet {
            self.tableViewGroup.reloadData()
        }
    }
    
    let myRefreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return refreshControl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableViewGroup.separatorColor = UIColor.white;
        
        self.tableViewGroup.register(GroupsTableViewCell.nib(), forCellReuseIdentifier: GroupsTableViewCell.identifier)
        
        self.groupService.getGroups { groups in
            self.groups = groups
        }
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        self.groupService.getGroupsByUserId(completion: { groups in
            self.groupsByUser = groups
        }, idUser: idUser)
        
        self.tableViewGroup.delegate = self
        self.tableViewGroup.dataSource = self
        
        self.tableViewGroup.refreshControl = myRefreshControl
    }
    
    @objc private func refresh(sender: UIRefreshControl){
        groups.removeAll()
        groupsByUser.removeAll()
        
        self.groupService.getGroups { groups in
            self.groups = groups
        }
        
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        self.groupService.getGroupsByUserId(completion: { groups in
            self.groupsByUser = groups
        }, idUser: idUser)
        
        self.tableViewGroup.reloadData()
        sender.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: GroupsTableViewCell.identifier, for: indexPath) as! GroupsTableViewCell
        
        cell.configure(with: groups[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let group = groups[indexPath.row]
              
        let idCurentUser = UserDefaults.standard.string(forKey: "id")
        
        guard let idUser = idCurentUser else {
            return
        }
        
        if Int(idUser) == group.idUser {
            let alert = UIAlertController(title: "Suppression en cours...", message: "Voulez-vous supprimez-votre groupe ?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("Non", comment: "Default action"), style: .cancel, handler: nil ))
            
            alert.addAction(UIAlertAction(title: NSLocalizedString("Oui", comment: ""), style: .destructive, handler: { action in
                self.groupService.deleteGroup(idGroup: group.idGroup)
                let alert = UIAlertController(title: "Suppression", message: "Groupe Supprimé ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
            
        } else {
            let alert = UIAlertController(title: "Oups !", message: "Hum, ça ne semble pas être votre groupe ... Vous ne pouvez pas le supprimer", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let groupDetail = GroupDetailViewController()
                
        let group = self.groups[indexPath.row]
        let isJoined = doesGroupIsJoin(groups: self.groupsByUser, idGroup: group.idGroup)
        
        groupDetail.isJoined = isJoined
        groupDetail.group = group
       
        self.navigationController!.pushViewController(groupDetail,animated:true)
    }
    
    private func doesGroupIsJoin(groups: [GroupUser], idGroup: Int) -> Bool {
        for group in groups {
            if group.group.idGroup == idGroup {
                return true
            }
        }
        return false
    }
}
