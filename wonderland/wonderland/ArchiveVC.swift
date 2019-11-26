//
//  ArchiveVC.swift
//  wonderland
//
//  Created by Waynest on 2019/11/5.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class ArchiveVC: UIViewController {
    // catalog fields
    var months : [MonthCatalog]?
    var tags: [Tag]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // call this function when jumping to this view
    func setup(metas: [ArticleMeta]){
        self.months = calc_month(metas: metas)
        self.tags = calc_tag(metas: metas)
    }
    
    func calc_month(metas: [ArticleMeta]) -> [MonthCatalog]{
        var tags = [UInt32:MonthCatalog]()
        for meta in metas {
            // meta.createdTime
            let (month,year) = from_NSDate(date: meta.createdTime)
            let time_hash = month * 10000 + year
            
            if tags[time_hash] != nil{
                tags[time_hash]?.count += 1
            } else {
                tags[time_hash] = MonthCatalog(month: UInt8(month), year: year, count: 1)
            }
            
        }
        return Array(tags.values)
    }
    
    func calc_tag(metas: [ArticleMeta]) -> [Tag]{
        var tags = [String : Tag]()
        for meta in metas{
            for tag in meta.tags{
                tags[tag]?.tag_name = tag
                tags[tag]?.tag_count += 1
            }
        }
        return Array(tags.values)
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

// Utils

// extract month and year from a NSDate
func from_NSDate(date: NSDate) -> (UInt32,UInt32){
    let formatter : DateFormatter = DateFormatter()
    let str : String = formatter.string(from: date as Date)
    //        let ret_month = UInt8(str[0...4])
    let ret_month = UInt32(str.prefix(4))!
    //        let ret_year = UInt32(str[5...7])
    let ret_year = UInt32(str[str.index(str.startIndex,offsetBy: 5)..<str.index(str.startIndex, offsetBy: 7)])!
    
    return (ret_month,ret_year)
    
}
