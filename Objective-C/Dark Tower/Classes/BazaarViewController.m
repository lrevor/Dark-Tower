//
//  BazaarViewController.m
//  Dark Tower
//
//  Created by Louis Revor on 2/20/10.
//  Copyright Louis Revor 2010. All rights reserved.
//

#import "BazaarViewController.h"
#import "DarkTower.h"
#import "SoundManager.h"
#import "Random.h"

@implementation BazaarViewController



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

- (void)setPrices: (NSInteger) gold{
	iWarriorPrice = 6;
	iRationPrice = 5;
	iBeastPrice = 20;
	iScoutPrice = 30;
	iHealerPrice = 40;
	iPlayerGold = gold;
	beastSwitch.on=FALSE;
	healerSwitch.on=FALSE;
	scoutSwitch.on=FALSE;
	warriorSlider.value=0;
	rationSlider.value=0;
	[self updatePrice];
}

- (void)updatePrice{
	NSInteger totalPrice=0;
	NSInteger value;
	
	[warriorPrice setText: [[[NSNumber alloc] initWithInt: iWarriorPrice] stringValue]];
	[rationPrice setText: [[[NSNumber alloc] initWithInt: iRationPrice] stringValue]];
	[beastPrice setText: [[[NSNumber alloc] initWithInt: iBeastPrice] stringValue]];
	[scoutPrice setText: [[[NSNumber alloc] initWithInt: iScoutPrice] stringValue]];
	[healerPrice setText: [[[NSNumber alloc] initWithInt: iHealerPrice] stringValue]];

	value=warriorSlider.value;
	[warriorNum setText: [[[NSNumber alloc] initWithInt: value] stringValue]];
	[warriorTotal setText: [[[NSNumber alloc] initWithInt: (value*iWarriorPrice)] stringValue]];
	totalPrice+=(value*iWarriorPrice);

	value=rationSlider.value;
	[rationNum setText: [[[NSNumber alloc] initWithInt: value] stringValue]];
	[rationTotal setText: [[[NSNumber alloc] initWithInt: (value*iRationPrice)] stringValue]];
	totalPrice+=(value*iRationPrice);

	if ([beastSwitch isOn]) {
		[beastTotal setText: [[[NSNumber alloc] initWithInt: iBeastPrice] stringValue]];
		totalPrice+=iBeastPrice;
	} else {
		[beastTotal setText: [[[NSNumber alloc] initWithInt: 0] stringValue]];
	}
	
	if ([scoutSwitch isOn]) {
		[scoutTotal setText: [[[NSNumber alloc] initWithInt: iScoutPrice] stringValue]];
		totalPrice+=iScoutPrice;
	} else {
		[scoutTotal setText: [[[NSNumber alloc] initWithInt: 0] stringValue]];
	}

	if ([healerSwitch isOn]) {
		[healerTotal setText: [[[NSNumber alloc] initWithInt: iHealerPrice] stringValue]];
		totalPrice+=iHealerPrice;
	} else {
		[healerTotal setText: [[[NSNumber alloc] initWithInt: 0] stringValue]];
	}

	[bazaarPrice setText: [[[NSNumber alloc] initWithInt: totalPrice] stringValue]];
}

- (IBAction)warriorHaggle:(UIButton *)sender{
	NSInteger minPrice=4;
	if (([Random getRand]<6)&&(iWarriorPrice>minPrice)){
		iWarriorPrice-=1;
		[self updatePrice];
	} else {
		[[DarkTower sharedInstance] bazaarClosed];
	}
}

- (IBAction)foodHaggle:(UIButton *)sender{
	NSInteger minPrice=4;
	if (([Random getRand]<6)&&(iRationPrice>minPrice)){
		iRationPrice-=1;
		[self updatePrice];
	} else {
		[[DarkTower sharedInstance] bazaarClosed];
	}
}

- (IBAction)beastHaggle:(UIButton *)sender{
	NSInteger minPrice=15;
	if (([Random getRand]<6)&&(iBeastPrice>minPrice)){
		iBeastPrice-=1;
		[self updatePrice];
	} else {
		[[DarkTower sharedInstance] bazaarClosed];
	}
}

- (IBAction)scoutHaggle:(UIButton *)sender{
	NSInteger minPrice=25;
	if (([Random getRand]<6)&&(iScoutPrice>minPrice)){
		iScoutPrice-=1;
		[self updatePrice];
	} else {
		[[DarkTower sharedInstance] bazaarClosed];
	}
}

- (IBAction)healerHaggle:(UIButton *)sender{
	NSInteger minPrice=35;
	if (([Random getRand]<6)&&(iHealerPrice>minPrice)){
		iHealerPrice-=1;
		[self updatePrice];
	} else {
		[[DarkTower sharedInstance] bazaarClosed];
	}
}

- (IBAction)buy:(UIButton *)sender{
	NSInteger totalPrice=0;
	NSInteger value;
	
	value=warriorSlider.value;
	totalPrice+=(value*iWarriorPrice);
	
	value=rationSlider.value;
	totalPrice+=(value*iRationPrice);

	if ([beastSwitch isOn]) totalPrice+=iBeastPrice;
	
	if ([scoutSwitch isOn]) totalPrice+=iScoutPrice;
	
	if ([healerSwitch isOn]) totalPrice+=iHealerPrice;

	if (totalPrice>iPlayerGold) {
		[[DarkTower sharedInstance] bazaarClosed];
	} else {
		[SoundManager playSound:@"beep"];
		[[DarkTower sharedInstance] endBazaar: totalPrice 
								 withWarriors: warriorSlider.value
								  withRations: rationSlider.value
									withBeast: [beastSwitch isOn]
									withScout: [scoutSwitch isOn]
								   withHealer: [healerSwitch isOn]];
	}
}

- (IBAction)leave:(UIButton *)sender{
	[SoundManager playSound:@"beep"];
	[[DarkTower sharedInstance] endBazaar];
}

- (IBAction)warriorSlider:(UISlider *)sender{
//	NSNumber *myNumber = [[NSNumber alloc] initWithInt: warriorSlider.value];
//	[myLabel setText: [myNumber stringValue]];
	[self updatePrice];
}

- (IBAction)rationSlider:(UISlider *)sender{
	[self updatePrice];
}

- (IBAction)beastSwitch:(UISwitch *)sender{
	[self updatePrice];
}

- (IBAction)scoutSwitch:(UISwitch *)sender{
	[self updatePrice];
}

- (IBAction)healerSwitch:(UISwitch *)sender{
	[self updatePrice];
}

@end
