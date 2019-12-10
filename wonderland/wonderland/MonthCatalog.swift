//
//  MonthCatalog.swift
//  wonderland
//
//  Created by Waynest on 2019/11/5.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import Foundation

let Months: [String] = ["Jan.","Feb.","Mar.","Apr.","May","Jun.","Jul.","Aug.","Sep.","Oct.","Nov.","Dec."]

struct MonthCatalog{
    // start from 1, legal range: [1,12]
    var month : UInt8
    var year : UInt32
    var count: UInt32
    
    // get abbr. of a month
    // If self.month is illegal, `Unknow` will be return
    func get_time() -> String {
        if self.month<0 || self.month>12{
            return "Unknow"
        }
        return Months[Int(self.month - 1)] + " " + String(self.year)
    }
    
    func get_count() -> String{
        return String(self.count) + "     "
    }
}
