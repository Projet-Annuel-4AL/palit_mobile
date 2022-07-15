//
//  RegisterViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import UIKit

class RegisterViewController: UIViewController {
    var userService: UserService = UserWebService()
    var registerService: RegisterService = RegisterWebService()
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
        
        
        guard let firstname = self.firstnameTextField.text else {
            return
        }
        
        guard let lastname = self.lastnameTextField.text else {
            return
        }
        
        guard let mail = self.mailTextField.text else {
            return
        }
        
        guard let password = self.passwordTextField.text else {
            return
        }
        
        self.userService.getUserByMail(completion: { user in
            self.configure(with: user.mail)
        }, mail: mail)
       
        if(self.userMail == nil){
            if(password.count >= 8){
                if(self.isValidEmail(mail)){
                    let alert = UIAlertController(title: "Inscription Réussie !", message: "Vous n'avez plus qu'à vous connecter.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("Super", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
                else {
                    let alert = UIAlertController(title: "Mauvais format Email", message: "Votre email n'a pas le bon format souhaité. (exemple@test.com).", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                }
            } else {
                let alert = UIAlertController(title: "Votre mot de passe est trop court", message: "Votre mot de passe à besoin d'au moins 8 caractères.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "Ce mail existe déjà", message: "Essayez de vous connectez plutôt.", preferredStyle: .alert)
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
    
    private func configure(with model: String){
        self.userMail = model
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
