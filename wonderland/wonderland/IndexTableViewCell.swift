//
//  IndexTableViewCell.swift
//  wonderland
//
//  Created by Apple on 2019/11/12.
//  Copyright © 2019 SCUT_wonderland. All rights reserved.
//

import UIKit

class IndexTableViewCell: UITableViewCell {

    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var abstract: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
