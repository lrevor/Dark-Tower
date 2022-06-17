//
//  Player.m
//  DarkTower
//
//  Created by Louis Revor on 2/16/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import "Player.h"
#import "SoundManager.h"


@implementation Player
- (id) init:(NSInteger) playerNum {
	if (self = [super init]) {
		playerID = playerNum;
		gold = 30;
		rations = 25;
		warriors = 10;
		beast = FALSE;
		scout = FALSE;
		healer = FALSE;
		dragonSword = FALSE;
		pegasus = FALSE;
		bronzeKey = FALSE;
		silverKey = FALSE;
		goldKey = FALSE;
		cursed = FALSE;
		territory = 1;
	}
	// [self dump];
	return self;
}

- (void) dump{
	NSLog(@"playerID %ld,gold %ld, rations %ld, warriors %ld, beast %d, scout %d, healer %d, dragonSword %d, pegasus %d, bronzeKey %d, silverKey %d, goldKey %d, territory %ld\n",
		  (long)playerID, (long)gold, (long)rations, (long)warriors, beast, scout, healer, dragonSword, pegasus, bronzeKey, silverKey, goldKey, (long)territory); 
}

- (void) startTurn{
	if ((rations <= ([self requiredRations] * 4))&&(rations>0)) {
		[SoundManager playSound:@"starving" withSleep: 3];
	}
}

- (void) endTurn{
	// Reduce Warriors to limit
	if (warriors>99) warriors = 99;
	// Reduce Rations to Limit
	if (rations>99) rations=99;

	// Update Rations
	rations -= [self requiredRations];
	if (rations < 0) {
		rations = 0;
		[self death];
	}
	
	[self reduceGold];
	[self dump];
}

- (void) reduceGold {
	NSInteger maxGold = 0;
	
	// Reduce Gold to Limit
	if (gold>99) gold=99;

	// Update Gold
	maxGold = warriors*6;
	if (beast) maxGold += 50;
	if (gold>maxGold) gold = maxGold;
	if (gold>99) gold = 99;
}

- (void) death {
	[SoundManager playSound:@"player-hit" withSleep: 2];
	if (warriors>0) warriors -= 1;
}

- (void) sanctuary {
	if (warriors < 4) warriors=4;
	if (rations < 5) rations=5;
	if (gold < 7) gold = 7;
}

- (NSInteger) requiredRations {
	NSInteger required;
	required = 1;
	// determine required Rations
	if (warriors>75) required+=1;
	if (warriors>60) required+=1;
	if (warriors>45) required+=1;
	if (warriors>30) required+=1;
	if (warriors>15) required+=1;
	return required;
}
@synthesize playerID;
@synthesize gold;
@synthesize rations;
@synthesize warriors;
@synthesize beast;
@synthesize scout;
@synthesize healer;
@synthesize dragonSword;
@synthesize pegasus;
@synthesize bronzeKey;
@synthesize silverKey;
@synthesize goldKey;
@synthesize cursed;
@synthesize territory;

@end
