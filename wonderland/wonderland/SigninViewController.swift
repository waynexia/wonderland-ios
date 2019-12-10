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
    @IBAction func confirm(_ sender: Any) {
        let um = username.text!
        let pw = password.text!
        //check null fields
        if um == "" || pw == ""{
            let alert = UIAlertController(title: nil, message: "请输入用户名 / 密码", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"好的👌",style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            username.text = ""
            password.text = ""
            return
        }
        var isRegistered = false
        for user in userList {
            if user.username == um {
                if user.password == pw {
                    currUsername = um
//                    self.performSegue(withIdentifier: "Index", sender: self)
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(title: nil, message: "密码错误", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"好的👌",style: .default, handler: nil))
                    self.present(alert,animated: true,completion: nil)
                    password.text = ""
                }
                isRegistered = true
                break
            }
        }
        if !isRegistered {
            let alert = UIAlertController(title: nil, message: "账号不存在，请先去注册", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"好的👌",style: .default, handler: nil))
            self.present(alert,animated: true,completion: nil)
            username.text = ""
            password.text = ""
        }
        
    }
    
    @IBAction func jump_to_sign_up(_ sender: Any){
        guard let signupVC = self.storyboard?.instantiateViewController(withIdentifier: "SignUp") else {return}
        self.present(signupVC, animated: true, completion: nil)
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
