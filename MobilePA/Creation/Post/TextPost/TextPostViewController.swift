//
//  TextPostViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import UIKit

class TextPostViewController: UIViewController {

    @IBOutlet weak var textPost: UITextField!
    @IBOutlet weak var titlePost: UITextField!
    
    var creationPostService: CreatePostService = CreatePostWebService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func submitTextPost(){
        creationPostService.createTextPost()
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
