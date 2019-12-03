//
//  ArchivedListVC.swift
//  wonderland
//
//  Created by imac on 2019/12/3.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class ArchivedListVC: UITableViewController {
    
    var articleList: [ArticleMeta] = [ArticleMeta]()
    
    @IBAction func copy_title(sender: UILongPressGestureRecognizer){
        print("recognized")
        let alertController = UIAlertController(title:"文章标题已复制到剪切板",message: nil, preferredStyle: .alert)
        self.present(alertController,animated: true,completion: nil)
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1){
            self.presentedViewController?.dismiss(animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.rowHeight = 120

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        // #warning Incomplete implementation, return the number of rows
        return articleList.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archived_list_cell", for: indexPath) as? MockIndexTableViewCell

        cell?.title?.text = articleList[indexPath.row].title
        
        let cellAbstract = articleList[indexPath.row].abstract
        if cellAbstract.count < 10 {
            cell?.abstract?.text = cellAbstract
        } else {
            cell?.abstract?.text = String(cellAbstract[..<cellAbstract.index(cellAbstract.startIndex, offsetBy: 10)]) + " ......"
        }
        
        cell?.firstImage?.image = articleList[indexPath.row].firstImage
        
        let cellCreatedTime = articleList[indexPath.row].createdTime.description
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

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
    }

}

class MockIndexTableViewCell: UITableViewCell {
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstract: UILabel!
    @IBOutlet weak var createdTime: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
