//
//  NSAttributedString.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSAttributedString (LibOften)

- (instancetype)attributedStringByAddingAttributes:(NSDictionary *)attributes inRange:(NSRange)range;

- (instancetype)attributedStringByAddingAttributes:(NSDictionary *)attributes forCaseInsensitiveSubstring:(NSString *)substring;

@end


