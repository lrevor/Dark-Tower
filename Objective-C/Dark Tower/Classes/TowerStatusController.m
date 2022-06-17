//
//  TowerStatusController.m
//  Dark Tower
//
//  Created by Louis Revor on 2/21/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import "TowerStatusController.h"
#import "DarkTower.h"
#import "Random.h"
#import "SoundManager.h"

@implementation TowerStatusController



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

-(void) bazaarClosed{
	[self hideImages];
	[SoundManager playSound:@"bazaar-closed"];
	bazaarImage.hidden=FALSE;
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) dragon:(BOOL) sword withGold:(NSInteger) myGold withWarriors:(NSInteger) myWarriors {
	gold = myGold;
	warriors = myWarriors;
	[self hideImages];
	[SoundManager playSound:@"dragon"];
	dragonImage.hidden=FALSE;
	if (sword) {
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
												 target:(id)self 
											   selector:@selector(dragonSword:) 
											   userInfo:nil
												repeats:NO];
	} else {
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
												 target:(id)self 
											   selector:@selector(showGold:) 
											   userInfo:nil
												repeats:NO];
	}
}

-(void) dragonSword:(NSTimer *) theTimer {
	[self hideImages];
	swordImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(showGold:) 
										   userInfo:nil
											repeats:NO];
}

-(void) showGold:(NSTimer *) theTimer {
	[self hideImages];
	goldImage.hidden=FALSE;
	myLabel.hidden=FALSE;
	[myLabel setText : [[[NSNumber alloc] initWithInt: gold] stringValue]];
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
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
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}
 
-(void) plague:(BOOL) healer withWarriors:(NSInteger) myWarriors {
	warriors = myWarriors;
	[self hideImages];
	[SoundManager playSound:@"plague"];
	plagueImage.hidden=FALSE;
	if (healer) {
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
												 target:(id)self 
											   selector:@selector(healer:) 
											   userInfo:nil
												repeats:NO];
	} else {
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
												 target:(id)self 
											   selector:@selector(showWarriors:) 
											   userInfo:nil
												repeats:NO];
	}
}

-(void) cursed: (NSInteger) myWarriors withGold: (NSInteger) myGold {
	gold = myGold;
	warriors = myWarriors;
	[self hideImages];
	[SoundManager playSound:@"plague"];
	cursedImage.hidden=FALSE;
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(showGold:) 
										   userInfo:nil
											repeats:NO];
}

-(void) healer:(NSTimer *) theTimer {
	[self hideImages];
	healerImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(showWarriors:) 
										   userInfo:nil
											repeats:NO];
}

-(void) lost:(BOOL) scout {
	[self hideImages];
	[SoundManager playSound:@"lost"];
	lostImage.hidden=FALSE;
	if (scout) {
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
												 target:(id)self 
											   selector:@selector(scout:) 
											   userInfo:nil
												repeats:NO];
	} else {
		timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
												 target:(id)self 
											   selector:@selector(endTurn:) 
											   userInfo:nil
												repeats:NO];
	}
}

-(void) wizard {
	[self hideImages];
	wizardImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) pegasus {
	[self hideImages];
	pegasusImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) bronzeKey {
	[self hideImages];
	bronzeKeyImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) silverKey {
	[self hideImages];
	silverKeyImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) goldKey {
	[self hideImages];
	goldKeyImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) keyMissing {
	[self hideImages];
	keyMissingImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) sword {
	[self hideImages];
	swordImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) gold:(NSInteger) myGold{
	gold = myGold;
	[self hideImages];
	goldImage.hidden=FALSE;
	myLabel.hidden=FALSE;
	[myLabel setText : [[[NSNumber alloc] initWithInt: gold] stringValue]];
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) scout:(NSTimer *) theTimer {
	[self hideImages];
	scoutImage.hidden=FALSE;
	[SoundManager playSound:@"beep"];
	timer = [NSTimer scheduledTimerWithTimeInterval:(NSTimeInterval)3.0 
											 target:(id)self 
										   selector:@selector(endTurn:) 
										   userInfo:nil
											repeats:NO];
}

-(void) endTurn:(NSTimer *) theTimer {
	[self hideImages];
	[[DarkTower sharedInstance] endTurn];
}

-(void) hideImages {
	myLabel.hidden=TRUE;
    bazaarImage.hidden=TRUE;
    bronzeKeyImage.hidden=TRUE;
    silverKeyImage.hidden=TRUE;
    goldKeyImage.hidden=TRUE;
    cursedImage.hidden=TRUE;
    dragonImage.hidden=TRUE;
    goldImage.hidden=TRUE;
    healerImage.hidden=TRUE;
    keyMissingImage.hidden=TRUE;
    lostImage.hidden=TRUE;
    pegasusImage.hidden=TRUE;
    plagueImage.hidden=TRUE;
    scoutImage.hidden=TRUE;
    swordImage.hidden=TRUE;
    victoryImage.hidden=TRUE;
    wizardImage.hidden=TRUE;
    warriorImage.hidden=TRUE;
}

@end
