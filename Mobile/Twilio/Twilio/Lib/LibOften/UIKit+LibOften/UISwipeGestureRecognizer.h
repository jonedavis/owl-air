//
//  UISwipeGestureRecognizer.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UISwipeGestureRecognizer (LibOften)

+ (instancetype)swipeGestureRecognizerForDirection:(UISwipeGestureRecognizerDirection)direction withBlock:(void(^)())block;

@end


