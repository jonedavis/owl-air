//
//  UIScreen.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

#ifndef TARGET_APP_EXTENSION

@interface UIScreen (LibOften)

//! Returns bounds of the main screen
+ (CGRect)mainScreenBounds;

//! Returns size of the main screen
+ (CGSize)mainScreenSize;

@end

#endif


