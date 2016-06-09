//
//  UIAlertView.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

#ifndef TARGET_APP_EXTENSION

@interface UIAlertView (LibOften)

// Shows alert view with completion block
+ (instancetype)showWithTitle:(NSString *)title message:(NSString *)message buttons:(NSArray *)buttons completion:(void(^)(NSUInteger btn))completion;

@end

#endif


