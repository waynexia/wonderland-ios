//
//  article.swift
//  wonderland
//
//  Created by Apple on 2019/11/12.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import Foundation
import UIKit

class article: NSObject, NSCoding {
    var title: String?
    var abstract: String?
    var mainBody: String?
    var firstImage: UIImage?
    var tags: Array<String>?
    var categories: Array<String>?
    var createdTime: NSDate?
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("acticles")
    
    init(title: String?, abstract: String?, mainBody: String?, firstImage: UIImage?, tags: Array<String>?, categories: Array<String>?, createdTime: NSDate?) {
        self.title = title
        self.abstract = abstract
        self.mainBody = mainBody
        self.firstImage = firstImage
        if (self.firstImage == nil) {
            self.firstImage = UIImage(named: "./img/default.jpg")
        }
        self.tags = tags
        self.categories = categories
        self.createdTime = createdTime
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "titleKey")
        aCoder.encode(abstract, forKey: "abstractKey")
        aCoder.encode(mainBody, forKey: "mainBodyKey")
        aCoder.encode(firstImage, forKey: "firstImageKey")
        aCoder.encode(tags, forKey: "tagsKey")
        aCoder.encode(categories, forKey: "categoriesKey")
        aCoder.encode(createdTime, forKey: "createdTimeKey")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "titleKey") as? String
        abstract = aDecoder.decodeObject(forKey: "abstractKey") as? String
        mainBody = aDecoder.decodeObject(forKey: "mainBodyKey") as? String
        firstImage = aDecoder.decodeObject(forKey: "firstImageKey") as? UIImage
        tags = (aDecoder.decodeObject(forKey: "tagsKey") as? Array<String>?) ?? []
        categories = (aDecoder.decodeObject(forKey: "categoriesKey") as? Array<String>?) ?? []
        createdTime = (aDecoder.decodeObject(forKey: "createdTimeKey") as? NSDate?)!
    }
}
