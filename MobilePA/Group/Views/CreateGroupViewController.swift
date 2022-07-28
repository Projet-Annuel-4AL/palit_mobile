//
//  CreateGroupViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 27/07/2022.
//

import UIKit

class CreateGroupViewController: UIViewController {
    var groupService: GroupService = GroupWebService()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var nameGroup: UITextField!
    @IBOutlet weak var descriptionGroup: UITextField!
    @IBOutlet weak var themeGroup: UITextField!
    @IBOutlet weak var validateButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        validateButton.isEnabled = false;
        let textfields : [UITextField] = [nameGroup, descriptionGroup, themeGroup]
        
        for textfield in textfields {
          textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBAction func handlevalidateButton(){
        groupService.creategroup(name: nameGroup.text!, description: descriptionGroup.text!, theme: themeGroup.text!)
        
        let alert = UIAlertController(title: "Génial !", message: "Votre groupe  à bien été créer", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
        
        self.presentationController?.dismissalTransitionWillBegin()
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if nameGroup != nil && nameGroup.text != "" &&
            descriptionGroup != nil && descriptionGroup.text != ""  &&
            themeGroup != nil && themeGroup.text != ""{
            validateButton.isEnabled = true
        } else {
            validateButton.isEnabled = false
        }
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
