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
    
    // 跳转到detail界面，赋值articleIndex
    var articleMeta: ArticleMeta?
    var curr_font_size = 20

    @IBOutlet weak var detailTitle: UITextView!
    @IBOutlet weak var detailCreateDate: UITextView!
    @IBOutlet weak var detailTags: UITextView!
    @IBOutlet weak var detailText: UITextView!
    
    @IBAction func adjust_font_size(sender : UIPinchGestureRecognizer){
        let scale = sender.scale
        if sender.state == UIGestureRecognizer.State.ended{
            var alertController : UIAlertController? = nil
            if scale > 1{
                curr_font_size += 4
                if curr_font_size > 40{
                    curr_font_size = 40
                }
                alertController = UIAlertController(title:"字体放大",message: nil, preferredStyle: .alert)
            } else {
                curr_font_size -= 4
                if curr_font_size < 8{
                    curr_font_size = 8
                }
                alertController = UIAlertController(title:"字体缩小",message: nil, preferredStyle: .alert)
            }
            let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: CGFloat(curr_font_size)))
            let content = self.loadDetail(contentIndex: self.articleMeta!.contentIndex)
            self.detailText.attributedText = markdownParser.parse(content ?? "")
            self.present(alertController!,animated: true,completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5){
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
    let ArticlesURL = loadArticleURL()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if(self.articleMeta != nil){
            // title
            self.detailTitle.text = self.articleMeta!.title
            // create time
            let cellCreatedTime = articleMeta!.createdTime.description
            self.detailCreateDate.text = String(cellCreatedTime[..<cellCreatedTime.index(cellCreatedTime.startIndex, offsetBy: 20)])
            // tags
            var tagsText = ""
            for index in 0..<self.articleMeta!.tags.count{
                tagsText += (self.articleMeta!.tags[index] + " ")
            }
            self.detailTags.text = tagsText
            // main content
            let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: CGFloat(curr_font_size)))
            let content = self.loadDetail(contentIndex: self.articleMeta!.contentIndex)
            self.detailText.attributedText = markdownParser.parse(content ?? "")
        }
        else{
            print("articleMeta is nil")
        }
    }
    
    // 加载detailText的文本内容（index为nil，或文章不存在，返回nil）
    func loadDetail(contentIndex: UInt32) -> String?{
        if contentIndex == 2147483647{
            return "开始使用，这是一篇使用教程。你可以使用markdown语法在这里编写你的博客，并且使用Preview模式来进行预览\nYou can use markdown grammar to write your blog, and use `Preview` mod to see what it will looks like"
        }
        var articlesList = NSKeyedUnarchiver.unarchiveObject(withFile: loadArticleURL().path) as? [Article]
        if(articlesList != nil){
            return articlesList?[Int(contentIndex)].content
        }
        else{
            print("userLocalArticlesFile is nil")
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
