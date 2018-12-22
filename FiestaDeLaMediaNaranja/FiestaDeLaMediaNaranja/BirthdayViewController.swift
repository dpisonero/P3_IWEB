//
//  BirthdayViewController.swift
//  FiestaDeLaMediaNaranja
//
//  Created by user145055 on 10/21/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class BirthdayViewController: UIViewController {
    
    var birthday = Date()
    
    var cb: ((Date) -> ())?
    
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let birthday = defaults.object(forKey: "birthday") as? Date {
            birthdayPicker.date = birthday
        } else {
            birthdayPicker.date = birthday
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        defaults.set(birthdayPicker.date, forKey: "birthday")
        defaults.synchronize()
    }
    
    // MARK: - Navigation

    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sb ok" {
            if birthdayPicker.date > Date() {
                let alert = UIAlertController(title: "Error", message: "La fecha es superior a la actual", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
                return false
            }
        }
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sb ok" {
            
            cb?(birthdayPicker.date)
            
        } else if segue.identifier == "sb cancel" {
            
        }

    }

}
