//
//  UIGestureGecognizer.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIGestureGecognizer.h"
#import "../Misc+LibOften/Macro.h"
#import "../Misc+LibOften/GCD.h"
#import <objc/runtime.h>

@implementation UIGestureRecognizer (LibOften)

+ (instancetype)gestureRecognizerWithBlock:(void(^)())block {
    UIGestureRecognizer *recognizer = [[self alloc] initWithTarget:self action:@selector(dummyAction)];
    [recognizer addTarget:recognizer action:@selector(executeBlock)];
    [recognizer setBlock:block];
    return recognizer;
}

+ (void)dummyAction {
    DoNothing;
}

static char block_key;

- (void(^)())block {
    return objc_getAssociatedObject(self, &block_key);
}

- (void)setBlock:(void(^)())block {
    objc_setAssociatedObject(self, &block_key, block, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)executeBlock {
    ExecuteNullableBlockSafely(self.block);
}

@end


