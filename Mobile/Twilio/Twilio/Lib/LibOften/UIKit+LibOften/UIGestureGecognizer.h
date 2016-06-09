//
//  UIGestureGecognizer.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIGestureRecognizer (LibOften)

+ (instancetype)gestureRecognizerWithBlock:(void(^)())block;

@end


