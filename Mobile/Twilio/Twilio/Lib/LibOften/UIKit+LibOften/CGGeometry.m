
//
//  CGGeometry.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "CGGeometry.h"
#import <tgmath.h> // Actuall does nothing due to Xcode bug (see http://stackoverflow.com/q/23333287/2432781 for more info)

CGAffineTransform CGAffineTransformMakeFromRectToRect(CGRect rect1, CGRect rect2) {
    CGFloat sx = rect2.size.width / rect1.size.width;
    CGFloat sy = rect2.size.height / rect1.size.height;
    CGFloat tx = rect2.origin.x - rect1.origin.x * sx;
    CGFloat ty = rect2.origin.y - rect1.origin.y * sy;
    return CGAffineTransformMake(sx, 0.0, 0.0, sy, tx, ty);
}

CGSize CGSizeScale(CGSize size, CGFloat scale) {
    return CGSizeMake(size.width * scale, size.height * scale);
}

CGRect CGRectGetTransposed(CGRect rect) {
    return CGRectMake(rect.origin.y, rect.origin.x, rect.size.height, rect.size.width);
}

CGFloat CGFloatPixelFloor(CGFloat value) {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat result = ( floor(value * scale) ) / scale;
    return result;
}

CGFloat CGFloatPixelCeil(CGFloat value) {
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat result = ( ceil(value * scale) ) / scale;
    return result;
}


