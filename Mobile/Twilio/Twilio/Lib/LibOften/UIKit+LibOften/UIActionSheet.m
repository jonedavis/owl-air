//
//  UIActionSheet.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIActionSheet.h"
#import "UIApplication.h"
#import "UIViewController.h"
#import <objc/runtime.h>

@interface UIActionSheet () <UIActionSheetDelegate>
@end

@implementation UIActionSheet (LibOften)

static char completion_key;

- (void(^)(NSInteger buttonIndex))completion {
    return objc_getAssociatedObject(self, &completion_key);
}

- (void)setCompletion:(void(^)(NSInteger buttonIndex))completion {
    objc_setAssociatedObject(self, &completion_key, completion, OBJC_ASSOCIATION_RETAIN);
}

- (void)executeCompletionWithButtonIndex:(NSInteger)buttonIndex {
    void(^completion)(NSInteger buttonIndex) = [self completion];
    if (completion)
        completion(buttonIndex);
}

+ (instancetype)showWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles completion:(void (^)(NSInteger buttonIndex))completion {
    UIActionSheet *actionSheet = [[self alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonTitle destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:nil];
    actionSheet.delegate = actionSheet;
    for (NSString *buttonTitle in otherButtonTitles)
        [actionSheet addButtonWithTitle:buttonTitle];
    [actionSheet setCompletion:completion];
    [actionSheet showInView:[UIApplication visibleViewController].view];
    return actionSheet;
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    [self executeCompletionWithButtonIndex:buttonIndex];
}

@end


