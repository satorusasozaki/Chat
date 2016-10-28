//
//  LoginViewController.swift
//  Chat
//
//  Created by Satoru Sasozaki on 10/27/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func onLoginButton(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            PFUser.logInWithUsername(inBackground: email, password: password, block: {
                (user, error) -> Void in
                if user != nil {
                    // Do stuff after successful login.
                    print("Login success")
                } else {
                    // The login failed. Check error to see why.
                    let alert = UIAlertController(title: "Login failed", message: error?.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            })
        }
    }

    @IBAction func onSignupButton(_ sender: UIButton) {
        if let email = emailField.text, let password = passwordField.text {
            // var user = PFUser()
            // var is needed only when I need to assign the different address to user
            let user = PFUser()
            user.username = email
            user.password = password
            user.email = email
            user.signUpInBackground(block: {
                (succeeded, error) -> Void in
                if let error = error {
                    // Show the errorString somewhere and let the user try again.
                    let alert = UIAlertController(title: "Signup failed", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    // Hooray! Let them use the app now.
                    print("Signup success")
                }
            })
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTap(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
