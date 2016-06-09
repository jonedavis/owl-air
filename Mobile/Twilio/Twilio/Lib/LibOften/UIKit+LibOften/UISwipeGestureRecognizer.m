//
//  UISwipeGestureRecognizer.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UISwipeGestureRecognizer.h"
#import "UIGestureGecognizer.h"

@implementation UISwipeGestureRecognizer (LibOften)

+ (instancetype)swipeGestureRecognizerForDirection:(UISwipeGestureRecognizerDirection)direction withBlock:(void (^)())block {
    UISwipeGestureRecognizer *recognizer = [self gestureRecognizerWithBlock:block];
    recognizer.direction = direction;
    return recognizer;
}

@end


