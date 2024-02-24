//
//  DetailViewController.swift
//  TableViewApp1
//
//  Created by Aram on 23.02.24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var task: Task?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let task = self.task {
            titleLabel.text = task.description
        } else {
            titleLabel.text = "Please select task!"
        }
        
    }  
}
