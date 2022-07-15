//
//  RegisterViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import UIKit

class RegisterViewController: UIViewController {
    var userService: UserService = UserWebService()
    var userMail: String!
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var lastnameTextField: UITextField!
    @IBOutlet weak var firstnameTextField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerButton.isEnabled = false;
        let textfields : [UITextField] = [firstnameTextField, firstnameTextField, mailTextField, passwordTextField]
        
        for textfield in textfields {
          textfield.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        }
    }


    @IBAction func goToLogin(){
        let login = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginNavigationController") as! LoginViewController
            navigationController?.pushViewController(login, animated: true)
    }
    
    @IBAction func register(){
        
        
        guard let userMail = self.mailTextField.text else {
            return
        }
                
        self.userService.getUserByMail(completion: { user in
        
        }, mail: userMail)
        
        guard let mail = self.userMail else {
            return
        }
        print(mail)
       
        if(self.userMail == nil){
            
        } else {
            let alert = UIAlertController(title: "Ce mail existe déjà", message: "Essayez de vous connectez plutôt", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if mailTextField != nil && mailTextField.text != "" &&
            passwordTextField != nil && passwordTextField.text != "" &&
            lastnameTextField != nil && lastnameTextField.text != "" &&
            firstnameTextField != nil && firstnameTextField.text != "" {
            
            registerButton.isEnabled = true
            
        } else {
            registerButton.isEnabled = false
        }
    }
    
    private func configure(with model: User){
        let user = model
    
        self.userMail = user.mail
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
