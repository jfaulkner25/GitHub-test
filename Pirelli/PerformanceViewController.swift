//
//  PerformanceViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 28/12/2017.
//  Copyright © 2017 The Hungry Gorilla. All rights reserved.
//

import UIKit
import Charts

class PerformanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Variables - UI Displayed Values
    var shortLostTime = 39
    var medLostTime = 140
    var longLostTime = 301
    
    // Chart View
    @IBOutlet weak var barChartView: BarChartView!
    
    // UI Elements
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var shortLabel: UILabel!
    @IBOutlet weak var medLabel: UILabel!
    @IBOutlet weak var longLabel: UILabel!
    
    // TableView Data Source
    var machines = ["Fischer", "CMP", "BY1", "ABC"]
    var currentStoppageCount = [106, 65, 30, 12]
    var totalStoppageCount = [156, 90, 98, 76]
    var status = ["Stopped", "Stopped", "Stopped", "Avaliable"]
    var oeeValue = [63.3, 54.6, 52.4, 96.3]
    
    // Runtime
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        shortLabel.text = String(shortLostTime)
        medLabel.text = String(medLostTime)
        longLabel.text = String(longLostTime)
        
        startTimer()
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
        
        for _ in 0...4 {
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
        setChart(dataPoints: machines, values: oeeValue)
    }
    
    func startTimer() {
        _ = Timer.scheduledTimer(timeInterval: 4, target: self, selector: #selector(randomArray), userInfo: nil, repeats: true)
    }

    // Charts - Run in ViewDidLoad()
    func setChart(dataPoints: [String], values: [Double]) {
        barChartView.noDataText = "No data found"
        
        var dataEntries: [BarChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i)+1, yValues: [values[i]])
            dataEntries.append(dataEntry)
        }
        
        let chartDataSet = BarChartDataSet(values: dataEntries, label: "Data")
        let chartData = BarChartData(dataSet: chartDataSet)
        barChartView.data = chartData
        
        
        // Chart Formatting
        let x = barChartView.xAxis
        x.labelPosition = .bottom
        x.labelFont = .systemFont(ofSize: 10)
        x.granularity = 1
        x.labelCount = 4
        x.drawGridLinesEnabled = false
        
        
        barChartView.leftAxis.axisMaximum = 100
        barChartView.leftAxis.axisMinimum = 0
        
        barChartView.legend.enabled = false
        barChartView.chartDescription?.enabled = false
        
        barChartView.rightAxis.enabled = false
    }
    
}
