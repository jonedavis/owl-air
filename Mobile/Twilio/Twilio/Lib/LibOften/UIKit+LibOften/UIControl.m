//
//  UIControl.m
//  Marquee
//
//  Created by Alexander Vasenin on 10/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIControl.h"
#import "../Misc+LibOften/GCD.h"
#import <objc/runtime.h>

@implementation UIControl (LibOften)

static char touchUpInsideBlockKey;

- (void(^)())touchUpInsideBlock {
    return objc_getAssociatedObject(self, &touchUpInsideBlockKey);
}

- (void)setTouchUpInsideBlock:(void(^)())touchUpInsideBlock {
    objc_setAssociatedObject(self, &touchUpInsideBlockKey, touchUpInsideBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (![self actionsForTarget:self forControlEvent:UIControlEventTouchUpInside])
        [self addTarget:self action:@selector(executeTouchUpInsideBlock) forControlEvents:UIControlEventTouchUpInside];
}

- (void)executeTouchUpInsideBlock {
    ExecuteNullableBlockSafely(self.touchUpInsideBlock);
}

static char valueChangedBlockKey;

- (void(^)())valueChangedBlock {
    return objc_getAssociatedObject(self, &valueChangedBlockKey);
}

- (void)setValueChangedBlock:(void(^)())valueChangedBlock {
    objc_setAssociatedObject(self, &valueChangedBlockKey, valueChangedBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (![self actionsForTarget:self forControlEvent:UIControlEventValueChanged])
        [self addTarget:self action:@selector(executeValueChangedBlock) forControlEvents:UIControlEventValueChanged];
}

- (void)executeValueChangedBlock {
    ExecuteNullableBlockSafely(self.valueChangedBlock);
}

@end


