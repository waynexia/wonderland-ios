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

    @IBOutlet weak var detailTitle: UITextView!
    @IBOutlet weak var detailCreateDate: UITextView!
    @IBOutlet weak var detailTags: UITextView!
    @IBOutlet weak var detailText: UITextView!
    
    // 跳转到detail界面，赋值articleIndex
    var articleMeta: ArticleMeta?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(self.articleMeta != nil){
            // title
            self.detailTitle.text = self.articleMeta!.title
            // create time
            self.detailCreateDate.text = self.articleMeta!.createdTime.description
            // tags
            var tagsText = ""
            for index in 0..<self.articleMeta!.tags.count{
                tagsText += (self.articleMeta!.tags[index] + " ")
            }
            self.detailTags.text = tagsText
            // main content
            let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 20))
            let content = self.loadDetail(contentIndex: self.articleMeta!.contentIndex)
            self.detailText.attributedText = markdownParser.parse(content ?? "")
        }
        else{
            print("articleMeta is nil")
        }
    }
    
    // 加载detailText的文本内容（index为nil，或文章不存在，返回nil）
    func loadDetail(contentIndex: UInt32) -> String?{
        if(contentIndex != nil){
            var articlesList = NSKeyedUnarchiver.unarchiveObject(withFile: ArticlesURL.path) as? [String]
            if(articlesList != nil){
                return articlesList?[Int(contentIndex)]
            }
            else{
                print("userLocalArticlesFile is nil")
                return nil
            }
        }
        else{
            print("articleIndex is nil")
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
