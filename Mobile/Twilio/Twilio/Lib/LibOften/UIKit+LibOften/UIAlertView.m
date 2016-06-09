//
//  UIAlertView.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIAlertView.h"
#import <objc/runtime.h>

@implementation UIAlertView (LibOften)

static char completion_key; // Associated completion block key

+ (instancetype)showWithTitle:(NSString *)tl message:(NSString *)ms buttons:(NSArray *)bts completion:(void(^)(NSUInteger btn))cb {
    UIAlertView *alertView = [[self alloc] initWithTitle:tl message:ms delegate:nil cancelButtonTitle:[bts objectAtIndex:0] otherButtonTitles:nil]; // Init alert view
    for (NSUInteger i = 1; i < bts.count; i++)
        [alertView addButtonWithTitle:bts[i]]; // Add all other buttons
    objc_setAssociatedObject(alertView, &completion_key, cb, OBJC_ASSOCIATION_RETAIN_NONATOMIC); // Associate completion block with alert view
    alertView.delegate = alertView; // Set alert view as itself delegate
    [alertView show]; // Show alert view
    return alertView;
}

// Execute associated completion block when button is clicked
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)btn {
    void(^completionBlock)(NSUInteger btn) = objc_getAssociatedObject(self, &completion_key); // Get associated completion block
    if (completionBlock)
        completionBlock(btn); // Execute completion block (if we have one)
}

@end


