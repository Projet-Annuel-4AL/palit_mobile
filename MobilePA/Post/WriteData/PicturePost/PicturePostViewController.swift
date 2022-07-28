//
//  PicturePostViewController.swift
//  MobilePA
//
//  Created by Lucas Angoston on 16/07/2022.
//

import UIKit

class PicturePostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{

    @IBOutlet weak var titlePost: UITextField!
    @IBOutlet weak var pictureContent: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pictureContent.layer.borderWidth = 1
        self.pictureContent.layer.borderColor = UIColor.black.cgColor
        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleGallery(_ sender: Any){
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {
            return
        }
        self.pictureContent.image = image
        
        picker.dismiss(animated: true)
    }

}
