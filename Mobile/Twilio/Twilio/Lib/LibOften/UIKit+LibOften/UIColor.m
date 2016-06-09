//
//  UIColor.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIColor.h"
#import "Misc.h"

@implementation UIColor (LibOften)

+ (UIColor *)colorFromHexRGB:(unsigned int)hex {
    return [self colorWithRed:((hex & 0xFF0000) >> 16) / 255.0 green:((hex & 0x00FF00) >> 8) / 255.0 blue:(hex & 0x0000FF) / 255.0 alpha:1.0];
}

+ (UIColor *)colorFromHexRGBA:(unsigned int)hex {
    return [self colorWithRed:((hex & 0xFF000000) >> 24) / 255.0 green:((hex & 0x00FF0000) >> 16) / 255.0 blue:((hex & 0x0000FF00) >> 8) / 255.0 alpha:(hex & 0x000000FF) / 255.0];
}

+ (instancetype)randomColorWithAlpha:(CGFloat)alpha {
    return [self colorWithRed:CGFloatRandom() green:CGFloatRandom() blue:CGFloatRandom() alpha:alpha];
}

@end


