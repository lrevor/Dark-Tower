//
//  Random.h
//  DarkTower
//
//  Created by Louis Revor on 2/19/10.
//  Copyright 2010 Louis Revor. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Random : NSObject {
}
+ (void) seed;
+ (NSInteger) getRand;
+ (NSInteger) getRand:(NSInteger) maxVal;
@end
