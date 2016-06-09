//
//  UIBarButtonItem.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIBarButtonItem (LibOften)

@property (nonatomic) void(^actionBlock)();

/// Creates new system item with action block
+ (instancetype)barButtonSystemItem:(UIBarButtonSystemItem)systemItem actionBlock:(void(^)())actionBlock;

@end


