//
//  DarkTower.m
//  DarkTower
//
//  Created by Louis Revor on 2/18/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import "DarkTower.h"
#import "SoundManager.h"
#import "Random.h"
#import "Dark_TowerViewController.h"
#import "MainMenuViewController.h"
#import "BazaarViewController.h"
#import "SetupViewController.h"
#import "BattleViewController.h"
#import "TowerStatusController.h"

@implementation DarkTower

static DarkTower *sharedInstance = nil;

@synthesize window;
@synthesize darkTowerController;
@synthesize mainMenuController;
@synthesize bazaarController;
@synthesize setupController;
@synthesize battleController;
@synthesize towerStatusController;

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch  
    [window addSubview:towerStatusController.view];
    [window addSubview:battleController.view];
    [window addSubview:setupController.view];
    [window addSubview:bazaarController.view];
    [window addSubview:mainMenuController.view];
    [window addSubview:darkTowerController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [towerStatusController release];
    [battleController release];
    [setupController release];
    [bazaarController release];
    [mainMenuController release];
    [darkTowerController release];
    [window release];
    [super dealloc];
}

- (id) init {
	if (self = [super init]) {
		numTurns = 0;
		level = 1;
		activePlayer=0;
		dragonGold = 0;
		dragonWarriors = 0;
	}
	sharedInstance=self;
	return self;
}

+ (DarkTower *) sharedInstance {
	if (!sharedInstance) [[self alloc] init];
	return sharedInstance;
}

- (void)reset {
	[myPlayer init:1];
	[SoundManager playSound:@"battle"];
}

- (void)laySiege{
	[SoundManager playSound:@"end-turn"];
    [window bringSubviewToFront:setupController.view];
}

- (void) startGame:(NSInteger) players withDifficulty:(NSInteger) difficulty {
//	NSInteger i;
	numPlayers = players;
	numTurns = 0;
	level = difficulty;
//	for (i=0; i<numPlayers; i++){
//		[aPlayers addObject: [[Player alloc] init:i]];
//	}
//	myPlayer = [aPlayers objectAtIndex: activePlayer];
	myPlayer = [[Player alloc] init:1];
	[SoundManager playSound:@"intro" withSleep: 5];
    [window bringSubviewToFront:mainMenuController.view];
}

- (void)endTurn {
    [window bringSubviewToFront:mainMenuController.view];
	[myPlayer endTurn];
}

- (void)bazaar {
	[myPlayer startTurn];
	if (![self cursed]) {
		[SoundManager playSound:@"bazaar"];
		[bazaarController setPrices: myPlayer.gold];
		[window bringSubviewToFront:bazaarController.view];
	}
}

- (void)endBazaar {
    [window bringSubviewToFront:mainMenuController.view];
	[myPlayer endTurn];
}

- (void)bazaarClosed {
	[towerStatusController bazaarClosed];
    [window bringSubviewToFront:towerStatusController.view];
	[myPlayer endTurn];
}

- (void)endBazaar:(NSInteger) gold 
	 withWarriors:(NSInteger) warriors
	  withRations:(NSInteger) rations
		withBeast:(BOOL) beast
		withScout:(BOOL) scout
	   withHealer:(BOOL) healer {
    [myPlayer setRations: [myPlayer rations]+rations];
    [myPlayer setWarriors: ([myPlayer warriors]+warriors)];
	if (beast) [myPlayer setBeast: TRUE];
	if (healer) [myPlayer setHealer: TRUE];
	if (scout) [myPlayer setScout: TRUE];
	[myPlayer setGold: ([myPlayer gold]-gold)];
	[myPlayer reduceGold];
	[self endTurn];
}

- (void)clear {
	[SoundManager playSound:@"clear"];
}

