//
//  BattleViewController.h
//  Dark Tower
//
//  Created by Louis Revor on 2/21/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Player;

@interface BattleViewController : UIViewController {
	NSTimer *timer;
	NSInteger brigands;
	NSInteger warriors;
	NSInteger level;
	BOOL warriorWin;
	BOOL retreatFlag;
    IBOutlet UIImageView *goldImage;
    IBOutlet UIImageView *warriorImage;
    IBOutlet UIImageView *brigandImage;
	IBOutlet UIButton *retreatButton;
    IBOutlet UILabel *myLabel;
}

- (IBAction)retreat:(UIButton *)sender;
- (void) startBattle:(NSInteger) startWarriors withLevel:(NSInteger) startLevel;
- (void) continueBattle;
-(void) showWarriors:(NSTimer *) theTimer;
-(void) showBrigands:(NSTimer *) theTimer;
-(void) playResult:(NSTimer *) theTimer;
-(void) showResult:(NSTimer *) theTimer;
-(void) endBattle:(NSTimer *) theTimer;
- (void) setBrigands;
- (void) setWarriorWin;
-(void) hideImages;
@end
