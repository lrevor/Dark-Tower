//
//  SoundManager.h
//  DarkTower
//
//  Created by Louis Revor on 2/18/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <MediaPlayer/MediaPlayer.h>


@interface SoundManager : NSObject {

}
+(void)playSound:(NSString *) soundName;
+(void)playSound:(NSString *) soundName withSleep:(NSInteger) sleepVal;

@end
