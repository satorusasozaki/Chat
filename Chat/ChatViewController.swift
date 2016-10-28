//
//  ChatViewController.swift
//  Chat
//
//  Created by Satoru Sasozaki on 10/27/16.
//  Copyright © 2016 Satoru Sasozaki. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController {

    @IBOutlet weak var messageField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func onSend(_ sender: UIButton) {
        if let text = messageField.text {
            let message = PFObject(className: "Message")
            message["text"] = text
            message.saveInBackground(block: {
            (success, error) -> Void in
                if let error = error {
                    let alert = UIAlertController(title: "Send failed", message: error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                } else {
                    print("\(text) is saved!")
                }
            })
        } else {
            let alert = UIAlertController(title: "Send failed", message: "Text is empty", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
