//
//  UIViewController.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIViewController.h"

@implementation UIViewController (LibOften)

- (BOOL)isPresentedModally {
    return self.presentingViewController.presentedViewController == self;
}

- (UIViewController *)findContentViewControllerRecursively {
    UIViewController *childViewController;
    if ([self isKindOfClass:[UITabBarController class]]) {
        childViewController =  [(UITabBarController *)self selectedViewController];
    } else if ([self isKindOfClass:[UINavigationController class]]) {
        childViewController = [(UINavigationController *)self topViewController];
    } else if ([self isKindOfClass:[UISplitViewController class]]) {
        childViewController = [(UISplitViewController *)self viewControllers].lastObject;
    } else if (self.presentedViewController) {
        childViewController = self.presentedViewController;
    }
    // FIXME: UIAlertController is a kludge and should be removed
    BOOL shouldContinueSearch = childViewController && ![NSStringFromClass([childViewController class]) isEqualToString:@"UIAlertController"];
    return shouldContinueSearch ? [childViewController findContentViewControllerRecursively] : self;
}

- (void)customAddChildViewController:(UIViewController *)child {
    [self customAddChildViewController:child toSubview:self.view];
}

- (void)customAddChildViewController:(UIViewController *)child toSubview:(UIView *)subview {
    child.view.frame = subview.bounds;
    [self addChildViewController:child];
    [subview addSubview:child.view];
    [child didMoveToParentViewController:self];
}

- (void)customRemoveFromParentViewController {
    [self willMoveToParentViewController:nil];
    [self.view removeFromSuperview];
    [self removeFromParentViewController];
}

- (void)customRemoveAllChildViewControllers {
    for (UIViewController *control in self.childViewControllers)
        [control customRemoveFromParentViewController];
}

@end


