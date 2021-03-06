//
//  PMSViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 11/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit

class PMSViewController: UIViewController {

    // MARK: - UI Elements
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    
    // MARK: - Runtime
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
    }
    
    // MARK: - Navigation
    func configureNavigationBar() {
        navigationBar.setValue(true, forKey: "hidesShadow") // Hides the line shadow
        let shadow = hexStringToUIColor(hex: "000000")
        navigationBar.layer.shadowColor = shadow.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.topItem?.title = "IMPROVEMENTS"
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Gotham Book", size: 15)!]
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Color
    let backgroundColor = "#1E1F24"
    let pirelliYellow = "rgba(254, 209, 0, 1)"
    let pirelliClear = "rgba(254, 209, 0, 0)"
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    


}
