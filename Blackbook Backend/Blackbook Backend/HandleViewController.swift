//
//  HandleViewController.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 6/11/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class HandleViewController: UIViewController {

    
    
    @IBOutlet weak var fullName: UITextField!
    @IBOutlet weak var orgNames: UITextField!
    @IBOutlet weak var handle: UITextField!
    @IBOutlet weak var openBlackbook: UIBarButtonItem!
    @IBOutlet weak var errorMessage: UILabel!
    
    var user: AnyObject?
    var rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.user = Auth.auth().currentUser
        // Do any additional setup after loading the view.
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func didTapOpenBlackbook(_ sender: Any) {
        
        let handle = self.rootRef.child("handles").child(self.handle.text!).observe(.value, with: {(snapshot: DataSnapshot) in
            
            if(!snapshot.exists()) {
                //update handle in user_profile and in handles node
                self.rootRef.child("user_profiles").child(self.user!.uid).child("handle").setValue(self.handle.text!.lowercased())
                
                // update name of user
                self.rootRef.child("user_profiles").child(self.user!.uid).child("name").setValue(self.fullName.text!)
                
                // update handle in handle nodes
                
                self.rootRef.child("handles").child(self.handle.text!.lowercased()).setValue(self.user?.uid)
                
                // send user to home screen
                
                self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
            }
            else{
                self.errorMessage.text = "Handle already in use!"
            }
            
            })
    }
    
    
    @IBAction func didTapBack(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
