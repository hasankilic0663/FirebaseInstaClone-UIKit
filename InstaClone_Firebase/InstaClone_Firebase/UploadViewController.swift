//
//  UploadViewController.swift
//  FirebaseInstaClone
//
//  Created by Hasan Hüseyin Kılıç on 17.10.2024.
//

import UIKit

class UploadViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    
    @IBOutlet weak var nameText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        imageView.isUserInteractionEnabled = true
             let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(chooseImage))
             imageView.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func chooseImage() {
          
          let pickerController = UIImagePickerController()
          pickerController.delegate = self
          pickerController.sourceType = .photoLibrary
          present(pickerController, animated: true, completion: nil)
          
      }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
          imageView.image = info[.originalImage] as? UIImage
          self.dismiss(animated: true, completion: nil)
      }    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func saveButton(_ sender: Any) {
    }
    
}
