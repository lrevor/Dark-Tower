//
//  Player.h
//  DarkTower
//
//  Created by Louis Revor on 2/16/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Player : NSObject {
@private

	NSInteger playerID;
	NSInteger gold;
	NSInteger rations;
	NSInteger warriors;
	BOOL beast;
	BOOL scout;
	BOOL healer;
	BOOL dragonSword;
	BOOL pegasus;
	BOOL bronzeKey;
	BOOL silverKey;
	BOOL goldKey;
	BOOL cursed;
	NSInteger territory;
}

@property NSInteger playerID;
@property NSInteger gold;
@property NSInteger rations;
@property NSInteger warriors;
@property BOOL beast;
@property BOOL scout;
@property BOOL healer;
@property BOOL dragonSword;
@property BOOL pegasus;
@property BOOL bronzeKey;
@property BOOL silverKey;
@property BOOL goldKey;
@property BOOL cursed;
@property NSInteger territory;
 
- (id) init:(NSInteger) playerNum;
- (void) dump;
- (void) startTurn;
- (void) endTurn;
- (void) reduceGold;
- (void) death;
- (void) sanctuary;
- (NSInteger) requiredRations;
@end
