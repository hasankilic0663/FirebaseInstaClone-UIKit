//
//  ViewController.swift
//  FirebaseInstaClone
//
//  Created by Hasan Hüseyin Kılıç on 16.10.2024.
//

import UIKit
import Firebase
import FirebaseAuth

class ViewController: UIViewController {

    @IBOutlet weak var passwordText: UITextField!
    @IBOutlet weak var emailText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
    }

    @IBAction func signInClicked(_ sender: Any) {
        if emailText.text != "" &&   passwordText.text != "" {
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!){ authdata , error in  // burada veritabanında sign ın oluyoz gırıs yapıyouz. cok kolayy
                if error != nil {
                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                    
                }else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
            
        }else{
            makeAlert(title: "Error!", message: "User or Password is empty!")
        }
        
    }
    @IBAction func signUpClicked(_ sender: Any) {
        if emailText.text != "" &&   passwordText.text != "" {
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { result, error in // result cevap veriyo ikinciside error veriyo yani if else yaparak hata mesajı varsa bişey yapazac else eger kullanıcı varsa sırunsuz olusturulduysa performsegue yapacaz
                if error != nil {
                    self.makeAlert(title: "Error!", message: error?.localizedDescription ?? "Error")
                }
            
                else{
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil  )
                    
                }
                
            }
        }else{
            makeAlert(title: "Error!", message: "User or Password is empty!")
        }
        
       
    }
    func makeAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

