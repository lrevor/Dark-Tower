//
//  InventoryViewController.swift
//  DarkTower
//
//  Created by Louis Revor on 3/7/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation

//
//  TowerStatusController.swift
//  NewDarkTower
//
//  Created by Louis Revor on 2/27/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation
import UIKit

class InventoryViewController: UIViewController {
    @IBOutlet weak var bronzeKeyImage: UIImageView!
    @IBOutlet weak var silverKeyImage: UIImageView!
    @IBOutlet weak var goldKeyImage: UIImageView!
    @IBOutlet weak var goldImage: UIImageView!
    @IBOutlet weak var rationsImage: UIImageView!
    @IBOutlet weak var beastImage: UIImageView!
    @IBOutlet weak var healerImage: UIImageView!
    @IBOutlet weak var pegasusImage: UIImageView!
    @IBOutlet weak var scoutImage: UIImageView!
    @IBOutlet weak var swordImage: UIImageView!
    @IBOutlet weak var warriorImage: UIImageView!
    @IBOutlet weak var myLabel: UILabel!
    
    var timer: NSTimer?=nil
    var statusTime = 1.5
    var nextState = state.none
    var currentState = state.none
    var nextStatePause = 1.0
    var endStateSound=""
    var waitSound = false
    var didShow = true
    var towerZone = 0
    
    enum state {
        case none, gold, warriors, rations, beast, scout, healer, sword, pegasus, bronzeKey, silverKey, goldKey, endTurn, clear
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        hideImages()
        nextState = state.gold
        runState()
    }
    
    func runState() {
        if (SoundManager.Static.audioPlayer.playing) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("runState"), userInfo: nil, repeats: false)
            waitSound=true
        } else if (waitSound) {
            timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: Selector("runState"), userInfo: nil, repeats: false)
            waitSound=false
        } else {
            NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
            hideImages()
            currentState = nextState
            nextState = state.endTurn // Default to end turn since it is the most common and makes sense
            endStateSound = "beep" // Default to beep since it is the most common
            nextStatePause = statusTime
            didShow = false
            
            switch  currentState {
            case .gold:
                nextState=state.warriors
                if (towerZone == 1) {
                    goldImage.hidden=false
                    var tempString:NSString = NSString(format: "%02d", DarkTower.sharedInstance().player().gold)
                    myLabel.text=tempString
                    myLabel.hidden=false
                } else {
                    nextState = currentState
                    endStateSound = "rotate"
                    towerZone=1
                }
                didShow=true
            case .warriors:
                nextState=state.rations
                if (towerZone == 1) {
                    warriorImage.hidden=false
                    var tempString:NSString = NSString(format: "%02d", DarkTower.sharedInstance().player().warriors)
                    myLabel.text=tempString
                    myLabel.hidden=false
                } else {
                    nextState = currentState
                    endStateSound = "rotate"
                    towerZone=1
                }
                didShow=true
            case .rations:
                nextState=state.beast
                if (towerZone == 1) {
                    rationsImage.hidden=false
                    var tempString:NSString = NSString(format: "%02d", DarkTower.sharedInstance().player().rations)
                    myLabel.text=tempString
                    myLabel.hidden=false
                } else {
                    nextState = currentState
                    endStateSound = "rotate"
                    towerZone=1
                }
                didShow=true
            case .beast:
                nextState=state.scout
                if (DarkTower.sharedInstance().player().beast) {
                    if (towerZone == 2) {
                        beastImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=2
                    }
                    didShow=true
                }
            case .scout:
                nextState=state.healer
                if (DarkTower.sharedInstance().player().scout) {
                    if (towerZone == 2) {
                        scoutImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=2
                    }
                    didShow=true
                }
            case .healer:
                nextState=state.pegasus
                if (DarkTower.sharedInstance().player().healer) {
                    if (towerZone == 2) {
                        healerImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=2
                    }
                    didShow=true
                }
            case .pegasus:
                nextState=state.sword
                if (DarkTower.sharedInstance().player().pegasus) {
                    if (towerZone == 3) {
                        pegasusImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=3
                    }
                    didShow=true
                }
            case .sword:
                nextState=state.bronzeKey
                if (DarkTower.sharedInstance().player().dragonSword) {
                    if (towerZone == 3) {
                        swordImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=3
                    }
                    didShow=true
                }
            case .bronzeKey:
                nextState=state.silverKey
                if (DarkTower.sharedInstance().player().bronzeKey) {
                    if (towerZone == 4) {
                        bronzeKeyImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=4
                    }
                    didShow=true
                }
            case .silverKey:
                nextState=state.goldKey
                if (DarkTower.sharedInstance().player().silverKey) {
                    if (towerZone == 4) {
                        silverKeyImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=4
                    }
                    didShow=true
                }
            case .goldKey:
                nextState=state.clear
                if (DarkTower.sharedInstance().player().goldKey) {
                    if (towerZone == 4) {
                        goldKeyImage.hidden=false
                    } else {
                        nextState = currentState
                        endStateSound = "rotate"
                        towerZone=4
                    }
                    didShow=true
                }
            case .clear:
                nextState=state.endTurn
                endStateSound=""
                didShow=true
            case .endTurn:
                performSegueWithIdentifier("exitInventory", sender: self)
                endStateSound=""
                nextState=state.none
            default:
                NSLog("[%@ %@] Error...shouldn't get here", reflect(self).summary, __FUNCTION__)
            }
            if (didShow && (endStateSound != "")) {
                SoundManager.playSound(endStateSound)
            }
            if (nextState != state.none) {
                if (didShow) {
                    timer = NSTimer.scheduledTimerWithTimeInterval(statusTime, target:self, selector: Selector("runState"), userInfo: nil, repeats: false)
                } else {
                    runState()
                }
            }
        }
    }
    
    
    func  hideImages() {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        myLabel.hidden=true
        bronzeKeyImage.hidden=true
        silverKeyImage.hidden=true
        goldKeyImage.hidden=true
        goldImage.hidden=true
        rationsImage.hidden=true
        beastImage.hidden=true
        healerImage.hidden=true
        pegasusImage.hidden=true
        scoutImage.hidden=true
        swordImage.hidden=true
        warriorImage.hidden=true
    }
}