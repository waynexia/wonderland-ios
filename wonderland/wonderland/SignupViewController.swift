//
//  SignupViewController.swift
//  wonderland
//
//  Created by Forwhfang on 2019/12/3.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var passwordConfirmed: UITextField!
    @IBOutlet weak var hint: UILabel!
    @IBAction func confirm(_ sender: Any) {
//        self.performSegue(withIdentifier: "Index Table View Controller", sender: self)
        
        let um = username.text!
        let pw = password.text!
        let pwcf = passwordConfirmed.text!
        var isRegistered = false
        for user in userList {
            if user.username == um {
                hint.text = "账号已存在，请直接登陆"
                isRegistered = true
                break
            }
        }
        if !isRegistered {
            if pw != pwcf {
                hint.text = "两次输入的密码不一致，请重新输入"
            } else {
                currUsername = um
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    var userList: [User] = [User]()

    func saveUserList() {
        NSKeyedArchiver.archiveRootObject(userList, toFile: userInfoURL.path)
    }
    
    func loadUserList() -> [User]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: userInfoURL.path) as? [User])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userListFromFile = loadUserList() {
            userList = userListFromFile
        }
        else {
            userList = []
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
