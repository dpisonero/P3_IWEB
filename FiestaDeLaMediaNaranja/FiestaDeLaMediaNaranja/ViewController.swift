//
//  ViewController.swift
//  FiestaDeLaMediaNaranja
//
//  Created by user145055 on 10/21/18.
//  Copyright © 2018 David. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var myBirthday: Date?
    
    var myLove: Date?
    
    var myFiesta: Date?
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    @IBOutlet weak var loveLabel: UILabel!
    
    @IBOutlet weak var fiestaLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        if let birthday = defaults.object(forKey: "birthday") as? Date {
            myBirthday = birthday
        /*} else {
            myBirthday = Date()*/
        }
        
        if let love = defaults.object(forKey: "love") as? Date {
            myLove = love
        /*} else {
            myLove = Date()*/
        }
        
        if let fiesta = defaults.object(forKey: "fiesta") as? Date {
            myFiesta = fiesta
        /*} else {
            myFiesta = Date()*/
        }
        
        update()
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        
        defaults.set(myBirthday, forKey: "birthday")
        defaults.set(myLove, forKey: "love")
        defaults.set(myFiesta, forKey: "fiesta")
        defaults.synchronize()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if let bd = myBirthday, let lv = myLove {
            
            let intervalo = lv.timeIntervalSince(bd)
            
            if intervalo < 0 {
                
                let alert = UIAlertController(title: "Error", message: "No puedes enamorarte antes de nacer", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default))
                present(alert, animated: true)
            }
        }
    }
    
    func update() {
        
        if let bd = myBirthday {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            dateFormatter.locale = Locale(identifier: "es_ES")
            
            let t = dateFormatter.string(from: bd)
            
            birthdayLabel.text = "Nací el \(t)"
        } else {
            birthdayLabel.text = "No sé cuándo nací"
        }
        
        if let lv = myLove {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            dateFormatter.locale = Locale(identifier: "es_ES")
            
            let l = dateFormatter.string(from: lv)
            
            loveLabel.text = "Me enamoré el \(l)"
        } else {
            loveLabel.text = "No sé cuándo me enamoré"
        }
        
        if let bd = myBirthday, let lv = myLove {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            
            dateFormatter.locale = Locale(identifier: "es_ES")
            
            let intervalo = lv.timeIntervalSince(bd)
            
            var mf: Date = lv
            
            mf.addTimeInterval(intervalo)
            
            let a = dateFormatter.string(from: mf)
            
            if intervalo < 0 {
                fiestaLabel.text = "Introduce las fechas anteriores"
            } else {
                fiestaLabel.text = "\(a)"
            }
        } else {
            fiestaLabel.text = "Introduce las fechas anteriores"
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "Select Birthday" {
            if let bvc = segue.destination as? BirthdayViewController {
                if let b = myBirthday {
                    bvc.birthday = b
                }
                
                bvc.cb = { (_ date:Date) -> () in
                    self.myBirthday = date
                    self.update()
                }
            }
        } else if segue.identifier == "Select Love" {
            if let lvc = segue.destination as? LoveViewController {
                if let l = myLove {
                    lvc.love = l
                }
                
                lvc.cl = { (_ date:Date) -> () in
                    self.myLove = date
                    self.update()
                }
            }
        }
    }
    
    @IBAction func firstPage(_ segue: UIStoryboardSegue){
        
    }
}

