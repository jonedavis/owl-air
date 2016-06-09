//
//  UILabel.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UILabel (LibOften)

//! Improves text visibility
- (void)improveVisibilityOnClutterdBackground;

@property (readonly) BOOL isTextTruncated;

@end


