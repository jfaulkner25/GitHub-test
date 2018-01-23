//
//  PerformanceViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 28/12/2017.
//  Copyright © 2017 The Hungry Gorilla. All rights reserved.
//

import UIKit
import Charts

class PerformanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ChartViewDelegate{
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Variables - UI Displayed Values
    var shortLostTime = 39
    var medLostTime = 140
    var longLostTime = 301
    
    var selectedFactory = "MF2"
    
    // Chart View
    @IBOutlet weak var chartView: LineChartView!
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var medLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    // TableView Data Source
    var machines = ["Fischer", "CMP", "BY1", "ABC", "VMI1", "VMI2"]
    var currentStoppageCount = [106, 65, 30, 12, 23, 9]
    var totalStoppageCount = [156, 90, 98, 76, 102, 13]
    var status = ["Stopped", "Stopped", "Stopped", "Avaliable", "Breakdown", "Relax"]
    var oeeValue = [63.3, 54.6, 52.4, 96.3, 79.3, 56.6]
    
    // Dummy Data
    let months = ["Jan", "Feb", "Mar", "Apr", "May", "June", "July", "August", "Sept", "Oct", "Nov", "Dec"]
    let volume = [9566, 9311, 9674, 9676, 10345, 9875, 8657, 9123, 9345, 9477, 9677, 9511, 9611]
    
    // Runtime
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        shortLabel.text = String(shortLostTime)
        medLabel.text = String(medLostTime)
        longLabel.text = String(longLostTime)
        
        startTimer()
        
        viewStyling()
        configureNavigationBar()
    }
    
    
    // MARK: TableView Protocol
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return machines.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ProductionTableViewCell
        cell.machineLabel.text = machines[indexPath.row]
        cell.stopCountLabel.text = "\(currentStoppageCount[indexPath.row])mins/ \(totalStoppageCount[indexPath.row])mins"
        cell.statusLabel.text = status[indexPath.row]
        cell.oeeLabel.text = "\(oeeValue[indexPath.row])%"
        cell.layer.backgroundColor = UIColor.clear.cgColor

        if oeeValue[indexPath.row] > 70.0 {
            cell.oeeLabel.textColor = UIColor.green
        } else {
            cell.oeeLabel.textColor = UIColor.red
        }

        return cell
    }

    // MARK: Random Number Generator
    @objc func randomArray() {
        var resultOEE: [Double] = []
        var resultCurrentStoppage: [Int] = []
        var resultTotalStoppage: [Int] = []
        
        for _ in 0...machines.count {
            resultOEE.append(Double(arc4random_uniform(50)+50))
            resultCurrentStoppage.append(Int(arc4random_uniform(75)+20))
            resultTotalStoppage.append(Int(arc4random_uniform(100)+50))
        }
        oeeValue = resultOEE
        currentStoppageCount = resultCurrentStoppage
        totalStoppageCount = resultTotalStoppage
        
        print(oeeValue)
        tableView.reloadData()
        
        // Chart
        view.sendSubview(toBack: chartView)
        updateGraph()
    }
    
    func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(randomArray), userInfo: nil, repeats: true)
    }

    // MARK: Charts
    func updateGraph() {
        var lineChartEntry = [ChartDataEntry]()
        
        for i in 0..<volume.count {
            let value = ChartDataEntry(x: Double(i), y: Double(volume[i]))
            lineChartEntry.append(value)
        }
        
        let line1 = LineChartDataSet(values: lineChartEntry, label: "")
        line1.setColor(hexStringToUIColor(hex: "FED100"))
        line1.setCircleColor(hexStringToUIColor(hex: "FED100"))
        line1.drawCirclesEnabled = true
        line1.lineWidth = 2.0
        line1.circleRadius = 5.0
        line1.drawCircleHoleEnabled = true
        line1.mode = .cubicBezier
        
        let gradientColors = [ChartColorTemplates.colorFromString(pirelliClear).cgColor,
                              ChartColorTemplates.colorFromString(pirelliYellow).cgColor]
        let gradient = CGGradient(colorsSpace: nil, colors: gradientColors as CFArray, locations: nil)!
        
        line1.fillAlpha = 1
        line1.fill = Fill(linearGradient: gradient, angle: 90) 
        line1.drawFilledEnabled = true
        line1.valueTextColor = NSUIColor(displayP3Red: 164, green: 165, blue: 171, alpha: 100)
        
        
        let leftAxis = chartView.leftAxis
        leftAxis.drawGridLinesEnabled = false
        leftAxis.enabled = false
        
        
        let rightAxis = chartView.rightAxis
        rightAxis.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.drawGridLinesEnabled = false
        xAxis.enabled = false
        
        chartView.legend.enabled = false
        
        let data = LineChartData()
        data.addDataSet(line1)
        
        chartView.data = data
        chartView.pinchZoomEnabled = false
        chartView.doubleTapToZoomEnabled = false
        chartView.chartDescription?.text = ""
    }
    
    // MARK: Color
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
    
    // MARK: Stlying
    func viewStyling() {
        tableView.backgroundColor = .clear
        
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
    
    // MARK: - Navigation Bar
    func configureNavigationBar() {
        navigationBar.setValue(true, forKey: "hidesShadow") // Hides the line shadow
        let shadow = hexStringToUIColor(hex: "000000")
        navigationBar.layer.shadowColor = shadow.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.shadowRadius = 2
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        navigationBar.topItem?.title = "PIRELLI UK"
        navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: "Gotham Book", size: 15)!]
        
        let navItem = UINavigationItem(title: "PIRELLI UK")
        let doneItem = UIBarButtonItem(image: UIImage(named: "setting"), style: .plain, target: nil, action: "selector")
        navItem.rightBarButtonItem = doneItem
        navigationBar.setItems([navItem], animated: false);
    }

    
//    // MARK: Dropdown Menu
//    @IBAction func handleSelection(_ sender: UIButton) {
//        dropItems.forEach { (button) in
//            UIView.animate(withDuration: 0.3, animations: {
//                button.isHidden = !button.isHidden
//                self.view.layoutIfNeeded()
//            })
//        }
//    }
//    
//    @IBOutlet var dropItems: [UIButton]!
//    
//    @IBAction func itemTapped(_ sender: UIButton) {
//        guard let title = sender.currentTitle, let factory = factoryName(rawValue: title) else {
//            return
//        }
//        
//        switch factory {
//        case .factory2:
//            print("2")
//            selectedFactory = "MF2"
//        case .factory3:
//            print("3")
//            selectedFactory = "MF3"
//        case .factory4:
//            print("4")
//            selectedFactory = "MF4"
//        case .factory5:
//            print("5")
//            selectedFactory = "MF5"
//        }
//    }
//    
//    enum factoryName: String {
//        case factory2 = "MF2"
//        case factory3 = "MF3"
//        case factory4 = "MF4"
//        case factory5 = "MF5"
//    }
    
    // MARK: Segue
    let tableDetailSegueIdentifier = "ShowTableDetail"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == tableDetailSegueIdentifier,
            let destination = segue.destination as? TableDetailViewController,
            let stoppageIndex = tableView.indexPathForSelectedRow?.row {
                destination.factory = selectedFactory
                destination.machine = machines[stoppageIndex]
        }
    }
    
}

