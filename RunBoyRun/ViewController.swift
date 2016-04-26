// Randy Blakeslee
// CS3200 Final Project

//
//  ViewController.swift
//  RunBoyRun
//
//  Created by Student User on 4/8/16.
//  Copyright © 2016 Student User. All rights reserved.
//

import UIKit


class ViewController: UIViewController {

    
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var routes = [Route]()
    var selectedRow = 0
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        print("initial view loaded")
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue) {
        let sourceVC = sender.sourceViewController as! NewRouteVC
         let newRouteTable = sourceVC.newRoute
            
            routes.append(newRouteTable)
            tableView.reloadData()
        
    }


}


extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routes.count
    }
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        
        cell.textLabel?.text = "\(routes[indexPath.row].routeNumber)"
        
        return cell
    }
    
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("Selected (\(indexPath.section),\(indexPath.row)")
        selectedRow = indexPath.row
        distanceLabel.text = "Total Distance: \(routes[indexPath.row].routeDistance)"
    }
}

