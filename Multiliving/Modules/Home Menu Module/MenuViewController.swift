//
//  MenuViewController.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 20/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var arrayOfHomeMenuItems : [HomeMenuItem] = []
    
    @IBOutlet weak var tableViewForMenu : UITableView!
    
    var user : UserInfo = UserDefaultsManager.shared.getSavedUserInfo()!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableViewForMenu.dataSource = self
        self.tableViewForMenu.delegate = self
        self.tableViewForMenu.tableFooterView = UIView()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.userInfoUpdated), name: Notification.Name("userInfoUpdateIdentifier"), object: nil)
        
        
        self.title = "My DOMA"
        
        let menuItem = HomeMenuItem(title: "\(user.firstName ?? "") \(user.lastName ?? "")", subTitle: user.email ?? "", type: .profileInfo)
        
        
        self.arrayOfHomeMenuItems.append(menuItem)
        self.arrayOfHomeMenuItems.append(HomeMenuItem(title: "Notifications", subTitle: nil, type: .notifications))
        self.arrayOfHomeMenuItems.append(HomeMenuItem(title: "Payment Options", subTitle: nil, type: .paymentOptions))
        self.arrayOfHomeMenuItems.append(HomeMenuItem(title: "Orders", subTitle: nil, type: .orders))
        
        addNavBarItems()
        registerNibs()
    }
    
    @objc func userInfoUpdated(notification: Notification) {
        
        self.user = UserDefaultsManager.shared.getSavedUserInfo()!
        
        let menuItem = HomeMenuItem(title: "\(user.firstName ?? "") \(user.lastName ?? "")", subTitle: user.email ?? "", type: .profileInfo)
        
        
        self.arrayOfHomeMenuItems[0] = menuItem
        
        
        DispatchQueue.main.async {
            self.tableViewForMenu.reloadRows(at: [IndexPath.init(row: 0, section: 0)], with: .automatic)
        }
    }
    
    func registerNibs(){
        
        self.tableViewForMenu.register(UINib(nibName: "HomeMenuProfileInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "homeMenuProfileInfoCell")
        
        self.tableViewForMenu.register(UINib(nibName: "HomeMenuGeneralItemTableViewCell", bundle: nil), forCellReuseIdentifier: "homeMenuGeneralItemCell")
    }
    
    func addNavBarItems(){
        
        let buttonForBack = UIButton(type: .custom)
        let image  = Constants.Images.imageForClose
        
        buttonForBack.setImage(image, for: .normal)
        buttonForBack.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonForBack.addTarget(self, action: #selector(MenuViewController.closeViewController), for: .touchUpInside)
        let barButtonItemForBack = UIBarButtonItem(customView: buttonForBack)
        
        self.navigationItem.setLeftBarButton(barButtonItemForBack, animated: false)
        
    }
    
    @objc func closeViewController(){
        
        DispatchQueue.main.async {
            self.navigationController?.dismiss(animated: true, completion: nil)
        }
    }
    
    
}

extension MenuViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayOfHomeMenuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let menuItem = self.arrayOfHomeMenuItems[indexPath.row]
        
        if menuItem.type == MenuType.profileInfo {
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeMenuProfileInfoCell") as! HomeMenuProfileInfoTableViewCell
            
            cell.selectionStyle = .none
            cell.loadItem(item: self.arrayOfHomeMenuItems[indexPath.row])
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "homeMenuGeneralItemCell") as! HomeMenuGeneralItemTableViewCell
            
            cell.selectionStyle = .none
            
            cell.loadItem(item: self.arrayOfHomeMenuItems[indexPath.row])
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let menuItem = self.arrayOfHomeMenuItems[indexPath.row]
        
        if menuItem.type == MenuType.profileInfo {
            
            let editProfileViewController = Constants.mainStoryboard.instantiateViewController(identifier: "editProfileVC") as! EditProfileViewController
            
            
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(editProfileViewController, animated: true)
            }
            
        }
    }
}

