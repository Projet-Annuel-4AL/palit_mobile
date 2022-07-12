//
//  GroupDetailTableViewCell.swift
//  MobilePA
//
//  Created by Lucas Angoston on 10/07/2022.
//

import UIKit

class GroupDetailTableViewCell: UITableViewCell {
    
    static let identifier = "GroupDetailTableViewCell"
    
    @IBOutlet weak var postText: UILabel!
    
    static func nib() -> UINib {
        return UINib(nibName: "GroupDetailTableViewCell", bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        postText.numberOfLines = 0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with models: Group){
        
    }
    
}
