//
//  HomeViewController.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 6/25/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    
    var databaseRef = Database.database().reference()
    var loggedInUser: AnyObject?
    var loggedInUserData: AnyObject?
    
    @IBOutlet weak var aivLoading: UIActivityIndicatorView!
    
        
    @IBOutlet weak var homeTableView: UITableView!
    
    var posts: [AnyObject?] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.loggedInUser = Auth.auth().currentUser
        
        
        //Get logged in user's detail
    self.databaseRef.child("users_profile").child((self.loggedInUser?.uid)!).observeSingleEvent(of: .value, with: { (snapshot:DataSnapshot) in
        
            //store the logged in user's details into a variable
            self.loggedInUserData = snapshot
            
            // get all the tweets made by the user
            self.databaseRef.child("posts/\(self.loggedInUser!.uid)").observe(.childAdded, with: { (snapshot: DataSnapshot) in
                
                self.posts.append(snapshot)
                
//
                
                self.aivLoading.stopAnimating()
            }){(error) in
                
                print(error.localizedDescription)
            }
        })
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell: HomeViewTableViewCell = tableView.dequeueReusableCell(withIdentifier: "HomeViewTableViewCell", for: indexPath) as! HomeViewTableViewCell
        
//        let post = posts[(self.posts.count - 1) - indexPath.row]!.value["text"] as! String
        
//        cell.configure(nil, name: self.loggedInUserData!.value["name"] as! String, handle: self.loggedInUserData!.value["handle"] as! String, post: "whatever")
        
        return cell
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
