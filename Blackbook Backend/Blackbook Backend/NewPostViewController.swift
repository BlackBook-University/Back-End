//
//  NewPostViewController.swift
//  Blackbook Backend
//
//  Created by Nic Brathwaite on 6/25/20.
//  Copyright © 2020 Blackbook. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class NewPostViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate  {

    
    @IBOutlet weak var newPostTextView: UITextView!
    
    
    //create a reference to the database
    var databaseRef = Database.database().reference()
    var loggedINUser = Auth.auth().currentUser
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.loggedINUser = Auth.auth().currentUser
        
        newPostTextView.textContainerInset = UIEdgeInsets(top: 30, left: 20, bottom: 20, right: 20)
        newPostTextView.text = "What's goin on?"
        newPostTextView.textColor = UIColor.lightGray
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        //Dispose of any resources that can be recreated
    }

    @IBAction func didTapCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        if(newPostTextView.textColor == UIColor.lightGray) {
            
            newPostTextView.text = ""
            newPostTextView.textColor = UIColor.black
        }
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    @IBAction func didTapPost(_ sender: Any) {
        
        if(newPostTextView.text.count>0) {
            
            let key = self.databaseRef.child("posts").childByAutoId().key
            
            let childUpdates = ["/posts/\(self.loggedINUser!.uid)/\(key)/text": newPostTextView.text,
            "/posts/\(self.loggedINUser!.uid)/\(key)/timestamp":"\(NSDate().timeIntervalSince1970)"] as [String : Any]
            
            
            self.databaseRef.updateChildValues(childUpdates)
            
            dismiss(animated: true, completion: nil)
        }
    }
    
    
}
