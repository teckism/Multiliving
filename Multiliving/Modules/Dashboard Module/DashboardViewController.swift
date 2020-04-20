//
//  DashboardViewController.swift
//  Multiliving
//
//  Created by Pankaj Teckchandani on 16/04/20.
//  Copyright © 2020 Pankaj Teckchandani. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    var arrayOfDashboardMenuItems : [DashboardMenuItem] = []
    
    @IBOutlet weak var collectionViewForOptions : UICollectionView!
    @IBOutlet weak var labelForUserWelcome : UILabel!
    
    @IBOutlet weak var constraintForHeightCollectionView : NSLayoutConstraint!
    
    private var userInfo : UserInfo?
    
    var dataCtlr : DashboardDataController?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if dataCtlr == nil {
            self.dataCtlr = DashboardDataController()
        }
        
        
        if  let user = UserDefaultsManager.shared.getSavedUserInfo(){
            self.userInfo = user
        }
        else{
            self.dataCtlr?.getUserDataFromJsonFile()
            self.userInfo = UserDefaultsManager.shared.getSavedUserInfo()!
        }
        
        
        self.labelForUserWelcome.text = "Hi \(self.userInfo?.firstName ?? "") \(self.userInfo?.lastName ?? "")"
        NotificationCenter.default.addObserver(self, selector: #selector(self.userInfoUpdated), name: Notification.Name("userInfoUpdateIdentifier"), object: nil)
        
        
        // Do any additional setup after loading the view.
        
        
        arrayOfDashboardMenuItems.append(DashboardMenuItem(name: "GROCERIES", image: "groceries"))
        arrayOfDashboardMenuItems.append(DashboardMenuItem(name: "QUICK ERRANDS", image: "errands"))
        
        arrayOfDashboardMenuItems.append(DashboardMenuItem(name: "LAUNDRY", image : "laundry"))
        arrayOfDashboardMenuItems.append(DashboardMenuItem(name: "DAILY CHORES",image : "chores"))
        arrayOfDashboardMenuItems.append(DashboardMenuItem(name: "MAINTAINANCE", image : "settings"))
        arrayOfDashboardMenuItems.append(DashboardMenuItem(name: "OTHER SERVICES", image : "services"))
        
        DispatchQueue.main.async{
            self.constraintForHeightCollectionView.constant = self.collectionViewForOptions.contentSize.height
            
        }
        self.addNavBarItems()
    }
    
    @objc func userInfoUpdated(notification: Notification) {
        
        self.userInfo = UserDefaultsManager.shared.getSavedUserInfo()!
        self.labelForUserWelcome.text = "Hi \(self.userInfo?.firstName ?? "") \(self.userInfo?.lastName ?? "")"
        
    }
    
    func addNavBarItems(){
        
        let buttonForHome = UIButton(type: .custom)
        let image  = Constants.Images.imageForHome
        
        buttonForHome.setImage(image, for: .normal)
        buttonForHome.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        buttonForHome.addTarget(self, action: #selector(DashboardViewController.openHomeMenu), for: .touchUpInside)
        let barButtonItemForHome = UIBarButtonItem(customView: buttonForHome)
        
        
        
        let buttonForMenu = UIButton(type: .custom)
        let imageForMenu  = Constants.Images.imageForMenu
        
        buttonForMenu.setImage(imageForMenu, for: .normal)
        buttonForMenu.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        // buttonForBack.addTarget(self, action: #selector(BLUBaseViewController.closeViewController), for: .touchUpInside)
        let barButtonItemForMenu = UIBarButtonItem(customView: buttonForMenu)
        
        self.navigationItem.setLeftBarButton(barButtonItemForHome, animated: false)
        self.navigationItem.setRightBarButton(barButtonItemForMenu, animated: false)
    }
    
    @objc func openHomeMenu(){
        
        
        let menuNavCtlr = Constants.mainStoryboard.instantiateViewController(identifier: "menuNavCtlr") as! UINavigationController
        
        DispatchQueue.main.async {
            menuNavCtlr.modalPresentationStyle = .fullScreen
            self.navigationController?.present(menuNavCtlr, animated: true, completion: nil)
        }
    }
}


extension DashboardViewController : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrayOfDashboardMenuItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier : "homeScreenItemCell", for: indexPath) as!  HomeScreenItemCollectionViewCell
        
        cell.loadItem(item : self.arrayOfDashboardMenuItems[indexPath.row])
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/2.0 - 16.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
        
    }
    //these methods are to configure the spacing between items
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
