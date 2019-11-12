//
//  DetailVC.swift
//  wonderland
//
//  Created by Songjia Chen on 2019/11/12.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit
import MarkdownKit

class DetailVC: UIViewController {

    @IBOutlet weak var detailText: UITextView!
    var archiveURL: URL?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 20))
        let markdown = self.loadDetail()
        self.detailText.attributedText = markdownParser.parse(markdown ?? "**URL** is nil")
    }
    
    func loadDetail() -> String?{
        if(self.archiveURL != nil){
            return NSKeyedUnarchiver.unarchiveObject(withFile: self.archiveURL!.path) as? String
        }
        else{
            return nil
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
