//
//  UIScrollView.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIScrollView.h"

@implementation UIScrollView (LibOften)

- (CGPoint)relativeContentOffset {
    return CGPointMake(self.contentOffset.x + self.contentInset.left, self.contentOffset.y + self.contentInset.top);
}

@end


