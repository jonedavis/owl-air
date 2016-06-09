//
//  UIImage.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIImage.h"
#import "../Foundation+LibOften/NSFileManager.h"
#import "../Foundation+LibOften/NSString.h"
#import "../Misc+LibOften/GCD.h"
#import <objc/runtime.h>

@implementation UIImage (LibOften)

+ (instancetype)imageFromAttributedString:(NSAttributedString *)attributedString {
    UIGraphicsBeginImageContextWithOptions(attributedString.size, NO, 0.0);
    [attributedString drawAtPoint:CGPointZero];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end


