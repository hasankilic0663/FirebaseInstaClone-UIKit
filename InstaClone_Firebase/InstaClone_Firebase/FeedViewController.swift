//
//  FeedViewController.swift
//  InstaClone_Firebase
//
//  Created by Hasan Hüseyin Kılıç on 18.10.2024.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
   

    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let  cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FeedCell
        cell.userEmailLabel.text = "hasankilic0663@hotmail.com"
        cell.likeLabel.text = "100"
        cell.commentLabel.text = "Commennnt"
        cell.userImageView.image = UIImage(named: "select")
        return cell
        
    }

  

}
