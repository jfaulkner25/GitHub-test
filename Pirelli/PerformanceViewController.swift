//
//  PerformanceViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 28/12/2017.
//  Copyright © 2017 The Hungry Gorilla. All rights reserved.
//

import UIKit

class PerformanceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // Variables - UI Displayed Values
    var shortLostTime = 39
    var medLostTime = 140
    var longLostTime = 301
    
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
    
    
    

}
