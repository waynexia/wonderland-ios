//
//  SaveNoteVC.swift
//  wonderland
//
//  Created by Apple on 2019/11/26.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

// sj--未完成
/*
 保存页面：添加tags，文章梗概
 
 */


import UIKit

class SaveNoteVC: UIViewController {
    
    
    @IBOutlet weak var tags: UITextView!
    @IBOutlet weak var abstract: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tags.layer.borderWidth = 1;
        self.tags.layer.cornerRadius = 4;
        self.tags.layer.borderColor = UIColor.gray.cgColor
        self.tags.alpha = 0.8
        
        self.abstract.layer.borderWidth = 1;
        self.abstract.layer.cornerRadius = 4;
        self.abstract.layer.borderColor = UIColor.gray.cgColor
        self.abstract.alpha = 0.8
        // Do any additional setup after loading the view.
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
