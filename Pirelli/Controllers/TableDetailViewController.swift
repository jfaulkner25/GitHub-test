//
//  TableDetailViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 08/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit
import Charts

class TableDetailViewController: UIViewController, ChartViewDelegate {

    // MARK: - UI Elements
    @IBOutlet weak var chartView: PieChartView!
    @IBOutlet weak var factoryLabel: UILabel!
    @IBOutlet weak var machineLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Global Variables
    var factory = String()
    var machine = String()
    
    
    // MARK: - Runtime
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chartView.delegate = self
        
        // Stlying
        configureCharts(dataPassed: data)
        viewStyling()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        factoryLabel.text = factory
        machineLabel.text = machine
        configureNavigationBar()
    }
    
    // MARK: - Navigation Bar
    func configureNavigationBar() {
        navigationBar.setValue(true, forKey: "hidesShadow") // Hides the line shadow
        let shadow = hexStringToUIColor(hex: "000000")
        navigationBar.layer.shadowColor = shadow.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.topItem?.title = ("\(machine) Summary").uppercased()
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Gotham Book", size: 15)!]
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Color
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
    
    func gradient(frame:CGRect) -> CAGradientLayer {
        let layer = CAGradientLayer()
        layer.frame = frame
        layer.startPoint = CGPoint(x: 0.5, y: 1)
        layer.endPoint = CGPoint(x: 0.5, y: 0)
        let color1 = hexStringToUIColor(hex: "#434343")
        let color2 = hexStringToUIColor(hex: "#000000")
        layer.colors = [
            color1.cgColor,color2.cgColor]
        return layer
    }
    
    // MARK: - Pie Chart
    var data: [String:Float] = ["OEE":83.8, "Size Change":8.2, "Relax":2.3, "Breakdown": 4.7, "Meeting":1]
    
    func setData(dataSet: Dictionary<String, Float>) -> [PieChartDataEntry] {
        var data: [PieChartDataEntry] = []
        for (key, value) in dataSet {
            let entry =  PieChartDataEntry(value: Double(value), label: key)
            data.append(entry)
        }
        return data
    }

    func configureCharts(dataPassed: Dictionary<String, Float>) {
        let entries:[PieChartDataEntry] = setData(dataSet: dataPassed)
        let set = PieChartDataSet(values: entries, label: "Stoppages")
        set.drawIconsEnabled = false
        set.colors = ChartColorTemplates.material()
        set.xValuePosition = .outsideSlice

        let data = PieChartData(dataSet: set)

        let pFormatter = NumberFormatter()
        pFormatter.numberStyle = .percent
        pFormatter.maximumFractionDigits = 1
        pFormatter.multiplier = 1
        pFormatter.percentSymbol = " %"
        data.setValueFont(.systemFont(ofSize: 11, weight: .light))
        data.setValueFormatter(DefaultValueFormatter(formatter: pFormatter))
        data.setValueTextColor(NSUIColor(displayP3Red: 164, green: 165, blue: 171, alpha: 100))
        
        chartView.centerText = "11-02-2017"
        chartView.legend.enabled = false
        chartView.chartDescription?.text = ""
        chartView.animate(xAxisDuration: 1.4, yAxisDuration: 1.4)
        chartView.data = data
        chartView.highlightValues(nil)
    }
    
    // MARK: - Stlying
    func viewStyling() {
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "bg-home-pad")
        backgroundImage.contentMode = UIViewContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        self.view.insertSubview(blurEffectView, at: 1)
        
        self.view.bringSubview(toFront: chartView)
        chartView.layer.zPosition = 10
    }
    
}


