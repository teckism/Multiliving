//
//  EditProfileViewController.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit



class EditProfileViewController: UIViewController {
    @IBOutlet weak var textViewForDescription : UITextView!
    
    @IBOutlet weak var textFieldForDOB : UITextField!
    @IBOutlet weak var textFieldForName : UITextField!
    @IBOutlet weak var textFieldForEmail : UITextField!
    @IBOutlet weak var textFieldForPhoneNumber : UITextField!
    @IBOutlet weak var labelForNameErrorLine: UILabel!
    @IBOutlet weak var labelForNameErrorMessage: UILabel!
    
    var dataCtlr : EditProfileDataController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if dataCtlr == nil {
            self.dataCtlr = EditProfileDataController()
        }
        
        
        // Do any additional setup after loading the view.
        
        self.title = "Edit Profile"
        
        self.textViewForDescription.textContainerInset = UIEdgeInsets(
            top: 0,
            left: -self.textViewForDescription.textContainer.lineFragmentPadding,
            bottom: 0,
            right: -self.textViewForDescription.textContainer.lineFragmentPadding);
        
        let user = self.dataCtlr!.userInfo
        
        
        let selectedDate = Date(fromString: user.dob!, format: .custom("dd/MM/yyyy"))
        
        
        let stringDate = selectedDate?.toString(style : .ordinalDay)
        let stringMonth = selectedDate?.toString(style : .month)
        let stringYear = selectedDate?.toString(format: .isoYear)
        
        let displayText = "\(stringDate ?? "") \(stringMonth ?? "") \(stringYear ?? "")";
        
        
        self.textFieldForName.text = "\(user.firstName ?? "") \(user.lastName ?? "")"
        self.textFieldForEmail.text = user.email ?? ""
        self.textFieldForPhoneNumber.text = user.phoneNumber ?? ""
        self.textFieldForDOB.text = displayText
        self.textViewForDescription.text = user.aboutMe ?? ""
        
        addNavBarItems()
    }
    
    
    func addNavBarItems(){
        
        let buttonForBack = UIButton(type: .custom)
        let image  = Constants.Images.imageForBack
        
        buttonForBack.setImage(image, for: .normal)
        buttonForBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonForBack.addTarget(self, action: #selector(EditProfileViewController.closeViewController), for: .touchUpInside)
        let barButtonItemForBack = UIBarButtonItem(customView: buttonForBack)
        
        self.navigationItem.setLeftBarButton(barButtonItemForBack, animated: false)
        
    }
    
    @objc func closeViewController(){
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func clickedSave(_ sender: Any) {
        
        if self.dataCtlr?.isUIValidated(name: self.textFieldForName.text?.trim() ?? "", aboutMe: self.textViewForDescription.text?.trim() ?? "") ?? false {
            self.dataCtlr?.saveUserProfile(name: self.textFieldForName.text?.trim() ?? "", aboutMe: self.textViewForDescription.text?.trim() ?? "", dob: self.textFieldForDOB.text?.trim() ?? "")
            
            NotificationCenter.default.post(name: Notification.Name("userInfoUpdateIdentifier"), object: nil, userInfo: [:])

            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
}

extension EditProfileViewController : UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == textFieldForEmail || textField == textFieldForPhoneNumber {
            return false
        }
        
        if textField == textFieldForDOB {
            //DOB Handling
            let selectedDate = Date(fromString: (self.dataCtlr?.userInfo.dob!)!, format: .custom("dd/MM/yyyy"))
                   
            
            DateSelectionViewController.showDatePicker(currentlySelectedDate: selectedDate, inVC: self) { (selectedDate) in
                 
                   let stringDate = selectedDate.toString(style : .ordinalDay)
                   let stringMonth = selectedDate.toString(style : .month)
                   let stringYear = selectedDate.toString(format: .isoYear)
                   
                let displayText = "\(stringDate) \(stringMonth) \(stringYear)";
                self.dataCtlr?.currentSelectedDate = selectedDate
                   self.textFieldForDOB.text = displayText
            };
            return false
        }
        
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == self.textFieldForName {
            self.textFieldForName.text =  self.textFieldForName?.text?.trim()
            if var enteredText = self.textFieldForName.text, enteredText.count >= 3 {
                
                //Replacing Multiple places with single space
                while enteredText.contains("  ") {
                    enteredText = enteredText.replacingOccurrences(of: "  ", with: " ")
                }
                self.textFieldForName.text  = enteredText;
                
                if !enteredText.contains(" ") {
                    self.labelForNameErrorMessage.text = "Enter Firstname and Lastname"
                    self.labelForNameErrorLine.backgroundColor = Constants.Colors.kSaveColor
                }
                else{
                    self.labelForNameErrorMessage.text = ""
                    
                    self.labelForNameErrorLine.backgroundColor = Constants.Colors.kValidatedColor
                }
            }
            else{
                self.labelForNameErrorMessage.text = "Enter atleast 3 characters"
                
                self.labelForNameErrorLine.backgroundColor = Constants.Colors.kSaveColor
            }
        }
    }
}
