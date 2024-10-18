//
//  UploadViewController.swift
//  FirebaseInstaClone
//
//  Created by Hasan Hüseyin Kılıç on 17.10.2024.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseStorage

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
    
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func saveButton(_ sender: Any) {
        let storage = Storage.storage()
        let storageReference = storage.reference()//bu refersansı kullanarak hangı klasorde calısacagmıızı belırleyebılıyoruz
        let mediaFolder = storageReference.child("media") //klasor olusturma chıld ıle ıcıne . ıc ıce yapabılırsın klasorler
        
  
        let uuid = UUID().uuidString//uuıd verip stringe ceviriyo
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5)
            
            {
            let mediaReference = mediaFolder.child("\(uuid).jpg")
            mediaReference.putData(data,metadata: nil ) { metadata, error in
                if error != nil {
                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error!!")
                }else{
                    mediaReference.downloadURL { url, error in
                        if error == nil{
                            let imageUrl = url?.absoluteString//urlmi al stringe cevir demek
                            //DATABASE KISMI YAZILMAYA BAŞLANIYO 18 Ekim
                            
                            let firestoreDatabase = Firestore.firestore()
                            var firestoreReference : DocumentReference? = nil //(CRUD sistemini yapıyo bu )
                            
                            let firestorePost = ["imageUrl": imageUrl!, "postedBy": Auth.auth().currentUser!.email!, "postComment": self.nameText.text!,"date": FieldValue.serverTimestamp(), "likes": 0 ] as [String : Any]
                            
                            firestoreReference = firestoreDatabase.collection("Posts").addDocument(data: firestorePost, completion: { error in //hangi koleksıyone koysıun
                                if error != nil{
                                    
                                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error!!")
                                    print("asdasda")
                                }else {
                                    self.imageView.image = UIImage(named: "select")
                                    self.nameText.text = ""
                                    self.tabBarController?.selectedIndex = 0 // tabbarda kacıncı ındekse goruturıyım dıye soyluyo. 0 derse feed ekranına goturecek
                                }
                                
                            })
                                                                                                  
                                
                            }
                            
                        }
                    }
                }
            }
                
            
        }
        
    
    
}
