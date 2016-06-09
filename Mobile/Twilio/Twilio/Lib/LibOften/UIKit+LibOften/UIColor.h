//
//  UIColor.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIColor (LibOften)

/// Returns UIColor from a hex number (RGB)
+ (instancetype)colorFromHexRGB:(unsigned int)hex;

// Returns UIColor from a hex number (RGB+Alpha)
+ (instancetype)colorFromHexRGBA:(unsigned int)hex;

+ (instancetype)randomColorWithAlpha:(CGFloat)alpha;

@end


