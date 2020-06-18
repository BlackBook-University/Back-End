//
//  LoginViewController.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 6/11/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class LoginViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!
    
    var rootRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be created
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func didTapCance(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func didTapLogIn(_ sender: Any) {
        Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text! , completion: {(user, error) in
            
            
            if(error == nil) {
                self.rootRef.child("user_profile").child((user?.user.uid)!).child("handle").observeSingleEvent(of: .value, with: {(snapshot: DataSnapshot) in
                    
                    if(!snapshot.exists()){
                        //user doesn't have a handle
                        //send user to the HandleView
                        self.performSegue(withIdentifier: "HandleViewSegue", sender: nil)
                    }else {
                        self.performSegue(withIdentifier: "HomeViewSegue", sender: nil)
                    }
                })
            } else {
                self.errorMessage.text = error?.localizedDescription
            }
        })
    }
    
}
