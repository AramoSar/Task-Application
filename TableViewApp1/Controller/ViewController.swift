//
//  ViewController.swift
//  TableViewApp1
//
//  Created by Aram on 23.02.24.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myTextField: UITextField!
    @IBOutlet weak var myTableView: UITableView!
    
    private var tasks: [Task] =  Task.loadTask()    {
        didSet {
            Task.save(tasks)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        splitViewController?.preferredDisplayMode = .allVisible
        
        myTableView.tableFooterView = UIView()
         
        myTableView.delegate = self
        myTableView.dataSource = self
        
        let nib = UINib(nibName: "XibTableViewCell", bundle: nil)
        myTableView.register(nib, forCellReuseIdentifier: "xibCellID")
        
        myTextField.delegate = self
        
    }


}

// Mark: - Configute Table -
extension ViewController: UITableViewDelegate, UITableViewDataSource {
     
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "xibCellID", for: indexPath) as! XibTableViewCell
        
        cell.configure(tasks[indexPath.row])
        cell.delegate = self
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCellID", for: indexPath) as! MyTableViewCell
//        
//        cell.configure(tasks[indexPath.row])
//        
        //cell.myLabel.text = tasks[indexPath.row].title
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewControllerIdentifier") as? DetailViewController {
            vc.task = tasks[indexPath.row]
            splitViewController?.showDetailViewController(vc, sender: nil)
        }
        
        
        
//        let cell = tableView.cellForRow(at: indexPath)
//        if cell?.accessoryType == .checkmark {
//            cell?.accessoryType = .none
//        } else {
//            cell?.accessoryType = .checkmark
//        }
        
        
    }
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        let task = Task(title: textField.text ?? "", description: "Description text  ", isActive: true)
        self.tasks.append(task)
        myTableView.reloadData()
        textField.text = ""
        return true
    }
}

extension ViewController: XibTableViewCellDelegate {
    func didChangeActivity(_ cell: XibTableViewCell, isActive: Bool) {
        if let indexPath = myTableView.indexPath(for: cell) {
            tasks[indexPath.row].isActive = isActive
            Task.save(tasks)  

        }
    }
}
