//
//  TableDetailViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 08/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit
import Charts

class TableDetailViewController: UIViewController {

    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var factoryLabel: UILabel!
    @IBOutlet weak var machineLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    var factory = String()
    var machine = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        factoryLabel.text = factory
        machineLabel.text = machine
        
        configureNavigationBar()
    }
    
    // Navigation Bar - Configuration
    func configureNavigationBar() {
        navigationBar.setValue(true, forKey: "hidesShadow") // Hides the line shadow
        let shadow = hexStringToUIColor(hex: "000000")
        navigationBar.layer.shadowColor = shadow.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.topItem?.title = machine
        
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Gotham Book", size: 15)!]
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Color Code
    
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
    
    // Pie Chart
    var data: [String:Float] = ["OEE":83.8, "Size Change":8.2, "Relax":2.3, "Breakdown": 4.7, "Meeting":1]
    
    func setData(dataSet: Dictionary<String, Float>) -> [PieChartDataEntry] {
        var data: [PieChartDataEntry] = []
        for (key, value) in dataSet {
            let entry =  PieChartDataEntry(value: Double(value), label: key)
            data.append(entry)
        }
        return data
    }
    
    func configureCharts() {
        let set = setData(dataSet: data)
        
    }
    
}
