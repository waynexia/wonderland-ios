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
    @IBAction func confirm(_ sender: Any) {
//        self.performSegue(withIdentifier: "Index Table View Controller", sender: self)
        
        let um = username.text!
        let pw = password.text!
        let pwcf = passwordConfirmed.text!
        // check null fields
        if um == "" || pw == "" || pwcf == ""{
            let alert = UIAlertController(title: nil, message: "不要留空哦😉", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"好的👌",style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            username.text = ""
            password.text = ""
            return
        }
        var isRegistered = false
        for user in userList {
            if user.username == um {
                let alert = UIAlertController(title: nil, message: "账号已存在，请直接登陆", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"好的👌",style: .default, handler: nil))
                self.present(alert,animated: true,completion: nil)
                isRegistered = true
                self.dismiss(animated: true, completion: nil)
                break
            }
        }
        if !isRegistered {
            if pw != pwcf {
                let alert = UIAlertController(title: nil, message: "两次输入的密码不一致，请重新输入", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title:"好的👌",style: .default, handler: nil))
                self.present(alert,animated: true,completion: nil)
                password.text = ""
                passwordConfirmed.text = ""
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
        password.isSecureTextEntry = true
        passwordConfirmed.isSecureTextEntry = true

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
