//
//  UIDevice.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIDevice (LibOften)

//! Returns YES if iOS9 or higher detected at runtime
BOOL iOS9();

//! Returns YES if running on iPad
BOOL iPad();

//! Returns YES if running on iPhone
BOOL iPhone();

+ (UIDeviceOrientation)deviceOrientation;

+ (BOOL)deviceOrientationIsPortrait;

+ (BOOL)deviceOrientationIsPortraitOrUpsideDown;

+ (BOOL)deviceOrientationIsLandscape;

@end


