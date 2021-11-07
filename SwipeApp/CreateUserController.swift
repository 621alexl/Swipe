//
//  CreateUserController.swift
//  SwipeApp
//
//  Created by Alex Li on 11/7/21.
//

import UIKit

class CreateUserController: UIViewController {
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickUserButton(_ sender: Any) {
        let defaults = UserDefaults.standard
        defaults.set(usernameField.text, forKey: "Username")

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
