//
//  UIActivityIndicatorView.m
//  Marquee
//
//  Created by Alexander Vasenin on 15/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIActivityIndicatorView.h"

@implementation UIActivityIndicatorView (LibOften)

- (void)setAnimating:(BOOL)animating {
    if (animating) {
        [self startAnimating];
    } else {
        [self stopAnimating];
    }
}

@end


