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
    // 上一个页面传来的数据
    var noteTitle: String?
    var noteContent: String?
    var defaultAbstract: String?
    
    // 本页面数据
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
        
        if(self.defaultAbstract != nil){
            self.abstract.text = self.defaultAbstract
        }
    }
    
    @IBAction func finishEditButton(_ sender: Any) {
        // 标签
        let tagsArray = self.tags.text.split(separator: " ", omittingEmptySubsequences: true).map(String.init)
        
        // 第一张图片
        var imgPath = ""
        // 匹配![]()
        let imgPatten = "!\\[[^\\[]*\\]\\([^\\)]*\\)"
        let imgRegex = try? NSRegularExpression(pattern: imgPatten, options: [])
        self.noteContent = "asdsadsadadsad ![123](./a/b/c.jpg)"
        if let imgResults = imgRegex?.matches(in: self.noteContent!, options: [], range: NSRange(location: 0, length: self.noteContent!.count)), imgResults.count != 0 {
            let matchResult = (self.noteContent! as NSString).substring(with: imgResults[0].range)
            // 匹配图片路径
            let imgPathPatten = "\\([^\\)]*\\)"
            let imgPathRegex = try? NSRegularExpression(pattern: imgPathPatten, options: [])
            if let imgPathResults = imgPathRegex?.matches(in: matchResult, options: [], range: NSRange(location: 0, length: matchResult.count)), imgPathResults.count != 0 {
                let matchResult = (matchResult as NSString).substring(with: imgPathResults[0].range)
                let startIndex = matchResult.index(matchResult.startIndex, offsetBy: 1)
                let endIndex =  matchResult.index(matchResult.startIndex, offsetBy: matchResult.count-1)
                imgPath = String(matchResult[startIndex..<endIndex])
                print(imgPath)
            }
        }
        let noteFirstImage = UIImage(named: imgPath)
        
        
        // 保存 article content
        let newArticleContent = Article(content: self.noteContent!)
        var localArticleContents = NSKeyedUnarchiver.unarchiveObject(withFile: ArticlesURL.path) as? [Article]
        let contentIndex = localArticleContents!.count  // 计算contentIndex供下边article metay用
        let newLocalArticleContents = localArticleContents!.append(newArticleContent)
        NSKeyedArchiver.archiveRootObject(newLocalArticleContents, toFile: ArticlesURL.path)
        
        // 保存 article meta
        let newArticleMeta = ArticleMeta(title: self.noteTitle!, abstract: self.abstract.text, firstImage: noteFirstImage, tags: tagsArray, createdTime: NSDate(), contentIndex: UInt32(contentIndex)) 
        var localArticleMeta = NSKeyedUnarchiver.unarchiveObject(withFile: ArticleMetaURL.path) as? [ArticleMeta]
        let newLocalArticleMeta = localArticleMeta!.append(newArticleMeta)
        NSKeyedArchiver.archiveRootObject(newLocalArticleMeta, toFile: ArticleMetaURL.path)
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
