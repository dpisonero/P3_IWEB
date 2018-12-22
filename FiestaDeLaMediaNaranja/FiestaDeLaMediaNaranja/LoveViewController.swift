//
//  LoveViewController.swift
//  FiestaDeLaMediaNaranja
//
//  Created by user145055 on 10/28/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class LoveViewController: UIViewController {
    
    var love = Date()
    
    var cl: ((Date) -> ())?

    @IBOutlet weak var LovePicker: UIDatePicker!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let defaults = UserDefaults.standard
        if let love = defaults.object(forKey: "love") as? Date {
            LovePicker.date = love
        } else {
            LovePicker.date = love
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        defaults.set(LovePicker.date, forKey: "love")
        defaults.synchronize()
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "sl ok" {
            if LovePicker.date > Date() {
                let alert = UIAlertController(title: "Error", message: "La fecha es superior a la actual", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
                return false
            }
        }
        return true
    }
    


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sl ok" {
            
            cl?(LovePicker.date)
            
        } else if segue.identifier == "sl cancel" {
            
        }
    }

}
