//
//  LoginViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 13/07/2022.
//

import UIKit

class LoginViewController: UIViewController {

    var authenticationService: AuthenticationService = AuthenticationWebService()
    let defaults = UserDefaults.standard
    
    @IBOutlet weak var mailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleLogin(){
        authenticationService.login(mail: mailTextField.text!, password: passwordTextField.text!)
        let mail = UserDefaults.standard.string(forKey: "mail")
         
        if let user = mail {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarController")
            
            // This is to get the SceneDelegate object from your view controller
            // then call the change root view controller function to change to main tab bar
            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(mainTabBarController)
        } else {
            let alert = UIAlertController(title: "Identifiants Incorrects", message: "Veuillez essayez de nouveau", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
    }

}
