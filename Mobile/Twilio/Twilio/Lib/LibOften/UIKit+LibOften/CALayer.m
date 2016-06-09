//
//  CALayer.m
//  Marquee
//
//  Created by Alexander Vasenin on 09/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "CALayer.h"

@implementation CALayer (LibOften)

- (void)bringToFront {
    CALayer *superlayer = self.superlayer;
    [self removeFromSuperlayer];
    [superlayer insertSublayer:self atIndex:(unsigned int)superlayer.sublayers.count];
}

- (void)sendToBack {
    CALayer *superlayer = self.superlayer;
    [self removeFromSuperlayer];
    [superlayer insertSublayer:self atIndex:0];
}

@end


