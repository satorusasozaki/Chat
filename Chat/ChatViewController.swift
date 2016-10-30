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
    @IBOutlet weak var tableView: UITableView!
    
    var texts: [PFObject]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100

        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(updateTexts), userInfo: nil, repeats: true)
        
        updateTexts()
        
        // Setup imagePicker
        imagePicker.delegate = self
    }
    
    @IBAction func onSend(_ sender: UIButton) {
        if let text = messageField.text {
            let message = PFObject(className: "Message")
            message["satoru"] = text
            message["user"] = PFUser.current()
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
        updateTexts()
    }
    
    func updateTexts() {
        let query = PFQuery(className: "Message")
        query.whereKeyExists("satoru")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground(block: {
        (objects, error) -> Void in
            print(objects?[0]["satoru"])
            print(objects?[1]["satoru"])
            self.texts = objects
        })
    }
    
    @IBAction func onAddImageButton(_ sender: UIButton) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = UIImagePickerControllerSourceType.savedPhotosAlbum
        present(imagePicker, animated: true, completion: nil)
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let texts = texts {
            return texts.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextCell") as! TextCell
        if let texts = texts {
            cell.messageLabel.text = texts[indexPath.row]["satoru"] as? String

            if let user = texts[indexPath.row]["user"] as? PFUser {
                cell.userLabel.isHidden = false
                cell.userLabel.text = user.username
            } else {
                cell.userLabel.isHidden = true
            }
        }
        return cell
    }
}

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
}
