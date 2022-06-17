//
//  DarkTower.swift
//  DarkTower
//
//  Created by Louis Revor on 2/28/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation
import UIKit

class DarkTower: NSObject, UIApplicationDelegate {    

    enum towerSegueState {
        case none, bazaar, status, battle, inventory, riddle
    }
    enum towerTurnState {
        case none, bazaar, tomb, sanctuary, move, frontier, inventory, darkTower, clear, pegasus
    }
    
    // Game Information
    //var myPlayer:Player! = nil
    var players:[Player!] = [nil, nil, nil, nil]
    var riddle:[NSInteger] = [0,0,0]
    var currentPlayer = 0
    
    //	NSArray aPlayers;
    var numPlayers:NSInteger=1
    var numTurns:NSInteger=0
    var level:NSInteger=1
    var activePlayer:NSInteger=0
    var dragonGold:NSInteger=10
    var dragonWarriors:NSInteger=5
    var random = Random()
    var goldAwarded=0
    var warriorsAwarded=0
    var rationsAwarded=0

    var currentTurnState = towerTurnState.none
    var segueState  = towerSegueState.none
    var statusState = TowerStatusController.state.none
    var battleState = BattleViewController.state.none

    func applicationDidFinishLaunching(application:UIApplication?) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
    }
    
    class func sharedInstance() -> DarkTower! {
        // NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
       struct Static {
            static var instance: DarkTower? = nil
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken) {
            Static.instance = self()
        }
        
        return Static.instance!
    }
    
    required override init() {
        super.init()
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
    }

    func setRiddle() {
        riddle[0]=0
        riddle[1]=0
        riddle[2]=0

        //set the bronze Key
        riddle[random.getRand(3)-1] = 1
        
        let silverKey = random.getRand(2)
        var empties=0
        for iter in 0..<3 {
            if (riddle[iter] == 0) {
                empties++
                if (empties == silverKey) { riddle[iter]=2 }
            }
        }

        for iter in 0..<3 {
            if (riddle[iter] == 0) { riddle[iter]=3 }
        }
        NSLog("[%@ %@] Riddle Sequence is: %d %d %d", reflect(self).summary, __FUNCTION__, riddle[0], riddle[1], riddle[2])
    }
    
    func reset() {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        numPlayers=1
        numTurns=0
        level=1
        activePlayer=0
        dragonGold=0
        dragonWarriors=0
        var iter:NSInteger=0
        for iter in 0..<4 {
            players[iter]=Player()
            players[iter].playerID=iter
        }
        setRiddle()
        SoundManager.playSound("battle")
    }
    
    func player() ->Player! {
       return(players[currentPlayer])
    }
    
    func startGame (players:NSInteger, difficulty:NSInteger) {
        numPlayers = players;
        numTurns = 0;
        level = difficulty;
        SoundManager.playSound("intro")
    }

    func startTurn(turnState:towerTurnState) {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        if (!dead()) {
            if (!cursed()) {
                currentTurnState = turnState
                if (currentTurnState != towerTurnState.pegasus) { player().startTurn() }
                runTurn()
            }
        }
    }
    
    func runTurn() {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        switch currentTurnState {
            case .bazaar:
                segueState  = towerSegueState.bazaar
            case .inventory:
                segueState  = towerSegueState.inventory
            case .tomb:
                segueState  = towerSegueState.battle
                battleState = BattleViewController.state.tomb
            case .sanctuary:
                if (player().warriors<5) {
                    player().warriors += random.getRand(5) + 7
                    warriorsAwarded = player().warriors
                }
                if (player().gold<8) {
                    player().gold += random.getRand(10) + 15
                    goldAwarded = player().gold
                }
                if (player().rations<6) {
                    player().rations += random.getRand(10) + 15
                    rationsAwarded = player().rations
                }
                segueState  = towerSegueState.status
                statusState = TowerStatusController.state.sanctuary
            case .move:
                var move:NSInteger=0
                move = random.getRand(10)
                switch (move) {
                    case 6: // Dragon
                        if (player().dragonSword) {
                            player().dragonSword=false
                            goldAwarded = dragonGold
                            warriorsAwarded = dragonWarriors
                            player().gold += goldAwarded
                            player().warriors += warriorsAwarded
                    
                            // reset back to original
                            dragonGold=10
                            dragonWarriors=5
                    
                            segueState  = towerSegueState.status
                            statusState = TowerStatusController.state.dragonKill
                        } else {
                            goldAwarded = player().gold / 4
                            warriorsAwarded = player().warriors / 4
                            player().gold -= goldAwarded
                            player().warriors -= warriorsAwarded
                            dragonGold += goldAwarded
                            dragonWarriors += warriorsAwarded
                        
                            segueState  = towerSegueState.status
                            statusState = TowerStatusController.state.dragon
                        }
                    case 7: // lost
                        segueState  = towerSegueState.status
                        statusState = TowerStatusController.state.lost
                    case 8: // plague
                        if (player().healer) {
                            player().warriors = player().warriors + 2
                            } else {
                                player().warriors = player().warriors - 2
                            }
                        segueState  = towerSegueState.status
                    statusState = TowerStatusController.state.plague
                    case 9,10: // battle
                        segueState  = towerSegueState.battle
                        battleState = BattleViewController.state.battle
                    default:
                        segueState  = towerSegueState.status
                        statusState = TowerStatusController.state.clear
                }
            case .frontier:
                if ((player().territory==1)&&(player().bronzeKey)) {
                    segueState  = towerSegueState.status
                    statusState = TowerStatusController.state.clear
                } else if ( ((player().territory==1)&&(!player().bronzeKey)) ||
                            ((player().territory==2)&&(player().bronzeKey)) ||
                            ((player().territory==3)&&(player().silverKey)) ||
                            ((player().territory==4)&&(player().goldKey)) ) {
                    player().territory+=1
                    if (player().territory==5) {player().territory=1}
                    segueState  = towerSegueState.status
                    statusState = TowerStatusController.state.frontier
                } else {
                    segueState  = towerSegueState.status
                    statusState = TowerStatusController.state.missingKey
                }
            case .darkTower:
                if ((player().territory != 1)||(!player().goldKey)) {
                    segueState  = towerSegueState.status
                    statusState = TowerStatusController.state.missingKey
                } else {
                    segueState = towerSegueState.riddle
                }
            case .clear:
                segueState  = towerSegueState.status
                statusState = TowerStatusController.state.clear
            case .pegasus:
                player().pegasus=false
                segueState  = towerSegueState.status
                statusState = TowerStatusController.state.pegasus
            default:
                NSLog("[%@ %@] Default - Should not get here", reflect(self).summary, __FUNCTION__)
        }
    }
    
    func endTurn() {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)

        if (currentTurnState != towerTurnState.pegasus) {
            player().endTurn()
            currentPlayer = (currentPlayer+1)%numPlayers
            SoundManager.playSound("end-turn")
        } else {
            SoundManager.playSound("beep")
        }
        
        // clear state
        currentTurnState = towerTurnState.none
        segueState  = towerSegueState.none
        statusState = TowerStatusController.state.none
        battleState = BattleViewController.state.none
        
        // clear awards
        goldAwarded=0
        warriorsAwarded=0
        rationsAwarded=0
    }
    
    func dead ()->CBool {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        if (player().warriors == 0) {
            segueState  = towerSegueState.status
            statusState = TowerStatusController.state.death
            return(true)
        } else {
            return(false)
        }
    }
    
    func cursed ()->CBool {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        if (player().cursed) {
            segueState  = towerSegueState.status
            statusState = TowerStatusController.state.cursed
            goldAwarded=player().gold
            warriorsAwarded=player().warriors
            player().cursed=false
            return(true)
        } else {
            return(false)
        }
    }
    
    func curse (playerID:NSInteger) {
        NSLog("[%@ %@] Curse: Player %02d is cursing Player %02d", reflect(self).summary, __FUNCTION__, player().playerID, playerID)
        goldAwarded = players[playerID].gold / 4
        warriorsAwarded = players[playerID].warriors / 4
        players[playerID].gold -= goldAwarded
        players[playerID].warriors -= warriorsAwarded
        players[playerID].cursed = true
        player().gold += goldAwarded
        player().warriors += warriorsAwarded
        goldAwarded = player().gold
        warriorsAwarded = player().warriors
        statusState = TowerStatusController.state.gold
        player().dump()
        players[playerID].dump()
    }

    func closeBazaar () {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        statusState = TowerStatusController.state.bazaarClosed
    }
    
    func winBattle () {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        var gotTreasure:CBool = false
        while (!gotTreasure) {
            switch (random.getRand()) {
            case 1:
                //Nothing
                gotTreasure=true
                NSLog("[%@ %@] Treasure: NOTHING", reflect(self).summary, __FUNCTION__)
                statusState = TowerStatusController.state.clear
            case 2,3,4:
                //Gold
                gotTreasure=true
                NSLog("[%@ %@] Treasure: Gold", reflect(self).summary, __FUNCTION__)
                player().gold = player().gold + random.getRand() + 10
                player().reduceGold()
                goldAwarded=player().gold
                statusState = TowerStatusController.state.gold
            case 5,6:
                //Sword
                if (!player().dragonSword) {
                    player().dragonSword=true
                    gotTreasure=true
                    NSLog("[%@ %@] Treasure: Sword", reflect(self).summary, __FUNCTION__)
                    statusState = TowerStatusController.state.sword
                }
                break;
            case 7:
                //Wizard
                if (numPlayers>1) {
                    gotTreasure=true
                    NSLog("[%@ %@] Treasure: Wizard!", reflect(self).summary, __FUNCTION__)
                    statusState = TowerStatusController.state.wizard
                }
            case 8:
                //Pegasus
                if (!player().pegasus) {
                    player().pegasus=true
                    gotTreasure=true
                    NSLog("[%@ %@] Treasure: Pegasus", reflect(self).summary, __FUNCTION__)
                    statusState = TowerStatusController.state.pegasus
                }
            case 9,10:
                //Key
                switch (DarkTower.sharedInstance().player().territory) {
                case 1:
                    NSLog("[%@ %@] Treasure: Key - not available in this territory", reflect(self).summary, __FUNCTION__)
                case 2:
                    //Bronze Key
                    if (!player().bronzeKey) {
                        player().bronzeKey=true
                        gotTreasure=true
                        NSLog("[%@ %@] Treasure: Bronze Key", reflect(self).summary, __FUNCTION__)
                        statusState = TowerStatusController.state.bronzeKey
                    }
                case 3:
                    //Silver Key
                    if (!player().silverKey) {
                        player().silverKey=true
                        gotTreasure=true
                        NSLog("[%@ %@] Treasure: Silver Key", reflect(self).summary, __FUNCTION__)
                        statusState = TowerStatusController.state.silverKey
                    }
                case 4:
                    //Gold Key
                    if (!player().goldKey) {
                        player().goldKey=true
                        gotTreasure=true
                        NSLog("[%@ %@] Treasure: Gold Key", reflect(self).summary, __FUNCTION__)
                        statusState = TowerStatusController.state.goldKey
                    }
                default:
                    NSLog("[%@ %@] Should not get here", reflect(self).summary, __FUNCTION__)
                }
            default:
                NSLog("[%@ %@] Should not get here", reflect(self).summary, __FUNCTION__)
                
            }
        }
    }
    
    func setBrigands (warriors:NSInteger)->NSInteger {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        var brigands:NSInteger=0
        
        switch (level) {
        case 1:
            brigands = warriors - 3 + random.getRand(100)*7/100;
        case 2:
            brigands = warriors + random.getRand(100)*6/100;
        case 3:
            brigands = warriors + 5 + random.getRand(100)*11/100;
        case 4:
            brigands = 16;
        default:
            NSLog("[%@ %@] Shouldn't get here", reflect(self).summary, __FUNCTION__)
        }
        NSLog("[%@ %@] Battle!  Warriors: %d, Brigands %d", reflect(self).summary, __FUNCTION__, warriors, brigands)
        return(brigands)
    }
    
    func setWarriorWin (warriors:NSInteger, brigands:NSInteger)->CBool {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        var probability:NSInteger=0
        
        if (warriors>brigands) {
            probability = 75 - (brigands*100)/(4*warriors);
        } else {
            probability = 25 + (warriors*100)/(4*brigands);
        }
        
        NSLog("[%@ %@] Probability of Win: %d", reflect(self).summary, __FUNCTION__, probability)
        if (random.getRand(100) < probability) {
            return(true)
        } else {
            return(false)
        }
    }
    
    func wrongRiddle () {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        statusState = TowerStatusController.state.missingKey
    }
    
    func correctRiddle () {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        battleState = BattleViewController.state.darkTower
    }
    
    func winDarkTower () {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        statusState = TowerStatusController.state.victory
    }
}