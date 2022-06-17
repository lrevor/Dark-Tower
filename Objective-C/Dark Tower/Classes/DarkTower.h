//
//  DarkTower.h
//  DarkTower
//
//  Created by Louis Revor on 2/18/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Player.h"

//#define TOWERDEBUG

@class Dark_TowerViewController;
@class MainMenuViewController;
@class BazaarViewController;
@class SetupViewController;
@class BattleViewController;
@class TowerStatusController;
@class Player;

@interface DarkTower : NSObject <UIApplicationDelegate> {
	// App Delegate Information
    UIWindow *window;
    Dark_TowerViewController *darkTowerController;
    MainMenuViewController *mainMenuController;
    BazaarViewController *bazaarController;
    SetupViewController *setupController;
    BattleViewController *battleController;
    TowerStatusController *towerStatusController;

	// Game Information
	Player *myPlayer;
//	NSArray aPlayers;
	NSInteger numPlayers;
	NSInteger numTurns;
	NSInteger level;
	NSInteger activePlayer;
	NSInteger dragonGold;
	NSInteger dragonWarriors;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet Dark_TowerViewController *darkTowerController;
@property (nonatomic, retain) IBOutlet MainMenuViewController *mainMenuController;
@property (nonatomic, retain) IBOutlet BazaarViewController *bazaarController;
@property (nonatomic, retain) IBOutlet SetupViewController *setupController;
@property (nonatomic, retain) IBOutlet BattleViewController *battleController;
@property (nonatomic, retain) IBOutlet TowerStatusController *towerStatusController;

- (id) init;
+ (DarkTower *) sharedInstance;
- (void)reset;
- (void)laySiege;
- (void)startGame:(NSInteger) players withDifficulty:(NSInteger) difficulty;
- (void)endTurn;
- (void)bazaar;
- (void)endBazaar;
- (void)bazaarClosed;
- (void)endBazaar:(NSInteger) gold 
	 withWarriors:(NSInteger) warriors
	  withRations:(NSInteger) rations
		withBeast:(BOOL) beast
		withScout:(BOOL) scout
	   withHealer:(BOOL) healer;
	
- (void)clear;
- (void)frontier;
- (void)inventory;
- (void)move;
- (void)pegasus;
- (void)sanctuary;
- (void)tomb;
- (void)tower;
- (void)treasure;
- (void)battle;
- (void)endBattle:(NSInteger) remainingWarriors withRetreat: (BOOL) retreat;
- (BOOL)cursed;
- (NSInteger)activeRations;
- (NSInteger)activeGold;
- (NSInteger)activeWarriors;
@end
