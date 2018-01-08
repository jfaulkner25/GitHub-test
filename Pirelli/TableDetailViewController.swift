//
//  TableDetailViewController.swift
//  Pirelli
//
//  Created by James Faulkner on 08/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import UIKit

class TableDetailViewController: UIViewController {

    @IBOutlet weak var factoryLabel: UILabel!
    @IBOutlet weak var machineLabel: UILabel!
    
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
    }
}
