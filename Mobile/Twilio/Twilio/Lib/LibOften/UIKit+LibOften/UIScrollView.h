//
//  UIScrollView.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

#define CONTENT_OFFSET_KEY_PATH @"contentOffset"

@interface UIScrollView (LibOften)

//! Returns content offset relative to content inset
- (CGPoint)relativeContentOffset;

@end