- (void)frontier {
	[myPlayer startTurn];
	if (![self cursed]) {
		[SoundManager playSound:@"frontier" withSleep: 1];
		switch (myPlayer.territory) {
			case 1:
				[myPlayer setTerritory: 2];
				[myPlayer endTurn];
				break;
			case 2:
				if (myPlayer.bronzeKey) {
					[myPlayer setTerritory: 3];
				} else {
					[window bringSubviewToFront:towerStatusController.view];
					[towerStatusController keyMissing];
				}
				break;
			case 3:
				if (myPlayer.silverKey) {
					[myPlayer setTerritory: 4];
				} else {
					[window bringSubviewToFront:towerStatusController.view];
					[towerStatusController keyMissing];
				}
				break;
			case 4:
				[window bringSubviewToFront:towerStatusController.view];
				[towerStatusController keyMissing];
				break;
		}
	}
}

- (void)inventory {
}

- (void)move {
	NSInteger move;
	[myPlayer startTurn];
	if (![self cursed]) {
		move = [Random getRand];
		//move = 8;
		switch (move) {
			case 1:
			case 2:
			case 3:
			case 4:
			case 5:
				[SoundManager playSound:@"beep"]; // nothing
				break;
			case 6: // Dragon
				if (myPlayer.dragonSword) {
					[myPlayer setGold: (myPlayer.gold+dragonGold)];
					[myPlayer reduceGold];
					[myPlayer setWarriors: (myPlayer.warriors+dragonWarriors)];
					dragonGold=0;
					dragonWarriors=0;
				} else {
					[myPlayer setGold: (myPlayer.gold * 0.75)];
					[myPlayer reduceGold];
					[myPlayer setWarriors: (myPlayer.warriors * 0.75)];
					dragonGold=(myPlayer.gold * 0.75);
					dragonWarriors=(myPlayer.warriors * 0.75);
				}
				[window bringSubviewToFront:towerStatusController.view];
				[towerStatusController dragon: myPlayer.dragonSword withGold: myPlayer.gold withWarriors: myPlayer.warriors];
				[myPlayer setDragonSword:FALSE];
				break;
			case 7: // lost
				[window bringSubviewToFront:towerStatusController.view];
				[towerStatusController lost: myPlayer.scout];
				break;
			case 8: // plague
				[window bringSubviewToFront:towerStatusController.view];
				if (myPlayer.healer) {
					[myPlayer setWarriors: (myPlayer.warriors + 2)];
				} else {
					[myPlayer setWarriors: (myPlayer.warriors - 2)];
				}
				[towerStatusController plague: myPlayer.healer withWarriors: myPlayer.warriors];
				break;
			case 9:
			case 10: // battle
				[SoundManager playSound:@"battle"];
				[self battle];
				break;
		}
		[myPlayer endTurn];
	}
}

- (void)pegasus{
	if (![self cursed]) {
		[SoundManager playSound:@"pegasus" withSleep: 3];
	}
}

- (void)sanctuary {
	[myPlayer startTurn];
	if (![self cursed]) {
		[SoundManager playSound:@"sanctuary"];
		[myPlayer sanctuary];
		[myPlayer endTurn];
	}
}

- (void)tomb {
	NSInteger value;
	[myPlayer startTurn];
	if (![self cursed]) {
#ifdef TOWERDEBUG
		value = 3;
#else
		value = [Random getRand];
#endif
		switch (value) {
			case 1:
			case 2:
				[SoundManager playSound:@"tomb-nothing" withSleep:4];
				[myPlayer endTurn];
				break;
			case 3:
				[SoundManager playSound:@"tomb" withSleep:4];
				[self treasure];
				break;
			default:
				[SoundManager playSound:@"tomb-battle" withSleep:4];
				[self battle];
				break;
		}
	}
}
- (void)tower {
	[myPlayer startTurn];
	if (![self cursed]) {
		if ((myPlayer.bronzeKey) && (myPlayer.silverKey) && (myPlayer.goldKey)) {
			[SoundManager playSound:@"darktower"];
			[myPlayer endTurn];
		} else {
			[window bringSubviewToFront:towerStatusController.view];
			[towerStatusController keyMissing];
		}
	}
}

