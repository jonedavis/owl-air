//
//  CGGeometry.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

#define SCREEN_POINTS_EPSILON 0.1

//! Returns affine transformations which transforms rect1 to rect2
CGAffineTransform CGAffineTransformMakeFromRectToRect(CGRect rect1, CGRect rect2);

//! Returns CGSize scaled with scale factor on both axis
CGSize CGSizeScale(CGSize size, CGFloat scale);

//! Returns CGRect with origin.x/origin.y and size.width/size.height values swapped
CGRect CGRectGetTransposed(CGRect rect);

CGFloat CGFloatPixelFloor(CGFloat value);

CGFloat CGFloatPixelCeil(CGFloat value);


