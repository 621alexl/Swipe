//
//  TakeViewController.swift
//  SwipeApp
//
//  Created by Alex Li on 11/7/21.
//

import UIKit
import FirebaseDatabase



class TakeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var bidScrollView: UIScrollView!
    
    @IBOutlet weak var titleLabel: UILabel!
    var x = 5
    
    @IBOutlet weak var bidTableView: UITableView!
    var tableViewData = [NSDictionary]()
    let ref = Database.database().reference()
    var databaseHandle:DatabaseHandle?
    
    @IBOutlet weak var verticalBidView: UIStackView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        let nib = UINib(nibName: "BidTableViewCell", bundle: nil)
//        bidTableView.register(nib, forCellReuseIdentifier: "BidTableViewCell")
//        bidTableView.delegate = self
        bidTableView.dataSource = self
        bidTableView.delegate = self

        bidTableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "TableViewCell")
//        bidTableView.dataSource = self
        
        ref.child("/bids").observeSingleEvent(of: .value, with: { (snapshot) in
            let bidArray = snapshot.value as? NSDictionary
            print(snapshot)
            if let unwrappedBidArray = bidArray {
                for bid in unwrappedBidArray {
                    let bidValue = bid.value as? NSDictionary
                    
                    if let unwrappedBidValue = bidValue {
                        let isFulfilled = unwrappedBidValue.object(forKey: "fulfilled") as? Bool
                        
                        if (isFulfilled != nil && isFulfilled != true) {
                            self.tableViewData.append(unwrappedBidValue)
                        }
                    }
                }
                self.bidTableView.reloadData()

            }
            else {
                print("hello")
            }
        })
        self.bidTableView.reloadData()
        }
    
    

        

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewData.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bid = self.tableViewData[indexPath.row]
        print(type(of: bid))
        
        let diningHall = bid.object(forKey: "diningHall") as? String
        let firstName = bid.object(forKey: "firstName") as? String
        let lastName = bid.object(forKey: "lastName") as? String
        let description = bid.object(forKey: "description") as? String
        let bidID = bid.object(forKey: "bidID") as? Int
        let bidIDString = String(bidID!)
        
        print(bidIDString)
        let alert = UIAlertController(title: "Swipe in " + firstName! + " " + lastName! + " at " + diningHall! + "?", message: "Description: " + description!, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.ref.child("/bids/" + bidIDString).observeSingleEvent(of: .value) {
                (snapshot) in
                print(snapshot)
            }
            self.ref.child("/bids/"+bidIDString+"/fulfilled").setValue(true)
            
            self.tableViewData.remove(at: indexPath.row)
            self.bidTableView.reloadData()

            
        }))
        

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell",
                                                 for: indexPath)
//        cell.textLabel?.text = self.tableViewData[indexPath.row]
        let bid = self.tableViewData[indexPath.row]
        
        print(type(of: bid))
        print(bid)
        
        let diningHall = bid.object(forKey: "diningHall") as? String
        let firstName = bid.object(forKey: "firstName") as? String
        let lastName = bid.object(forKey: "lastName") as? String

        cell.textLabel?.text = diningHall! + " " + firstName! + " " + lastName!
        
        return cell
    }
    // method to run when table view cell is tapped
    
}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */



