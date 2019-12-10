//
//  IndexTableViewController.swift
//  wonderland
//
//  Created by Forwhfang on 2019/11/12.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

import UIKit

class IndexTableViewController: UITableViewController, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filtered_article_list.removeAll(keepingCapacity: false)
        let search_key = searchController.searchBar.text!
        
        filtered_article_list = articleList.filter{ $0.title.contains(search_key) }
        
        self.tableView.reloadData()
    }
    
    
    @IBOutlet weak var searchbar : UISearchController?
    
    var articleList: [ArticleMeta] = [ArticleMeta]()
    var filtered_article_list = [ArticleMeta]()
    var articleMetaURL = loadArticleMetaURL()
    var resultSearchController = UISearchController()

    
    func saveArticleList() {
        let success = NSKeyedArchiver.archiveRootObject(articleList, toFile: articleMetaURL.path)
    }
    
    @IBAction func copy_title(sender: UILongPressGestureRecognizer){
        if sender.state == UIGestureRecognizer.State.ended{
            let alertController = UIAlertController(title:"文章标题已复制到剪切板",message: nil, preferredStyle: .alert)
            self.present(alertController,animated: true,completion: nil)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
                self.presentedViewController?.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    func loadArticleList() -> [ArticleMeta]? {
        return (NSKeyedUnarchiver.unarchiveObject(withFile: articleMetaURL.path) as? [ArticleMeta])
    }
    
    func initArticleList() {
        let article = ArticleMeta(title: "开始", abstract: "写新的博客！这是一篇使用教程", firstImage: nil, tags: ["tag1","tag2"], createdTime: NSDate(), contentIndex: 2147483647)
        articleList = []
        articleList.append(article)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if currUsername == ""{
            guard let signinVC = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") else {return}
            self.present(signinVC, animated: true, completion: nil)
        }
        
        self.tableView.rowHeight = 120
        
        resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func viewWillAppear(_ animated: Bool) {
        articleMetaURL = loadArticleMetaURL()
        if let articleListFromFile = loadArticleList() {
            articleList = articleListFromFile
        }
        else {
            initArticleList()
        }
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if resultSearchController.isActive{
            return filtered_article_list.count
        } else {
        return articleList.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as? IndexTableViewCell
        
        var articles_to_list = articleList
        if resultSearchController.isActive{
            articles_to_list = filtered_article_list
        }
        
        cell?.title?.text = articles_to_list[indexPath.row].title
        
        let cellAbstract = articles_to_list[indexPath.row].abstract
        if cellAbstract.count < 10 {
            cell?.abstract?.text = cellAbstract
        } else {
            cell?.abstract?.text = String(cellAbstract[..<cellAbstract.index(cellAbstract.startIndex, offsetBy: 10)]) + " ......"
        }
        
        if articles_to_list[indexPath.row].firstImage == nil{
            cell?.firstImage?.image = UIImage(named: "./img/default.jpg")
        } else {
            cell?.firstImage?.image = articles_to_list[indexPath.row].firstImage
        }
        
        let cellCreatedTime = articles_to_list[indexPath.row].createdTime.description
        cell?.createdTime?.text = String(cellCreatedTime[..<cellCreatedTime.index(cellCreatedTime.startIndex, offsetBy: 20)])
        
        return cell!
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if editingStyle == .delete {
             // Delete the row from the data source
            
            articleList.remove(at: indexPath.row)
            saveArticleList()
            tableView.deleteRows(at: [indexPath], with: .fade)
         }
        /*
         else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
         }
         */
     }
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        
        if let detailVC = segue.destination as? DetailVC {
            if let selectedCell4detail = sender as? UITableViewCell {
                let indexPath = tableView.indexPath(for: selectedCell4detail)
                let selectedArticleItem = articleList[(indexPath! as NSIndexPath).row]
                detailVC.articleMeta = selectedArticleItem
            }
        }
        
        if let archiveVC = segue.destination as? ArchiveVC{
            archiveVC.setup(metas: articleList)
        }
     }
    
    @IBAction func exit(segue: UIStoryboardSegue){
        
    }
    
}
