//
//  GroupsTableViewCell.swift
//  MobilePA
//
//  Created by Lucas Angoston on 21/07/2022.
//

import UIKit

class GroupsTableViewCell: UITableViewCell {

    @IBOutlet weak var groupTitle: UILabel!
    @IBOutlet weak var groupTheme: UIButton!
    @IBOutlet weak var groupDescription: UILabel!
    @IBOutlet weak var groupCellView: UIView!
    
    
    static let identifier = "GroupsTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "GroupsTableViewCell", bundle: nil)
    }
    
    var model: Group!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        groupCellView.layer.cornerRadius = 20
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with model: Group){
        self.model = model
        
        self.setGroupTitle()
        self.setGroupDescription()
        self.setGroupTheme()
    }
    
    func setGroupTitle(){
            self.groupTitle.text = model.name
            self.groupTitle.font = UIFont(name:"HelveticaNeue-Bold", size: 19.0)
        }
        
        func setGroupDescription(){
            self.groupDescription.text = self.truncateString(text: model.description)
            self.groupDescription.numberOfLines = 0
        }
        
        func setGroupTheme(){
            var config = UIButton.Configuration.tinted()
            config.subtitle = model.theme
            
            self.groupTheme.configuration = config
            self.groupTheme.isUserInteractionEnabled = true
        }
    
    private func truncateString(text: String) -> String{
            return (text.count > 85) ? text.prefix(85) + "..." : text
    }
    
}
