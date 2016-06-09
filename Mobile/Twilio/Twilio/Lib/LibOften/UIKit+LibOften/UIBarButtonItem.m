//
//  UIBarButtonItem.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIBarButtonItem.h"
#import <objc/runtime.h>

@implementation UIBarButtonItem (LibOften)

static char actionBlockKey;

- (void(^)())actionBlock {
    return objc_getAssociatedObject(self, &actionBlockKey);
}

- (void)setActionBlock:(void(^)())actionBlock {
    objc_setAssociatedObject(self, &actionBlockKey, actionBlock, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)barButtonSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(void(^)())actionBlock {
    UIBarButtonItem *item = [[self alloc] initWithBarButtonSystemItem:systemItem target:nil action:@selector(executeActionBlock)];
    item.target = item;
    [item setActionBlock:actionBlock];
    return item;
}

- (void)executeActionBlock {
    void(^actionBlock)() = [self actionBlock];
    if (actionBlock)
        actionBlock();
}

@end


