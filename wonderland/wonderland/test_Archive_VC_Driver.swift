//
//  test_Archive_VC_Driver.swift
//  wonderland
//
//  Created by Waynest on 2019/11/26.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class test_Archive_VC_Driver: UIViewController {
    // test data
    let metas : [ArticleMeta] = [
        ArticleMeta(title: "foo", abstract: "foo", firstImage: nil, tags: ["tag1","tag2"], createdTime: NSDate.init(timeIntervalSinceNow: 24*60*60), contentIndex: 0),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let archiveVC = segue.destination as? ArchiveVC{
            archiveVC.setup(metas: metas)
        }
        else {
            print("unexpected destination : \(segue.destination)")
        }
    }

}
