//
//  UIPopoverController.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIPopoverController.h"
#import "../Misc+LibOften/GCD.h"
#import "../Misc+LibOften/Macro.h"

@implementation UIPopoverController (LibOften)

#define POPOVER_DISMISSAL_TIME_NO_ANIMATIONS 0.05
#define POPOVER_DISMISSAL_TIME_ANIMATED 0.55

- (void)dismissPopoverAnimated:(BOOL)animated completion:(void(^)())completion {
    [self dismissPopoverAnimated:animated];
    // Actually it's quite a hack, but it looks like there is no clean solution
    dispatch_main_after(animated ? POPOVER_DISMISSAL_TIME_ANIMATED : POPOVER_DISMISSAL_TIME_NO_ANIMATIONS, ^{
        ExecuteNullableBlockSafely(completion);
    });
}

@end


