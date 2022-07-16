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
        
        creationPostService.createText(title: title, content: content)
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
