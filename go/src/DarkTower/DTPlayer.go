//
//  DTPlayer.go
//  DarkTower
//
//  Created by Louis Revor on 9/11/2020.
//  Copyright (c) 2020 Louis Revor. All rights reserved.
//

package main

import (
   "fmt"
   "math/rand"
)

var players=0

type DTPlayer struct {
    playerID int
    gold int
    rations int
    warriors int
    beast bool
    scout bool
    healer bool
    dragonSword bool
    pegasus bool
    bronzeKey bool
    silverKey bool
    goldKey bool
    cursed bool
    territory int
}

func (p *DTPlayer) init() {
    p.playerID = players
    players++
    p.gold = 30
    p.rations = 25
    p.warriors = 10
    p.beast = false
    p.scout = false
    p.healer = false
    p.dragonSword = false
    p.pegasus = false
    p.bronzeKey = false
    p.silverKey = false
    p.goldKey = false
    p.cursed = false
    p.territory = 1
}

func (p *DTPlayer) startTurn() {
    //fmt.Println("Start Turn", *p, "\n")
    if (p.rations <= (p.requiredRations() * 4)) {
        fmt.Println("Starving\n")
        //SoundManager.playSound("starving")
    }
}

func (p *DTPlayer) endTurn() {
    // Reduce Warriors to limit
    if (p.warriors>99) { p.warriors = 99 }
    // Reduce Rations to Limit
    if (p.rations>99) { p.rations=99 }

    // Update Rations
    p.rations -= p.requiredRations()
    if (p.rations < 0) {
        p.rations = 0
        p.death()
    }

    if ((players>1) && (p.warriors<1)) { p.warriors=1 }
    if ((players==1) && (p.warriors<0)) { p.warriors=0 }

    p.reduceGold()
    //fmt.Println("End Turn", *p, "\n")
}

func (p *DTPlayer) reduceGold() {
    maxGold:=p.warriors * 6
    if p.beast { maxGold+=50 }
    if maxGold > 99 { maxGold = 99 }
    if p.gold > maxGold { p.gold = maxGold }
}

func (p *DTPlayer) death() {
    if ((players==1) && (p.warriors>0)) || ((players>1) && (p.warriors>2)) {
        p.warriors -= 1
        fmt.Println("DEATH: Players reamining - ", p.warriors)
        //SoundManager.playSound("player-hit")
        //while (SoundManager.Static.audioPlayer.playing) { sleep(1) }
    }
}

func (p *DTPlayer) sanctuary() { // FIXME - should get more than this
    if (p.warriors < 4) { p.warriors=4 }
    if (p.rations < 5) { p.rations=5 }
    if (p.gold < 7) { p.gold = 7 }
}

func (p *DTPlayer) requiredRations() int {
    var required int
    // determine required Rations
    required=1+(p.warriors-1)/15
    return required
}
