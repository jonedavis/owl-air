//
//  UIApplication.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

#ifndef TARGET_APP_EXTENSION

@interface UIApplication (LibOften)

//! use +[UIApplication appWindow] instead
+ (UIWindow *)keyWindow;

//! appWindow != keyWindow if UIAlertView is visible
+ (UIWindow *)appWindow;

+ (UIViewController *)rootViewController;

+ (UIViewController *)visibleViewController;

+ (UINavigationController *)visibleNavigationController;

+ (UITabBarController *)visibleTabBarController;

//! Pushes or presents given view controller based on presence of navigation controller
+ (void)pushOrPresentViewController:(UIViewController *)viewController animated:(BOOL)animated;

+ (UIImage *)launchImage;

+ (CGRect)appWindowFrame;

+ (CGRect)navigationBarFrame;

+ (CGFloat)navigationBarHeight;

+ (CGRect)statusBarFrame;

+ (CGFloat)statusBarHeight;

+ (CGRect)tabBarFrame;

+ (CGFloat)tabBarHeight;

+ (UIInterfaceOrientation)interfaceOrientation;

+ (BOOL)interfaceOrientationIsLandscape;

+ (BOOL)interfaceOrientationIsPortrait;

+ (BOOL)interfaceOrientationIsPortraitOrUpsideDown;

@end

#endif


