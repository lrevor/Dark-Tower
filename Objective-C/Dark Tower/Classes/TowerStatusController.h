//
//  TowerStatusController.h
//  Dark Tower
//
//  Created by Louis Revor on 2/21/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;

@interface TowerStatusController : UIViewController {
	NSInteger gold;
	NSInteger warriors;
	NSTimer *timer;
    IBOutlet UIImageView *bazaarImage;
    IBOutlet UIImageView *bronzeKeyImage;
    IBOutlet UIImageView *silverKeyImage;
    IBOutlet UIImageView *goldKeyImage;
    IBOutlet UIImageView *cursedImage;
    IBOutlet UIImageView *dragonImage;
    IBOutlet UIImageView *goldImage;
    IBOutlet UIImageView *healerImage;
    IBOutlet UIImageView *keyMissingImage;
    IBOutlet UIImageView *lostImage;
    IBOutlet UIImageView *pegasusImage;
    IBOutlet UIImageView *plagueImage;
    IBOutlet UIImageView *scoutImage;
    IBOutlet UIImageView *swordImage;
    IBOutlet UIImageView *victoryImage;
    IBOutlet UIImageView *wizardImage;
    IBOutlet UIImageView *warriorImage;
    IBOutlet UILabel *myLabel;
}

-(void) bazaarClosed;
-(void) dragon:(BOOL) sword withGold:(NSInteger) myGold withWarriors:(NSInteger) myWarriors;
-(void) bazaarClosed;
-(void) dragonSword:(NSTimer *) theTimer;
-(void) showGold:(NSTimer *) theTimer;
-(void) showWarriors:(NSTimer *) theTimer;
-(void) plague:(BOOL) healer withWarriors:(NSInteger) myWarriors;
-(void) cursed: (NSInteger) myWarriors withGold: (NSInteger) myGold;
-(void) healer:(NSTimer *) theTimer;
-(void) lost:(BOOL) scout;
-(void) wizard;
-(void) pegasus;
-(void) bronzeKey;
-(void) silverKey;
-(void) goldKey;
-(void) keyMissing;
-(void) sword;
-(void) gold:(NSInteger) myGold;
-(void) scout:(NSTimer *) theTimer;
-(void) endTurn:(NSTimer *) theTimer;
-(void) hideImages;
@end
