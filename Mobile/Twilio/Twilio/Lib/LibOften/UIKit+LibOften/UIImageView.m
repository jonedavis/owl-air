//
//  UIImageView.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIImageView.h"
#import "CGGeometry.h"
#import "../Foundation+LibOften/NSFileManager.h"
#import "../Foundation+LibOften/NSString.h"
#import "../Misc+LibOften/GCD.h"
#import <objc/runtime.h>

@implementation UIImageView (LibOften)

- (void)setImage:(UIImage *)image animated:(BOOL)animated {
    if (animated) { // With animation
        [UIView transitionWithView:self duration:0.25f options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
            self.image = image;
        } completion:nil];
    } else { // Without animation
        self.image = image;
    }
}

- (CGSize)onScreenImageSize {
    if (!self.image)
        return CGSizeZero;
    CGSize selfSize = self.bounds.size;
    CGSize imageSize = self.image.size;
    CGFloat fitWidthScale = selfSize.width / imageSize.width;
    CGFloat fitHeightScale = selfSize.height / imageSize.height;
    if (self.contentMode == UIViewContentModeScaleAspectFit) {
        CGFloat actualScale = MIN(fitWidthScale, fitHeightScale);
        return CGSizeScale(imageSize, actualScale);
    } else if (self.contentMode == UIViewContentModeScaleAspectFill) {
        CGFloat actualScale = MAX(fitWidthScale, fitHeightScale);
        return CGSizeScale(imageSize, actualScale);
    } else if (self.contentMode == UIViewContentModeScaleToFill) {
        return selfSize;
    } else {
        return imageSize;
    }
}

- (CGAffineTransform)transformToAspectFillWithInsets:(UIEdgeInsets)insets {
    NSAssert(self.contentMode == UIViewContentModeScaleAspectFill, @"Content mode must be UIViewContentModeScaleAspectFill for %s", __PRETTY_FUNCTION__);
    CGSize viewSize = self.bounds.size;
    CGSize imageSize = [self onScreenImageSize];
    if (viewSize.width == 0.0 || viewSize.height == 0.0 || imageSize.width == 0.0 || imageSize.height == 0.0)
        return CGAffineTransformIdentity;
    CGFloat scaleX = (viewSize.width - insets.left - insets.right) / imageSize.width;
    CGFloat scaleY = (viewSize.height - insets.top - insets.bottom) / imageSize.height;
    CGFloat scale = MAX(scaleX, scaleY);
    return CGAffineTransformMakeScale(scale, scale);
}

@end


