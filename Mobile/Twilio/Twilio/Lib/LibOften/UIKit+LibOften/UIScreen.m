//
//  UIScreen.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIScreen.h"

@implementation UIScreen (LibOften)

+ (CGRect)mainScreenBounds {
    return [self mainScreen].bounds;
}

+ (CGSize)mainScreenSize {
    return [self mainScreenBounds].size;
}

@end


