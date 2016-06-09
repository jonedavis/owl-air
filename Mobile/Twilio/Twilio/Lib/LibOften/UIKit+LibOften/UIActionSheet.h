//
//  UIActionSheet.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

#ifndef TARGET_APP_EXTENSION

@interface UIActionSheet (LibOften)

//! Shows action sheet with completion block
+ (instancetype)showWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonTitle:(NSString *)destructiveButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles completion:(void(^)(NSInteger buttonIndex))completion;

@end

#endif


