//
//  TableViewCell.swift
//  HW12.1
//
//  Created by Григорий Душин on 20.05.2021.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var Label1: UILabel!
    
    @IBOutlet weak var Label2: UILabel!
    
    @IBOutlet weak var FeelsLike: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}
