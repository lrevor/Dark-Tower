//
//  Random.swift
//  DarkTower
//
//  Created by Louis Revor on 3/1/15.
//  Copyright (c) 2015 Louis Revor. All rights reserved.
//

import Foundation

class Random {
    func getRand() -> NSInteger {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)
        return(getRand(10))
    }

    func getRand(maxVal:NSInteger) ->NSInteger {
        NSLog("[%@ %@]", reflect(self).summary, __FUNCTION__)

        var maxInt:UInt32 = UInt32(maxVal)
        var random = arc4random_uniform(maxInt)
        var value:NSInteger = NSInteger(random) + 1
        NSLog("[%@ %@] Range=%d, RandomValue=%d", reflect(self).summary, __FUNCTION__, maxVal, value)
        return(value)
    }
    
}
