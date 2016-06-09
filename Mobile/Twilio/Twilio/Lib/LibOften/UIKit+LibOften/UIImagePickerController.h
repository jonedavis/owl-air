//
//  UIImagePickerController.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import UIKit;

#ifndef TARGET_APP_EXTENSION

@interface UIImagePickerController (LibOften)

//! Shows image picker with completion block
+ (instancetype)showWithSourceType:(UIImagePickerControllerSourceType)sourceType allowEditing:(BOOL)allowEditing completion:(void(^)(UIImage *image))completion;

@end

#endif


