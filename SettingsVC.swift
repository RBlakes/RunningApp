//
//  SettingsVC.swift
//  RunBoyRun
//
//  Created by Student User on 4/21/16.
//  Copyright © 2016 Student User. All rights reserved.
//

import UIKit

class SettingsVC : UIViewController {
    
    @IBOutlet weak var strideTextField: UITextField!
    @IBOutlet weak var walk: UISwitch!
    @IBOutlet weak var jog: UISwitch!
    @IBOutlet weak var run: UISwitch!
    
    @IBAction func walkSwitch(sender: AnyObject) {
        walk.setOn(true, animated: true)
        jog.setOn(false, animated: true)
        run.setOn(false, animated: true)
    }
    @IBAction func jogSwitch(sender: AnyObject) {
        walk.setOn(false, animated: true)
        jog.setOn(true, animated: true)
        run.setOn(false, animated: true)
    }
    @IBAction func runSwitch(sender: AnyObject) {
        walk.setOn(false, animated: true)
        jog.setOn(false, animated: true)
        run.setOn(true, animated: true)
    }
    
    var strideLength = 0
    
}
