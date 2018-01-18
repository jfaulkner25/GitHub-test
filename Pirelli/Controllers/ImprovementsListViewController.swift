//
//  ImprovementsListViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 12/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit

class ImprovementsListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - UI Elements
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Dummy Data
    // Now on CIAction.Swift
    
    // MARK: - Runtime
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigationBar()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 70
        
        tableView.reloadData()
    }
    
    // MARK: TableView Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ImprovementListTableViewCell
        let action = actions[indexPath.row]
        cell.machineNameLabel.text = action.machine
        cell.statusLabel.text = action.status
        
        if (cell.statusLabel.text == "ONGOING") {
            cell.statusLabel.textColor = .orange
        } else if (cell.statusLabel.text == "COMPLETE") {
            cell.statusLabel.textColor = .green
        } else if (cell.statusLabel.text == "DUE") {
            cell.statusLabel.textColor = .red
        }
        
        cell.reporteeLabel.text = action.name
        cell.dateCompiledLabel.text = action.date
        cell.objectiveCountLabel.text = action.objectivesCount
        cell.profileImageView?.image = UIImage(named: action.image)
        cell.layer.backgroundColor = UIColor.clear.cgColor
        
        cell.tileView.backgroundColor = UIColor(red: 57/255.0, green: 57/255.0, blue: 57/255.0, alpha: 0.9)
        cell.tileView.layer.cornerRadius = 3.0
        cell.tileView.layer.masksToBounds = false
        cell.tileView.layer.shadowColor = UIColor.white.withAlphaComponent(0.2).cgColor
        cell.tileView.layer.shadowOffset = CGSize(width: 0, height: 0)
        cell.tileView.layer.shadowOpacity = 0.8
        return cell
    }

    
    // MARK: - Navigation
    func configureNavigationBar() {
        navigationBar.setValue(true, forKey: "hidesShadow") // Hides the line shadow
        let shadow = hexStringToUIColor(hex: "000000")
        navigationBar.layer.shadowColor = shadow.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.topItem?.title = "CI IMPROVEMENTS"
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Gotham Book", size: 15)!]
        
        let addItem = UIBarButtonItem(image: UIImage(named: "plus"), style: .plain, target: nil, action: "#selector")
        let navItem = UINavigationItem(title: "CI IMPROVEMENTS")
        navItem.rightBarButtonItem = addItem
        navigationBar.setItems([navItem], animated: false)
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
