//
//  UIImagePickerController.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIImagePickerController.h"
#import "UIApplication.h"
#import <objc/runtime.h>

@interface UIImagePickerController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@end

@implementation UIImagePickerController (LibOften)

static char completion_key;

- (void(^)(UIImage *image))completion {
    return objc_getAssociatedObject(self, &completion_key);
}

- (void)setCompletion:(void(^)(UIImage *image))completion {
    objc_setAssociatedObject(self, &completion_key, completion, OBJC_ASSOCIATION_RETAIN);
}

- (void)executeCompletionWithImage:(UIImage *)image {
    void(^completion)(UIImage *image) = [self completion];
    if (completion)
        completion(image);
}

+ (instancetype)showWithSourceType:(UIImagePickerControllerSourceType)sourceType allowEditing:(BOOL)allowEditing completion:(void(^)(UIImage *image))completion {
    UIImagePickerController *imagePickerControl = [UIImagePickerController new];
    imagePickerControl.sourceType = sourceType;
    imagePickerControl.allowsEditing = allowEditing;
    imagePickerControl.delegate = imagePickerControl;
    [imagePickerControl setCompletion:completion];
    [[UIApplication visibleViewController] presentViewController:imagePickerControl animated:YES completion:NULL];
    return imagePickerControl;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self executeCompletionWithImage:info[UIImagePickerControllerEditedImage]];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:NULL];
    [self executeCompletionWithImage:nil];
}

@end


