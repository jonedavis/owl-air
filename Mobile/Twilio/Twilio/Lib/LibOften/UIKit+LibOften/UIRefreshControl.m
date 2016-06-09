//
//  UIRefreshControl.m
//  Marquee
//
//  Created by Alexander Vasenin on 07/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIRefreshControl.h"

@implementation UIRefreshControl (LibOften)

- (void)endRefreshingIfNeeded {
    if (self.isRefreshing)
        [self endRefreshing];
}

@end


