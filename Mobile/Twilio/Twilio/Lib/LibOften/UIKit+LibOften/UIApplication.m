//
//  UIApplication.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIApplication.h"
#import "UIScreen.h"
#import "UIViewController.h"

@implementation UIApplication (LibOften)

+ (UIWindow *)keyWindow {
    return [UIApplication sharedApplication].keyWindow;
}

+ (UIWindow *)appWindow {
    return [UIApplication sharedApplication].delegate.window;
}

+ (UIViewController *)rootViewController {
    return [self appWindow].rootViewController;
}

+ (UIViewController *)visibleViewController {
    return [[self rootViewController] findContentViewControllerRecursively];
}

+ (UINavigationController *)visibleNavigationController {
    return [[self visibleViewController] navigationController];
}

+ (UITabBarController *)visibleTabBarController {
    return [[self visibleViewController] tabBarController];
}

+ (void)pushOrPresentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self visibleNavigationController]) {
        [[self visibleNavigationController] pushViewController:viewController animated:animated];
    } else {
        [[self visibleViewController] presentViewController:viewController animated:animated completion:NULL];
    }
}

+ (UIImage *)launchImage {
    CGSize screenSize = [UIScreen mainScreenSize];
    CGSize transposedScreenSize = CGSizeMake(screenSize.height, screenSize.width);
    NSArray *imagePropertiesArray = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *imageProperties in imagePropertiesArray) {
        CGSize imageSize = CGSizeFromString(imageProperties[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(screenSize, imageSize) || CGSizeEqualToSize(transposedScreenSize, imageSize))
            return [UIImage imageNamed:imageProperties[@"UILaunchImageName"]];
    } return nil;
}

+ (CGRect)appWindowFrame {
    return [[self appWindow] frame];
}

+ (CGRect)navigationBarFrame {
    return [[[self visibleNavigationController] navigationBar] frame];
}

+ (CGFloat)navigationBarHeight {
    return [self navigationBarFrame].size.height;
}

+ (CGRect)statusBarFrame {
    return [[self sharedApplication] statusBarFrame];
}

+ (CGFloat)statusBarHeight {
    return [self statusBarFrame].size.height;
}

+ (CGRect)tabBarFrame {
    return [[[self visibleTabBarController] tabBar] frame];
}

+ (CGFloat)tabBarHeight {
    return [self tabBarFrame].size.height;
}

+ (UIInterfaceOrientation)interfaceOrientation {
    return [[self sharedApplication] statusBarOrientation];
}

+ (BOOL)interfaceOrientationIsLandscape {
    return [self interfaceOrientation] == UIInterfaceOrientationLandscapeLeft || [self interfaceOrientation] == UIInterfaceOrientationLandscapeRight;
}

+ (BOOL)interfaceOrientationIsPortrait {
    return [self interfaceOrientation] == UIInterfaceOrientationPortrait;
}

+ (BOOL)interfaceOrientationIsPortraitOrUpsideDown {
    return [self interfaceOrientation] == UIInterfaceOrientationPortrait || [self interfaceOrientation] == UIInterfaceOrientationPortraitUpsideDown;
}

@end


