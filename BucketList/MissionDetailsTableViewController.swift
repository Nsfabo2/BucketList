//
//  MissionDetailsTableViewController.swift
//  BucketList
//
// 
//

import UIKit

class MissionDetailsTableViewController: UITableViewController {
    
    weak var delegate: AddItemTableViewControllerDelegate?
    //variables
    var item: String?
    var indexPath: NSIndexPath?
    
    @IBOutlet weak var MissionTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MissionTextField.text = item
    }
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.cancelButtonPressed(by: self)
    }
    
    @IBAction func DoneBarButtonPressed(_ sender: UIBarButtonItem) {
        let text = MissionTextField.text!
        delegate?.itemSaved(by: self, with: text , at: indexPath )

    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }
    

   /* override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableCell", for: indexPath) as!  MyTableViewCell
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }*/

}
