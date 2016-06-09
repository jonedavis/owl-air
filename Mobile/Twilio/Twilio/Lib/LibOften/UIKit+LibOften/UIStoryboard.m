//
//  UIStoryboard.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UIStoryboard.h"

@implementation UIStoryboard (LibOften)

+ (UIStoryboard *)mainStoryboard {
    static UIStoryboard *mainStoryboard;
    if (!mainStoryboard) {
        NSString *storyboardName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"UIMainStoryboardFile"];
        mainStoryboard = [UIStoryboard storyboardWithName:storyboardName bundle:nil];
    } return mainStoryboard;
}

@end


