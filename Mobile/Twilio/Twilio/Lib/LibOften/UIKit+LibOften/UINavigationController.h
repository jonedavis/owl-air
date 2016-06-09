//
//  UINavigationController.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UINavigationController (LibOften)

//! Pops given number of view controllers from top of navigation stack
- (NSArray *)popNumberOfViewControllers:(NSInteger)numberOfControllers animated:(BOOL)animated;

@end


