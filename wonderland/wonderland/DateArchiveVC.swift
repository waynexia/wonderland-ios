//
//  DateArchiveVC.swift
//  wonderland
//
//  Created by Waynest on 2019/11/5.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class DateArchiveVC: UITableViewController {
    // month field
    var months : [MonthCatalog] = [MonthCatalog]()
    
    func init_months(){
        months.append(MonthCatalog(month: 1, year: 2017, count: 3))
        months.append(MonthCatalog(month: 5, year: 2018, count: 4))
        months.append(MonthCatalog(month: 9, year: 2019, count: 1))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        init_months()

        // Do any additional setup after loading the view.
    }
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return months.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "month_cell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = months[indexPath.row].get_time()
        cell.detailTextLabel?.text = months[indexPath.row].get_count()
        
        return cell
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
