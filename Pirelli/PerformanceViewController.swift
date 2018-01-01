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
    var machines = ["Fischer", "CMP", "TreadLine", "Sidewall Line"]
    
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = machines[indexPath.row]
        return cell
    }
    
    
    

}
