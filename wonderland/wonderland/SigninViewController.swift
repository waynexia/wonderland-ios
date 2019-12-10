//
//  SigninViewController.swift
//  wonderland
//
//  Created by Forwhfang on 2019/12/3.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var hint: UILabel!
    @IBAction func confirm(_ sender: Any) {
        let um = username.text!
        let pw = password.text!
        var isRegistered = false
        for user in userList {
            if user.username == um {
                if user.password == pw {
                    currUsername = um
                    self.performSegue(withIdentifier: "Index", sender: self)
                } else {
                    hint.text = "密码错误"
                }
                isRegistered = true
                break
            }
        }
        if !isRegistered {
            hint.text = "账号不存在，请先去注册"
        }
        
    }
    
    @IBAction func jump_to_sign_up(_ sender: Any){
        guard let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") else {return}
//        self.dismiss(animated: true, completion: nil)
        self.present(signupVC, animated: true, completion: nil)
//        self.navigationController?.pushViewController(signupVC, animated: true)
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
        print("get into signin")
        
        if let userListFromFile = loadUserList() {
            userList = userListFromFile
        }
        else {
            userList = []
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if currUsername != ""{
            self.dismiss(animated: true, completion: nil)
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
