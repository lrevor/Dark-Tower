//
//  BazaarViewController.h
//  Dark Tower
//
//  Created by Louis Revor on 2/20/10.
//  Copyright Louis Revor 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BazaarViewController : UIViewController {
	NSInteger iWarriorPrice;
	NSInteger iRationPrice;
	NSInteger iBeastPrice;
	NSInteger iScoutPrice;
	NSInteger iHealerPrice;
	NSInteger iPlayerGold;
    IBOutlet UILabel *warriorPrice;
    IBOutlet UILabel *warriorNum;
    IBOutlet UILabel *warriorTotal;
    IBOutlet UISlider *warriorSlider;
    IBOutlet UILabel *rationPrice;
    IBOutlet UILabel *rationNum;
    IBOutlet UILabel *rationTotal;
    IBOutlet UISlider *rationSlider;
    IBOutlet UILabel *beastPrice;
    IBOutlet UILabel *beastTotal;
	IBOutlet UISwitch *beastSwitch;
    IBOutlet UILabel *scoutPrice;
    IBOutlet UILabel *scoutTotal;
	IBOutlet UISwitch *scoutSwitch;
    IBOutlet UILabel *healerPrice;
    IBOutlet UILabel *healerTotal;
	IBOutlet UISwitch *healerSwitch;
    IBOutlet UILabel *bazaarPrice;
}

- (void)setPrices: (NSInteger) gold;
- (void)updatePrice;
- (IBAction)warriorHaggle:(UIButton *)sender;
- (IBAction)foodHaggle:(UIButton *)sender;
- (IBAction)beastHaggle:(UIButton *)sender;
- (IBAction)scoutHaggle:(UIButton *)sender;
- (IBAction)healerHaggle:(UIButton *)sender;
- (IBAction)buy:(UIButton *)sender;
- (IBAction)leave:(UIButton *)sender;
- (IBAction)warriorSlider:(UISlider *)sender;
- (IBAction)rationSlider:(UISlider *)sender;
- (IBAction)beastSwitch:(UISwitch *)sender;
- (IBAction)scoutSwitch:(UISwitch *)sender;
- (IBAction)healerSwitch:(UISwitch *)sender;
@end

