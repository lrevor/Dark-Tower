//
//  Random.m
//  DarkTower
//
//  Created by Louis Revor on 2/19/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import "Random.h"
#import <stdlib.h>
#import <time.h>

static BOOL initialized = FALSE;

@implementation Random
+ (void) seed {
	time_t myTime;
	time(&myTime);
	srand(myTime);
	initialized=TRUE;
}

+ (NSInteger) getRand {
	return [Random getRand:10];
}

+ (NSInteger) getRand:(NSInteger) maxVal {
	float floatVal;
	NSInteger value;
	if (!initialized) [Random seed];
	floatVal = rand();
	floatVal=floatVal/RAND_MAX;
	value=(NSInteger) (floatVal*maxVal+1);
	return value;
}
@end
