//
//  CIAction.swift
//  Pirelli
//
//  Created by James Faulkner on 12/01/2018.
//  Copyright © 2018 The Hungry Gorilla. All rights reserved.
//

import Foundation

struct CIAction {
    let machine: String
    let status: String
    let name: String
    let date: String
    let objectivesCount: String
    let image: String
}

let actions = [
    CIAction(machine: "VMI", status: "ONGOING", name: "James Faulkner", date: "25-03-2017", objectivesCount: "4/6", image: "1"),
    CIAction(machine: "CMP", status: "COMPLETE", name: "James Faulkner", date: "27-03-2018", objectivesCount: "6/6", image: "2"),
    CIAction(machine: "Fischer", status: "DUE", name: "James Faulkner", date: "12-03-2018", objectivesCount: "0/6", image: "3"),
    CIAction(machine: "Treadline", status: "ONGOING", name: "James Faulkner", date: "01-03-2018", objectivesCount: "4/6", image: "4")
]


