//
//  ArchiveVC.swift
//  wonderland
//
//  Created by Waynest on 2019/11/5.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class ArchiveCell: UITableViewCell{
    @IBOutlet weak var detail_label: UILabel!
    @IBOutlet weak var count_label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

class ArchiveVC: UITableViewController {
    // catalog fields
    var months : [MonthCatalog] = [MonthCatalog]()
    var tags: [Tag] = [Tag]()
    var metas : [ArticleMeta] = [ArticleMeta]()
    var is_showing_tags : Bool = false
    
    @IBOutlet weak var switch_button: UIBarButtonItem!

    @IBAction func switch_onclick(_ sender : Any){
        if self.is_showing_tags{
            self.switch_button.title = "In Tag"
        } else {
            self.switch_button.title = "In Time"
        }
        self.is_showing_tags = !self.is_showing_tags
        self.tableView.reloadData()
//        self.refresher.endRefreshing()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // call this function before jumping to this view
    func setup(metas: [ArticleMeta]){
        self.months = calc_month(metas: metas)
        self.tags = calc_tag(metas: metas)
        self.metas = metas
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if self.is_showing_tags{
            return self.tags.count
        } else {
            return self.months.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "archive_cell", for: indexPath) as! ArchiveCell
        // Configure the cell
        if(is_showing_tags){
            cell.detail_label?.text = tags[indexPath.row].tag_name
            cell.count_label?.text = String(tags[indexPath.row].tag_count) + "     "
        } else {
            cell.detail_label?.text = months[indexPath.row].get_time()
            cell.count_label?.text = months[indexPath.row].get_count()
        }
        cell.count_label.layer.cornerRadius = 10
        cell.count_label.layer.masksToBounds = true
        cell.count_label.layer.borderColor = UIColor.orange.cgColor;    cell.count_label.layer.borderWidth = 1
        return cell
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if let archivedListVC = segue.destination as? ArchivedListVC{
            var select_metas : [ArticleMeta] = [ArticleMeta]()
            // construct selected article list
            if let selectedCell = sender as? UITableViewCell{
                let indexPath = tableView.indexPath(for: selectedCell)!
                if is_showing_tags{
                    let identifier = tags[(indexPath as NSIndexPath).row]
                    for item in self.metas{
                        if item.tags.contains(identifier.tag_name){
                            select_metas.append(item)
                        }
                    }
                } else {
                    let id_year = months[(indexPath as NSIndexPath).row].year
                    let id_month = UInt32(months[(indexPath as NSIndexPath).row].month)
                    for item in self.metas{
                        if (id_year,id_month) == from_NSDate(date: item.createdTime){
                            select_metas.append(item)
                        }
                    }
                }
            }
            archivedListVC.articleList = select_metas
        }
    }
 
}

// Utils

// extract month and year from a NSDate
func from_NSDate(date: NSDate) -> (UInt32,UInt32){
    let str : String = date.description
    let ret_year = UInt32(str.prefix(4))!
    let ret_month = UInt32(str[str.index(str.startIndex,offsetBy: 5)..<str.index(str.startIndex, offsetBy: 7)])!
    
    return (ret_year,ret_month)
}

func calc_tag(metas: [ArticleMeta]) -> [Tag]{
    var tags = [String : Tag]()
    for meta in metas{
        for tag in meta.tags{
            if tags[tag] != nil{
                tags[tag]?.tag_count += 1
            } else {
                tags[tag] = Tag(tag_name: tag, tag_count: 1)
            }
        }
    }
    return Array(tags.values)
}

func calc_month(metas: [ArticleMeta]) -> [MonthCatalog]{
    var tags = [UInt32:MonthCatalog]()
    for meta in metas {
        // meta.createdTime
        let (year,month) = from_NSDate(date: meta.createdTime)
        let time_hash = year * 100 + month
        
        if tags[time_hash] != nil{
            tags[time_hash]?.count += 1
        } else {
            tags[time_hash] = MonthCatalog(month: UInt8(month), year: year, count: 1)
        }
        
    }
    return Array(tags.values)
}
