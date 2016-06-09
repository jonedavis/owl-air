//
//  UINavigationController.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UINavigationController.h"

@implementation UINavigationController (LibOften)

- (NSArray *)popNumberOfViewControllers:(NSInteger)numberOfControllers animated:(BOOL)animated {
    NSInteger targetControlIndex = self.viewControllers.count - 1 - numberOfControllers;
    targetControlIndex = MAX(0, targetControlIndex);
    targetControlIndex = MIN(self.viewControllers.count - 1, targetControlIndex);
    UIViewController *targetControl = self.viewControllers[targetControlIndex];
    return [self popToViewController:targetControl animated:animated];
}

@end


