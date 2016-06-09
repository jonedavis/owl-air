//
//  UILabel.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "UILabel.h"

@implementation UILabel (LibOften)

- (void)improveVisibilityOnClutterdBackground {
    self.layer.shadowOffset = CGSizeZero;
    self.layer.shadowOpacity = 1.0;
    self.layer.masksToBounds = NO;
}

- (BOOL)isTextTruncated {
    CGSize bounds = CGSizeMake(self.bounds.size.width, CGFLOAT_MAX);
    // FIXME: self.font is not the only attribute which could be set for UILabel
    NSDictionary *attributes = @{NSFontAttributeName:self.font};
    // FIXME: we don't take into account self.attributedText
    CGRect perfectRect = [self.text boundingRectWithSize:bounds options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil];
    return perfectRect.size.height > self.bounds.size.height;
}

@end


