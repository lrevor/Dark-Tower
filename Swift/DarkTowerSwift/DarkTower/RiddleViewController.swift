//
//  RiddleViewController.swift
//  DarkTower
//
//  Created by Louis Revor on 3/8/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation
import UIKit

class RiddleViewController: UIViewController {
    @IBOutlet weak var bronzeButton: UIButton!
    @IBOutlet weak var silverButton: UIButton!
    @IBOutlet weak var goldButton: UIButton!
    @IBOutlet weak var bronzeLabel: UILabel!
    @IBOutlet weak var silverLabel: UILabel!
    @IBOutlet weak var goldLabel: UILabel!
    var numCorrect = 0
    var tempString:NSString = ""
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        hideImages()
    }
    
    @IBAction func bronze (sender: UIButton) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        if (DarkTower.sharedInstance().riddle[numCorrect] == 1) {
            numCorrect++
            tempString = NSString(format: "%02d", numCorrect)
            bronzeLabel.text=tempString
            bronzeButton.enabled=false
            if (numCorrect==3) {
                DarkTower.sharedInstance().correctRiddle()
                performSegueWithIdentifier("towerBattle", sender: self)
            }
        } else {
            DarkTower.sharedInstance().wrongRiddle()
            performSegueWithIdentifier("wrongKeys", sender: self)
        }
    }
    @IBAction func silver (sender: UIButton) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        if (DarkTower.sharedInstance().riddle[numCorrect] == 2) {
            numCorrect++
            tempString = NSString(format: "%02d", numCorrect)
            silverLabel.text=tempString
            silverButton.enabled=false
            if (numCorrect==3) {
                DarkTower.sharedInstance().correctRiddle()
                performSegueWithIdentifier("towerBattle", sender: self)
            }
        } else {
            DarkTower.sharedInstance().wrongRiddle()
            performSegueWithIdentifier("wrongKeys", sender: self)
        }
    }
    @IBAction func gold (sender: UIButton) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        if (DarkTower.sharedInstance().riddle[numCorrect] == 3) {
            numCorrect++
            tempString = NSString(format: "%02d", numCorrect)
            goldLabel.text=tempString
            goldButton.enabled=false
            if (numCorrect==3) {
                DarkTower.sharedInstance().correctRiddle()
                performSegueWithIdentifier("towerBattle", sender: self)
            }
        } else {
            DarkTower.sharedInstance().wrongRiddle()
            performSegueWithIdentifier("wrongKeys", sender: self)
        }
    }
    
    func  hideImages() {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        var tempString:NSString = ""
        
        bronzeButton.hidden=false
        bronzeLabel.hidden=false
        silverButton.hidden=false
        silverLabel.hidden=false
        goldButton.hidden=false
        goldLabel.hidden=false
    }
}