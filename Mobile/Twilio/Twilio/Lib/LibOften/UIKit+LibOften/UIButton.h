//
//  UIButton.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIButton (LibOften)

/// == titleForState:UIControlStateNormal
@property (nonatomic) NSString *title;

/// == titleColorForState:UIControlStateNormal
@property (nonatomic) UIColor *titleColor;

/// == imageForState:UIControlStateNormal
@property (nonatomic) UIImage *image;

/// == backgroundImageForState:UIControlStateNormal
@property (nonatomic) UIImage *backgroundImage;

@end


