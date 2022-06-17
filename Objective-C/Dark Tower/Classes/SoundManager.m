//
//  SoundManager.m
//  DarkTower
//
//  Created by Louis Revor on 2/18/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import "SoundManager.h"


@implementation SoundManager
+(void)playSound:(NSString *) soundName {
	[self playSound: soundName withSleep: 0];
}

+(void)playSound:(NSString *) soundName withSleep:(NSInteger) sleepVal {
#define OLD
#ifdef OLD
	SystemSoundID mysound;
	
	NSString *sndpath = [[NSBundle mainBundle] pathForResource:soundName ofType:@"wav"];
	CFURLRef baseURL = (CFURLRef)[NSURL fileURLWithPath: sndpath];
	AudioServicesCreateSystemSoundID(baseURL, &mysound);
	AudioServicesPropertyID flag = 0;  // 0 means always play
	AudioServicesSetProperty(kAudioServicesPropertyIsUISound, sizeof(SystemSoundID), &mysound, sizeof(AudioServicesPropertyID), &flag);
//	if ([MPMusicPlayerController iPodMusicPlayer].playbackState ==  MPMusicPlaybackStatePlaying)
		AudioServicesPlayAlertSound(mysound);
//	else
//		AudioServicesPlaySystemSound(mysound);
	sleep(sleepVal);
#else
    
#endif
    NSLog(@"SoundManager playSound %@", soundName);
}

@end
