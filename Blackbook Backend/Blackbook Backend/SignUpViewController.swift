//
//  SignUpViewController.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 6/11/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var signUp: UIBarButtonItem!
    @IBOutlet weak var errorMessage: UILabel!
    
    var databaseRef = Database.database().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        signUp.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func didTapSignup(_ sender: AnyObject) {
        signUp.isEnabled = false
        Auth.auth().createUser(withEmail: email.text!, password: password.text!, completion: {(user, error) in
            if(error != nil) {
                let code = (error! as NSError).code
                if(code == 17999) {
                    self.errorMessage.text = "Invalid Email Address"
                }
                else {
                    self.errorMessage.text = error?.localizedDescription
                }
            } else {
                self.errorMessage.text = "Registered Succesfully"
                Auth.auth().signIn(withEmail: self.email.text!, password: self.password.text!, completion: {(user, error) in
                    
                    if(error == nil){
                        self.databaseRef.child("user_profiles").child((user?.user.uid)!).child("email").setValue(self.email.text!)
                        
                        self.performSegue(withIdentifier: "HandleViewSegue", sender: nil)
                    }
                })
            }
        })
    }
    
    @IBAction func textDidChange(_ sender: UITextField) {
        if((email.text?.count)!>0 && (password.text?.count)!>0){
            signUp.isEnabled = true
        }
        else {
            signUp.isEnabled = false
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