- (void)treasure {
	BOOL gotTreasure = FALSE;
	while (!gotTreasure) {
		switch ([Random getRand]) {
			case 1:
				//Nothing
				gotTreasure=TRUE;
				NSLog(@"Treasure: NOTHING");
				[self endTurn];
				break;
			case 2:
			case 3:
			case 4:
				//Gold
				gotTreasure=TRUE;
				NSLog(@"Treasure: Gold");
				[myPlayer setGold:(myPlayer.gold + [Random getRand] + 10)];
				[myPlayer reduceGold];
				[window bringSubviewToFront:towerStatusController.view];
				[towerStatusController gold: myPlayer.gold];
				break;
			case 5:
			case 6:
				//Sword
				if (!myPlayer.dragonSword) {
					[myPlayer setDragonSword:TRUE];
					gotTreasure=TRUE;
					NSLog(@"Treasure: Sword");
					[window bringSubviewToFront:towerStatusController.view];
					[towerStatusController sword];
				}
				break;
			case 7:
				//Wizard
				if (numPlayers>1) {
					// Need to be able to select the player to curse and steal 1/4 of their
					// gold and warriors.
					// The cursed player action works
					//[myPlayer setCursed:TRUE];
					//gotTreasure=TRUE;
					//NSLog(@"Treasure: Wizard");
					//[window bringSubviewToFront:towerStatusController.view];
					//[towerStatusController wizard];
				}
				break;
			case 8:
				//Pegasus
				if (!myPlayer.pegasus) {
					[myPlayer setPegasus:TRUE];
					gotTreasure=TRUE;
					NSLog(@"Treasure: Pegasus");
					[window bringSubviewToFront:towerStatusController.view];
					[towerStatusController pegasus];
				}
				break;
			case 9:
			case 10:
				//Key
				switch (myPlayer.territory) {
					case 1:
						break;
					case 2:
						//Bronze Key
						if (!myPlayer.bronzeKey) {
							[myPlayer setBronzeKey:TRUE];
							gotTreasure=TRUE;
							NSLog(@"Treasure: Bronze Bey");
							[window bringSubviewToFront:towerStatusController.view];
							[towerStatusController bronzeKey];
						}
						break;
					case 3:
						//Silver Key
						if (!myPlayer.silverKey) {
							[myPlayer setSilverKey:TRUE];
							gotTreasure=TRUE;
							NSLog(@"Treasure: Silver Key");
							[window bringSubviewToFront:towerStatusController.view];
							[towerStatusController silverKey];
						}
						break;
					case 4:
						//Gold Key
						if (!myPlayer.goldKey) {
							[myPlayer setGoldKey:TRUE];
							gotTreasure=TRUE;
							NSLog(@"Treasure: Gold Key");
							[window bringSubviewToFront:towerStatusController.view];
							[towerStatusController goldKey];
						}
						break;
				}
				break;
		}
	}
}

- (void) battle {
    [window bringSubviewToFront:battleController.view];
	[battleController startBattle: myPlayer.warriors withLevel: level];
}

- (void) endBattle:(NSInteger) remainingWarriors withRetreat: (BOOL) retreat{
	[myPlayer setWarriors: remainingWarriors];
	if ((remainingWarriors>0) && (!retreat)) {
		[self treasure];
	} else {
		[self endTurn];
	}
}

- (BOOL)cursed {
	if (myPlayer.cursed) {
		[myPlayer setCursed:FALSE];
		[window bringSubviewToFront:towerStatusController.view];
		[towerStatusController cursed:myPlayer.warriors withGold:myPlayer.gold];
		return TRUE;
	} else {
		return FALSE;
	}
}

- (NSInteger)activeRations {
	return [myPlayer rations];
}

- (NSInteger)activeGold {
	return [myPlayer gold];
}

- (NSInteger)activeWarriors {
	return [myPlayer warriors];
}

@end
