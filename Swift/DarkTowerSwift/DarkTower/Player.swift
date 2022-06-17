//
//  Player.swift
//  DarkTower
//
//  Created by Louis Revor on 2/28/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation

class Player: NSObject {
    var playerID:NSInteger=0
    var gold:NSInteger=30
    var rations:NSInteger=25
    var warriors:NSInteger=10
    var beast:CBool=false
    var scout:CBool=false
    var healer:CBool=false
    var dragonSword:CBool=false
    var pegasus:CBool=false
    var bronzeKey:CBool=false
    var silverKey:CBool=false
    var goldKey:CBool=false
    var cursed:CBool=false
    var territory:NSInteger=1

    required override init() {
        super.init()
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
    }

    func dump () {
        NSLog("playerID %ld,gold %d, rations %d, warriors %d, beast %d, scout %d, healer %d, dragonSword %d, pegasus %d, bronzeKey %d, silverKey %d, goldKey %d, territory %d\n",
            playerID, gold, rations, warriors, beast, scout, healer, dragonSword, pegasus, bronzeKey, silverKey, goldKey, territory);
    }

    func startTurn() {
        if (rations <= (requiredRations() * 4)) {
            SoundManager.playSound("starving")
        }
        dump()
    }

    func endTurn() {
        // Reduce Warriors to limit
        if (warriors>99) {warriors = 99}
        // Reduce Rations to Limit
        if (rations>99) {rations=99}
    
        // Update Rations
        rations -= requiredRations()
        if (rations < 0) {
            rations = 0
            death()
        }
        
        if ((DarkTower.sharedInstance().numPlayers>1) && (warriors<1)) { warriors=1 }
        if ((DarkTower.sharedInstance().numPlayers==1) && (warriors<0)) { warriors=0 }
        
        reduceGold()
        dump()
    }
    
    func reduceGold() {
        var maxGold:NSInteger = 0
        // Update Gold
        maxGold = warriors*6
        if (beast) {maxGold += 50}
        if (gold>maxGold) {gold = maxGold}
        if (gold>99) {gold = 99}
    }
    
    func death() {
        if ( ((DarkTower.sharedInstance().numPlayers==1) && (warriors>0)) || ((DarkTower.sharedInstance().numPlayers>1) && (warriors>2)) ) {
            warriors -= 1
            SoundManager.playSound("player-hit")
            while (SoundManager.Static.audioPlayer.playing) { sleep(1) }
        }
    }
    
    func sanctuary() { // FIXME - should get more than this
        if (warriors < 4) {warriors=4}
        if (rations < 5) {rations=5}
        if (gold < 7) {gold = 7}
    }
    
    func requiredRations() -> NSInteger {
        var required:NSInteger=1

        // determine required Rations
        if (warriors>90) {required+=1}
        if (warriors>75) {required+=1}
        if (warriors>60) {required+=1}
        if (warriors>45) {required+=1}
        if (warriors>30) {required+=1}
        if (warriors>15) {required+=1}
        return required
    }
}