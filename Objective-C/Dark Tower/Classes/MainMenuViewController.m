//
//  MainMenuViewController.m
//  Dark Tower
//
//  Created by Louis Revor on 2/20/10.
//  Copyright Louis Revor 2010. All rights reserved.
//

#import "MainMenuViewController.h"
#import "DarkTower.h"

@implementation MainMenuViewController



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

- (IBAction)bazaar:(UIButton *)sender{
	[[DarkTower sharedInstance] bazaar];
}

- (IBAction)tomb:(UIButton *)sender{
	[[DarkTower sharedInstance] tomb];
}

- (IBAction)ruin:(UIButton *)sender{
	[[DarkTower sharedInstance] tomb];
}

- (IBAction)sanctuary:(UIButton *)sender{
	[[DarkTower sharedInstance] sanctuary];
}

- (IBAction)citadel:(UIButton *)sender{
	[[DarkTower sharedInstance] sanctuary];
}

- (IBAction)pegasus:(UIButton *)sender{
	[[DarkTower sharedInstance] pegasus];
}

- (IBAction)emptyTerritory:(UIButton *)sender{
	[[DarkTower sharedInstance] move];
}

- (IBAction)frontier:(UIButton *)sender{
	[[DarkTower sharedInstance] frontier];
}

- (IBAction)inventory:(UIButton *)sender{
//	[[DarkTower sharedInstance] bazaar];
}

- (IBAction)darkTower:(UIButton *)sender{
	[[DarkTower sharedInstance] tower];
}

@end
