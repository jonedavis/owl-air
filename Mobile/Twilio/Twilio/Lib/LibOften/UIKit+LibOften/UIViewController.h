//
//  UIViewController.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIViewController (LibOften)

//! Returns YES if receiver is presented modally
@property (readonly) BOOL isPresentedModally;

//! Recursively finds content view controller
- (UIViewController *)findContentViewControllerRecursively;

//! Adds child view controller to view hierarchy
- (void)customAddChildViewController:(UIViewController *)child;

//! Adds child view controller to view hierarchy
- (void)customAddChildViewController:(UIViewController *)child toSubview:(UIView *)subview;

//! Removes view controller from view hierarchy
- (void)customRemoveFromParentViewController;

//! Removes all child view controllers from view hierarchy
- (void)customRemoveAllChildViewControllers;

@end


