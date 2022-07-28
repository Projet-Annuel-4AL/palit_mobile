//
//  TextPostViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import UIKit

class TextPostViewController: UIViewController, UITextViewDelegate {

    
    @IBOutlet weak var titlePost: UITextField!
    @IBOutlet weak var contentText: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    var creationPostService: CreatePostTextService = CreatePostTextWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
        contentText.delegate = self
        
        contentText.text = "Commencer à écrire ..."
        contentText.textColor = UIColor.lightGray
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Commencer à écrire ..."
            textView.textColor = UIColor.lightGray
        }
    }
    
    @IBAction func submitTextPost(){
        guard let title  = self.titlePost.text else {
            return
        }
        
        guard let content  = self.contentText.text else {
            return
        }
        
        print(content.utf8EncodedString())
        
        if title.isEmpty {
            let alert = UIAlertController(title: "Votre titre semble vide", message: "Voici quelques idées: Mon premier Post, Faire son PA à 3h...", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
            NSLog("The \"OK\" alert occured.")
            }))
            self.present(alert, animated: true, completion: nil)
        }
        else if content.isEmpty || self.contentText.textColor == UIColor.lightGray {
                let alert = UIAlertController(title: "Vous n'avez pas de contenu à partager", message: "Raconter ce qui vous passe par la tête !", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                NSLog("The \"OK\" alert occured.")
                }))
                self.present(alert, animated: true, completion: nil)
        }
        else {
            creationPostService.createText(title: title, content: content)
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

extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}
