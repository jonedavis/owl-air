//
//  UIControl.h
//  Marquee
//
//  Created by Alexander Vasenin on 10/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

@interface UIControl (LibOften)

@property void(^touchUpInsideBlock)();

@property void(^valueChangedBlock)();

@end


