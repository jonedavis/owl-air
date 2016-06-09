//
//  UIDevice.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIDevice.h"

@implementation UIDevice (LibOften)

BOOL iOS9() {
    return [[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0;
}

BOOL iPad() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad;
}

BOOL iPhone() {
    return [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone;
}

+ (UIDeviceOrientation)deviceOrientation {
    return [[UIDevice currentDevice] orientation];
}

+ (BOOL)deviceOrientationIsPortrait {
    return [self deviceOrientation] == UIDeviceOrientationPortrait;
}

+ (BOOL)deviceOrientationIsPortraitOrUpsideDown {
    return [self deviceOrientation] == UIDeviceOrientationPortrait || [self deviceOrientation] == UIDeviceOrientationPortraitUpsideDown;
}

+ (BOOL)deviceOrientationIsLandscape {
    return [self deviceOrientation] == UIDeviceOrientationLandscapeLeft || [self deviceOrientation] == UIDeviceOrientationLandscapeRight;
}

@end


