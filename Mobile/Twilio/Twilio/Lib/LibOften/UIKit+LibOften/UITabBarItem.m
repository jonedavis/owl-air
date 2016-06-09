//
//  UITabBarItem.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UITabBarItem.h"

@implementation UITabBarItem (LibOften)

+ (instancetype)tabBarWithTitle:(NSString *)title image:(UIImage *)image {
    return [[self alloc] initWithTitle:title image:image tag:0];
}

@end


