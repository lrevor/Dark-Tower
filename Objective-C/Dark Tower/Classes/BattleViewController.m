//
//  BattleViewController.m
//  Dark Tower
//
//  Created by Louis Revor on 2/21/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import "BattleViewController.h"
#import "DarkTower.h"
#import "Player.h"
#import "Random.h"
#import "SoundManager.h"

@implementation BattleViewController

#define BATTLETIME 2.0
//#define BATTLETIME 0.5

/*
 // The designated initializer. Override to perform setup that is required before the view is loaded.
 - (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 // Custom initialization
 }
 return self;
 }
 */

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}


/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

- (IBAction)retreat:(UIButton *)sender{
	retreatFlag=TRUE;
	retreatButton.hidden=TRUE;
}

-(void) startBattle:(NSInteger) startWarriors withLevel:(NSInteger) startLevel{
	warriors=startWarriors;
	level=startLevel;
	retreatFlag=FALSE;
	[self setBrigands];
	NSLog(@"Battle!  Warriors: %ld, Brigands %ld", (long)warriors, (long)brigands);
	[self hideImages];
	retreatButton.hidden=TRUE;
	brigandImage.hidden=FALSE;
	myLabel.hidden=FALSE;
	[myLabel setText : [[[NSNumber alloc] initWithInt: brigands] stringValue]];
	[self continueBattle];
}

-(void) continueBattle{
	NSLog(@"ContinueBattle");
	[self setWarriorWin];
	if (warriorWin) {
		brigands = brigands/2;
	} else {
		warriors-=1;
	}
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(BATTLETIME+1) 
											 target:(id)self 
										   selector:@selector(showWarriors:) 
										   userInfo:nil
											repeats:NO];
}

-(void) showWarriors:(NSTimer *) theTimer {
	[self hideImages];
	warriorImage.hidden=FALSE;
	myLabel.hidden=FALSE;
	[myLabel setText : [[[NSNumber alloc] initWithInt: warriors] stringValue]];
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)BATTLETIME 
											 target:(id)self 
										   selector:@selector(showBrigands:) 
										   userInfo:nil
											repeats:NO];
}

-(void) showBrigands:(NSTimer *) theTimer {
	[self hideImages];
	brigandImage.hidden=FALSE;
	myLabel.hidden=FALSE;
	[myLabel setText : [[[NSNumber alloc] initWithInt: brigands] stringValue]];
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)BATTLETIME 
											 target:(id)self 
										   selector:@selector(playResult:) 
										   userInfo:nil
											repeats:NO];
}

-(void) playResult:(NSTimer *) theTimer {
	[self hideImages];
	if (warriorWin) {
		[SoundManager playSound:@"enemy-hit"];
	} else {
		[SoundManager playSound:@"player-hit"];
	}
	if ((retreatFlag)||(warriors==0)||(brigands==0)) {
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)BATTLETIME 
												 target:(id)self 
											   selector:@selector(showResult:) 
											   userInfo:nil
												repeats:NO];
	} else {
		[self continueBattle];
	}
}

-(void) showResult:(NSTimer *) theTimer {
	[self hideImages];
	retreatButton.hidden=TRUE;
	if (retreatFlag || (warriors==0)) {
		warriorImage.hidden=FALSE;
		[SoundManager playSound:@"plague"];
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)(BATTLETIME+1) 
												 target:(id)self 
											   selector:@selector(endBattle:) 
											   userInfo:nil
												repeats:NO];
	} else {
		[[DarkTower sharedInstance] endBattle: warriors withRetreat: retreatFlag];
	}
}

-(void) endBattle:(NSTimer *) theTimer {
	[[DarkTower sharedInstance] endBattle: warriors withRetreat: retreatFlag];
}

-(void) setBrigands{
#ifdef TOWERDEBUG
	brigands = 1;
#else
	switch (level) {
		case 1:
			brigands = warriors - 3 + [Random getRand:100]*7/100;
			break;
		case 2:
			brigands = warriors + [Random getRand:100]*6/100;
			break;
		case 3:
			brigands = warriors + 5 + [Random getRand:100]*11/100;
			break;
		case 4:
			brigands = 16;
			break;
	}
#endif
}

- (void) setWarriorWin {
	NSInteger probability;
#ifdef TOWERDEBUG
	probability=100;
#else
	if (warriors>brigands) {
		probability = 75 - (brigands*100)/(4*warriors);
	} else {
		probability = 25 + (warriors*100)/(4*brigands);
	}
#endif
	
	if ([Random getRand:100] < probability) {
		warriorWin = TRUE;
	} else {
		warriorWin = FALSE;
	}
}

-(void) hideImages {
	myLabel.hidden=TRUE;
	if (retreatFlag) {
		retreatButton.hidden=TRUE;
	} else {
		retreatButton.hidden=FALSE;
	}
	goldImage.hidden=TRUE;
	warriorImage.hidden=TRUE;
	brigandImage.hidden=TRUE;
}

@end
