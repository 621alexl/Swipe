//
//  ViewController.swift
//  SwipeApp
//
//  Created by Alex Li on 11/7/21.
//

import UIKit
import Firebase
class ViewController: UIViewController {
    let ref = Database.database().reference()


    @IBOutlet weak var bidbutton: UILabel!

    @IBOutlet weak var descriptionField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var diningHallField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults.standard

        if let stringOne = defaults.string(forKey: "Username") {
            print(stringOne) // Some String Value
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func unwindToMainVC(segue: UIStoryboardSegue){
        print("unwinding to main VC")
    
    }
    @IBAction func bidButtonOnClick(_ sender: Any) {
        let defaults = UserDefaults.standard
        if (defaults.object(forKey: "Username") as! String == "NONE") {
            print("you need to set your user name dumbass")
            return
        }
        
        let diningHall = diningHallField.text
        let firstName =  firstNameField.text
        let lastName = lastNameField.text
        let description = descriptionField.text
        let currentDateTime = Date().description
        
        if (diningHall == "" ||
            firstName == "" ||
            lastName == "" ||
            description == ""
        
        ) {
            let alert = UIAlertController(title: "Missing Fields", message: "Make sure all the fields are filled in: " + description!, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))

            self.present(alert, animated: true)
            return
        }
        ref.child("/bidID").observeSingleEvent(of: .value) {
            (snapshot) in
            var bidID = snapshot.value as? Int

            print(bidID)
            

            
            if let unwrappedID = bidID {
                print("Hello, \(unwrappedID)!")
                var stringID = String(unwrappedID)
                self.ref.child("/bids/" + stringID).setValue([
                    "firstName": firstName,
                    "diningHall": diningHall,
                    "lastName": lastName,
                    "fulfilled": false,
                    "taken": false,
                    "bidID": bidID,
                    "description": description,
                    "fulfilledBy": "",
                    "user":defaults.string(forKey: "Username"),
                    "time": currentDateTime
                ])
                self.ref.child("bidID").setValue(unwrappedID+1)
            } else {
                let alert = UIAlertController(title: "Failed to submit swipe request", message: "Try again " + description!, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .cancel, handler: nil))

                self.present(alert, animated: true)
            }

        }
        

        diningHallField.text = ""
        firstNameField.text = ""
        lastNameField.text = ""
        descriptionField.text = ""
        
        
    }
    

}

