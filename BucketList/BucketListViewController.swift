//
//  ViewController.swift
//  BucketList
/*
 bucketlist v1
 We will be implementing two more features into our application.
 First, when we click on any of our items we should be segued to a page where we can edit the item.
 Second, swipe to delete.
 
 bucketList v2
 Hint: We can look at the sender type to determine whether we are editing or not
 
 Persistent v1
 Persistent Add
 Now let's complete the add functionality. The main reason that our code doesn't work currently is that we previously were treating each item as a String type and now that we are using the item type that was created by Core Data we need to change our code accordingly.
 Persistent Update
 Similar to the add functionality go ahead and finish the Update functionality. This will be tougher than the Add functionality but it follows the same principle.
 */
//  
//

import UIKit
import CoreData

class BucketListViewController: UITableViewController, AddItemTableViewControllerDelegate {
    
    //coredata
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var items = [BucketListItem]()

    //request the db to get items
    func fetchAllItems(){
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        
       /* do{
            let result = try manageObjectContext.fetch(request)
            let items = result as! [BucketListItem]
        }catch{
            print("\(error)")
        }*/
            do{
                    let result = try manageObjectContext.fetch(request)
                    items = result as! [BucketListItem]
                }catch{
                    print("Something went wrong")
                }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        fetchAllItems()
    }
    
    //for the butttons
    func cancelButtonPressed(by controller: MissionDetailsTableViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    func itemSaved(by controller: MissionDetailsTableViewController, with text: String, at indexPath: NSIndexPath?) {
        if let ip = indexPath{
            let item = items[ip.row]
            item.text = text
        }
        else{
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: manageObjectContext) as! BucketListItem
            item.text = text
            items.append(item)
        }
        
        do{
            try manageObjectContext.save()
        }catch{
            print("\(error)")
        }
        
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
            }
     
   /* func cancelButtonPressed(by controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }*/
    
    //for segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if sender is UIBarButtonItem{
                    let navigationController = segue.destination as! UINavigationController
                    let controller = navigationController.topViewController as! MissionDetailsTableViewController
                    controller.delegate = self
                }
                else if sender is NSIndexPath{
                    let navigationController = segue.destination as! UINavigationController
                    let controller = navigationController.topViewController as! MissionDetailsTableViewController
                    controller.delegate = self
                    
                    let indexPath = sender as! NSIndexPath
                    let item = items[indexPath.row]
                    controller.item = item.text!
                    controller.indexPath = indexPath
                }
       }
    
    //for the tabel
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // dequeue the cell from our storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        // All UITableViewCell objects have a build in textLabel so set it to the model that is corresponding to the row in array
        cell.textLabel?.text = items[indexPath.row].text!
        // return cell so that Table View knows what to draw in each row
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "EditMission", sender: indexPath)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let item = items[indexPath.row]
        manageObjectContext.delete(item)
        do{
            try manageObjectContext.save()
        }catch{
            print("\(error)")
        }
        items.remove(at: indexPath.row)
        tableView.reloadData()
        
    }

}




