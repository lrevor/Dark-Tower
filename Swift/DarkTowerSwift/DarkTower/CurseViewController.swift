//
//  CurseViewController.swift
//  DarkTower
//
//  Created by Louis Revor on 3/7/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation
import UIKit

class CurseViewController: UIViewController {
    @IBOutlet weak var playerAButton: UIButton!
    @IBOutlet weak var playerBButton: UIButton!
    @IBOutlet weak var playerCButton: UIButton!
    @IBOutlet weak var playerALabel: UILabel!
    @IBOutlet weak var playerBLabel: UILabel!
    @IBOutlet weak var playerCLabel: UILabel!
    var players:[NSInteger] = [0, 0, 0]
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        var i:NSInteger = 0
        for iter in 0..<DarkTower.sharedInstance().numPlayers {
            if (DarkTower.sharedInstance().player().playerID != iter) {
                players[i]=iter
                i++
            }
        }
        NSLog("[%@ %@] Curse Selection: %02d %02d %02d", reflect(self).summary, __FUNCTION__, players[0], players[1], players[2])
        hideImages()
    }
    
    @IBAction func curseA (sender: UIButton) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        DarkTower.sharedInstance().curse(players[0])
        performSegueWithIdentifier("exitCurse", sender: self)
    }
    @IBAction func curseB (sender: UIButton) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        DarkTower.sharedInstance().curse(players[1])
        performSegueWithIdentifier("exitCurse", sender: self)
    }
    @IBAction func curseC (sender: UIButton) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        DarkTower.sharedInstance().curse(players[2])
        performSegueWithIdentifier("exitCurse", sender: self)
    }
    
    func  hideImages() {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        var tempString:NSString = ""
        
        playerAButton.hidden=false
        tempString = NSString(format: "%02d", players[0]+1)
        playerALabel.text=tempString
        playerALabel.hidden=false

        playerBButton.hidden=true
        playerBLabel.hidden=true
        if (DarkTower.sharedInstance().numPlayers>2) {
            playerBButton.hidden=false
            tempString = NSString(format: "%02d", players[1]+1)
            playerBLabel.text=tempString
            playerBLabel.hidden=false
        }

        playerCButton.hidden=true
        playerCLabel.hidden=true
        if (DarkTower.sharedInstance().numPlayers>3) {
            playerCButton.hidden=false
            tempString = NSString(format: "%02d", players[2]+1)
            playerCLabel.text=tempString
            playerCLabel.hidden=false
        }
    }
}