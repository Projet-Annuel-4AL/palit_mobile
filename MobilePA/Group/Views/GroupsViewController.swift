//
//  GroupsViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class GroupsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet var groupCollectionView: UICollectionView!
    
    var groupService: GroupService = GroupWebService()
    var groups: [Group] = [] {
        didSet {
            self.groupCollectionView.reloadData() // recharge la tableview
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.groupCollectionView.register(GroupsCollectionViewCell.nib(), forCellWithReuseIdentifier: GroupsCollectionViewCell.identifier)
        self.groupService.getGroups { groups in
            self.groups = groups
        }
        
        self.groupCollectionView.delegate = self
        self.groupCollectionView.dataSource = self
        // Do any additional setup after loading the view.
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return groups.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = groupCollectionView.dequeueReusableCell(withReuseIdentifier: GroupsCollectionViewCell.identifier, for: indexPath) as! GroupsCollectionViewCell
        
        cell.configure(with: groups[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupDetail = GroupDetailViewController()
        
        let group = self.groups[indexPath.row]
        
        groupDetail.group = group
        
       
        self.navigationController!.pushViewController(groupDetail,animated:true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 300, height: 250)
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
