//
//  SetupViewController.h
//  Dark Tower
//
//  Created by Louis Revor on 2/20/10.
//  Copyright Louis Revor 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SetupViewController : UIViewController {
    IBOutlet UISegmentedControl *numPlayers;
    IBOutlet UISegmentedControl *difficulty;
}

- (IBAction)startGame:(UIButton *)sender;
@end

