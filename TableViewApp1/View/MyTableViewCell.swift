//
//  MyTableViewCell.swift
//  TableViewApp1
//
//  Created by Aram on 23.02.24.
//

import UIKit

class MyTableViewCell: UITableViewCell {

    @IBOutlet weak var myLabel: UILabel!
    
    func configure(_ task: Task) {
        myLabel.text = task.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    

}
