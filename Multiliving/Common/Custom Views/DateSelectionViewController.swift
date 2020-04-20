//
//  DateSelectionViewController.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit
import MaryPopin

class DateSelectionViewController: UIViewController {
    
    @IBOutlet weak var labelForCurrentDate: UILabel!
    @IBOutlet weak var datePickerView: UIDatePicker!
    
    var onSelection:((_ dateSelected : Date) -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    class func showDatePicker(currentlySelectedDate : Date?, inVC:UIViewController?, onActionDateSelection:@escaping ((_ selectedDate : Date )->Void)){
        DispatchQueue.main.async {
            let dialog = DateSelectionViewController(nibName: "DateSelectionViewController", bundle: nil)
            dialog.presentAsPopupInVC(parenVC: inVC)
            
            
            dialog.onSelection = onActionDateSelection
            
            if let date = currentlySelectedDate {
                
                let stringShortWeekday = date.toString(style : .shortWeekday)
                let stringDate = date.toString(style : .ordinalDay)
                let stringMonth = date.toString(style : .month)
                
                dialog.labelForCurrentDate.text = stringShortWeekday + ", " + stringDate +  " " + stringMonth
                
                let calendar = Calendar.current
                var components = DateComponents()
                components.day = Int(date.toString(format: .custom("dd")))
                components.month = Int(date.toString(format: .custom("MM")))
                components.year = Int(date.toString(format: .custom("yyyy")))
                
                dialog.datePickerView.setDate(calendar.date(from: components)!, animated: false)
            }
            else{
                
                let stringShortWeekday = dialog.datePickerView.date.toString(style : .shortWeekday)
                let stringDate = dialog.datePickerView.date.toString(style : .ordinalDay)
                let stringShortMonth = dialog.datePickerView.date.toString(style : .shortMonth)
                
                dialog.labelForCurrentDate.text = stringShortWeekday + ", " + stringDate +  " " + stringShortMonth
               
                
            }
            
        }
    }
    
    func presentAsPopupInVC(parenVC:UIViewController?) {
        if let parenVC = parenVC {
            self.setPopinTransitionStyle(.slide)
            self.view.frame = CGRect(x: 0.0, y: 0.0, width: parenVC.view.frame.width, height: parenVC.view.frame.height)
            parenVC.presentPopinController(self, animated: true, completion: {
            })
        }
    }
    
    @IBAction func cancelClicked(_ sender: Any) {
        
        self.parent?.dismissCurrentPopinController(animated: true)
        
    }
    
    @IBAction func setActionDateClicked(_ sender: Any) {
        self.parent?.dismissCurrentPopinController(animated: true)
        
        self.onSelection?(datePickerView.date)
    }
    
    @IBAction func datePickerChanged(_ sender: Any) {
        
        
        let stringShortWeekday = datePickerView.date.toString(style : .shortWeekday)
        let stringDate = datePickerView.date.toString(style : .ordinalDay)
        let stringShortMonth = datePickerView.date.toString(style : .shortMonth)
        
        self.labelForCurrentDate.text = stringShortWeekday + ", " + stringDate +  " " + stringShortMonth
    }
    
}
