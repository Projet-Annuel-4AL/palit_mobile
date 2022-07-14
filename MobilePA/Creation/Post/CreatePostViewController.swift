//
//  CreatePostViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 14/07/2022.
//

import UIKit

class CreatePostViewController: UIViewController {

    @IBOutlet weak var createTextPost: UIView!
    
    @IBOutlet weak var createPicturePost: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func switchViews(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            createTextPost.alpha = 1
            createPicturePost.alpha = 0
        } else {
            createTextPost.alpha = 0
            createPicturePost.alpha = 1
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
