//
//  CustomTabbarController.swift
//  Memorabilia
//
//  Created by Alok Sahay on 08.09.2024.
//

import Foundation
import UIKit

class CustomTabbarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor.black
        self.tabBar.barTintColor = UIColor.white
        self.tabBar.unselectedItemTintColor = UIColor.darkGray
    }
}
