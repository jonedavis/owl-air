//
//  Misc.m
//  Marquee
//
//  Created by Alexander Vasenin on 15/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "Misc.h"

CGFloat CGFloatRandom() {
    return (CGFloat)arc4random() / (CGFloat)UINT32_MAX;
}

BOOL observedCGPointValueChanged(NSDictionary *changeDictionary) {
    CGPoint oldPoint = [(NSValue *)changeDictionary[NSKeyValueChangeOldKey] CGPointValue];
    CGPoint newPoint = [(NSValue *)changeDictionary[NSKeyValueChangeNewKey] CGPointValue];
    return !CGPointEqualToPoint(oldPoint, newPoint);
}


