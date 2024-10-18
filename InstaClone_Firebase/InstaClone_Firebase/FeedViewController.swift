//
//  FeedViewController.swift
//  InstaClone_Firebase
//
//  Created by Hasan Hüseyin Kılıç on 18.10.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage


class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
   

    @IBOutlet weak var tableView: UITableView!
    
    var userEmailArray = [String]()
    var userCommentArray = [String]()
    var likeArray: [Int] = []
    var userImageArray = [String]() // 19 ile 17 deki dizi yazma yapısı aynı ıkısıde bos demek
    var documentIDArray: [String] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        getDataFromFirestore()
        // Do any additional setup after loading the view.
    }
    
    func getDataFromFirestore(){
        let fireStoreDatabase = Firestore.firestore()
       /* let settings = fireStoreDatabase.settings
        settings.areTimestamp*/ // bu eskide kalmıs devamı bıle cıkmadı
        
        fireStoreDatabase.collection("Posts").order(by: "date",descending: true)//order by ıle date yenıden eskıye sıralayarak getırıyo
            
            .addSnapshotListener { snapshot, error in // dokumanı goruntuleyıp cekme
            
            if error != nil{
                print(error?.localizedDescription)
            }else{
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.userEmailArray.removeAll()
                    self.userImageArray.removeAll()
                    self.userCommentArray.removeAll()
                    self.likeArray.removeAll()
                    self.documentIDArray.removeAll()
                    
                    for document in snapshot!.documents{ // dokuman dızısı verıyo
                        let documentID = document.documentID
                      
                        self.documentIDArray.append(documentID)
                        
                        if let postedBy =  document.get("postedBy") as? String{
                            self.userEmailArray.append(postedBy)
                        }
                        
                        if let postComment = document.get("postComment") as? String{
                            self.userCommentArray.append(postComment)
                            
                        }
                        
                        if let likes = document.get("likes") as? Int{
                            self.likeArray.append(likes)
                        }
                        if let imageURL = document.get("imageUrl") as? String{
                            self.userImageArray.append(imageURL)
                           
                        }
                    }
                    self.tableView.reloadData() // table ı yeniliyoruz
                                         
                }
              
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = userEmailArray[indexPath.row]
        
        cell.likeLabel.text = String(likeArray[indexPath.row])
        cell.commentLabel.text = userCommentArray[indexPath.row]
        cell.userImageView.sd_setImage(with: URL(string:   self.userImageArray[indexPath.row]))
        cell.documentIdLabel.text = documentIDArray[indexPath.row]
        return cell
        
    }

  

}
