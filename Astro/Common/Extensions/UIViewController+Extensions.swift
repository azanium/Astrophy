//
//  UIViewController+Extensions.swift
//  Astro
//
//  Created by Suhendra Ahmad on 9/19/17.
//  Copyright © 2017 Ainasoft. All rights reserved.
//

import UIKit
import Hue

extension UIViewController {
    func titleTintColor() -> UIColor {
        return UIColor.white
    }
    
    func titleFont() -> UIFont {
        return UIFont.boldSystemFont(ofSize: 16)
    }
    
    func backgroundColor() -> UIColor {
        return UIColor(hex: "#454545")
    }
    
    func useShadow() -> Bool {
        return false
    }
    
    func navigationTranslucent() -> Bool {
        return false
    }
    
    func navigationItemTintColor() -> UIColor {
        return UIColor.white
    }
    
    func navigationBarTintColor() -> UIColor {
        return UIColor(hex: "#454545")
    }
    
    func navigationBarStyle() -> UIBarStyle {
        return UIBarStyle.blackTranslucent
    }
    
    func decorateNavigationBar() {
        self.navigationController?.navigationBar.barTintColor = self.navigationBarTintColor()
        self.navigationItem.leftBarButtonItem?.tintColor = self.navigationItemTintColor()
        self.navigationItem.rightBarButtonItem?.tintColor = self.navigationItemTintColor()
        self.navigationController?.navigationBar.tintColor = self.navigationItemTintColor()
        self.navigationController?.navigationBar.barStyle = self.navigationBarStyle()
        self.navigationController?.navigationBar.isTranslucent = self.navigationTranslucent()
        self.tabBarController?.tabBar.barTintColor = self.navigationBarTintColor()
        self.tabBarController?.tabBar.tintColor = self.navigationItemTintColor()
    }
}
