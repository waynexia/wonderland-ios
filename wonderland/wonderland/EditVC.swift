//
//  EditVC.swift
//  wonderland
//
//  Created by Apple on 2019/11/26.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit
import MarkdownKit

class EditVC: UIViewController {
    
    @IBOutlet weak var editTitle: UITextView!
    @IBOutlet weak var editContent: UITextView!
    @IBOutlet weak var previewButton: UIBarButtonItem!
    var content = ""
    
    @IBAction func previewClick(_ sender: Any) {
        if(previewButton.title == "Preview"){
            // 切换预览title为Edit
            previewButton.title = "Edit"
            // 暂存当前content
            self.content = self.editContent.text
            // 渲染为markdown格式
            let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 20))
            let content = self.content
            self.editContent.attributedText = markdownParser.parse(content)
            // 预览状态下不可编辑
            self.editTitle.isEditable = false
            self.editContent.isEditable = false
        }
        else{
            // 切换按钮title为Preview
            previewButton.title = "Preview"
            // 渲染为源文本
            self.editContent.text = self.content
            // 设置可编辑
            self.editTitle.isEditable = true
            self.editContent.isEditable = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // text view 样式
        
        // Do any additional setup after loading the view.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let saveNoteVC = segue.destination as? SaveNoteVC{
            saveNoteVC.noteTitle = self.editTitle.text
            saveNoteVC.noteContent = self.editContent.text
            // 默认abstract
            if((self.editContent.text != nil) && self.editContent.text!.count != 0){
                // 获取第一段内容作为梗概的默认值
                let paragraphs = self.editContent.text!.split(separator: "\n", maxSplits: 1, omittingEmptySubsequences: true).map(String.init)    // 会自动去除分隔符与空内容
                if(paragraphs.count != 0){
                    // 匹配markdown格式
                    let markdownParser = MarkdownParser(font: UIFont.systemFont(ofSize: 20))
                    saveNoteVC.defaultAbstract = (markdownParser.parse(paragraphs[0])).string
                }
            }
        }
    }
 
    
}

