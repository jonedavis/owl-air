//
//  UIImageView.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIImageView (LibOften)

//! Sets image with or without animation
- (void)setImage:(UIImage *)image animated:(BOOL)animated;

//! Returns on-screen size of the image without clipping
- (CGSize)onScreenImageSize;

//! Returns zoom transformation which needed to fill view bounds with image given edge insets (usually negative, i.e. outsets)
- (CGAffineTransform)transformToAspectFillWithInsets:(UIEdgeInsets)insets;

@end


