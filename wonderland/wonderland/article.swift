//
//  article.swift
//  wonderland
//
//  Created by Wenhao Fang on 2019/11/12.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import Foundation
import UIKit

class ArticleMeta: NSObject, NSCoding {
    var title: String
    var abstract: String
    var firstImage: UIImage?
    var tags: Array<String>
    var createdTime: NSDate
    var contentIndex: UInt32
    static let DocumentDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentDirectory.appendingPathComponent("acticles")
    
    init(title: String, abstract: String, firstImage: UIImage?, tags: Array<String>, createdTime: NSDate, contentIndex: UInt32) {
        self.title = title
        self.abstract = abstract
        self.firstImage = firstImage
        if (self.firstImage == nil) {
            self.firstImage = UIImage(named: "./img/default.jpg")
        }
        self.tags = tags
        self.createdTime = createdTime
        self.contentIndex = contentIndex
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(title, forKey: "titleKey")
        aCoder.encode(abstract, forKey: "abstractKey")
        aCoder.encode(firstImage, forKey: "firstImageKey")
        aCoder.encode(tags, forKey: "tagsKey")
        aCoder.encode(createdTime, forKey: "createdTimeKey")
        aCoder.encode(contentIndex, forKey: "contentIndex")
    }
    
    required init?(coder aDecoder: NSCoder) {
        title = aDecoder.decodeObject(forKey: "titleKey") as! String
        abstract = aDecoder.decodeObject(forKey: "abstractKey") as! String
        firstImage = aDecoder.decodeObject(forKey: "firstImageKey") as? UIImage
        tags = aDecoder.decodeObject(forKey: "tagsKey") as! Array<String>
        createdTime = aDecoder.decodeObject(forKey: "createdTimeKey") as! NSDate
        contentIndex = aDecoder.decodeObject(forKey: "contentIndex") as! UInt32
    }
}

class Article: NSObject, NSCoding{
    var content: String
    
    init(content: String){
        self.content = content
    }
    
    override init(){
        self.content = ""
    }
    
    func encode(with aCoder: NSCoder){
        aCoder.encode(content, forKey:"content")
    }
    
    required init?(coder aDecoder: NSCoder){
        content = aDecoder.decodeObject(forKey:"content") as! String
    }
}
