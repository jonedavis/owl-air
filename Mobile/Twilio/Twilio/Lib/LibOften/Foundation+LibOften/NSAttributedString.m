//
//  NSAttributedString.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSAttributedString.h"

@implementation NSAttributedString (LibOften)

- (instancetype)attributedStringByAddingAttributes:(NSDictionary *)attributes inRange:(NSRange)range {
    NSMutableAttributedString *mutableString = [self mutableCopy];
    [mutableString addAttributes:attributes range:range];
    return [mutableString copy];
}

- (instancetype)attributedStringByAddingAttributes:(NSDictionary *)attributes forCaseInsensitiveSubstring:(NSString *)substring {
    return [self attributedStringByAddingAttributes:attributes inRange:[self.string rangeOfString:substring options:NSCaseInsensitiveSearch]];
}

@end


