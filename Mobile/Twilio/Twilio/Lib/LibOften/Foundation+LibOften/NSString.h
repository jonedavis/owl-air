//
//  NSString.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSString (LibOften)

//! Searches for regex and replaces it with replacement string
- (NSString *)stringByReplacingRegex:(NSString *)pattern withString:(NSString *)replacement;

//! Searches for regex and returns first match
- (NSString *)firstMatchForRegex:(NSString *)pattern;

//! Escapes all characters that aren't allowed in the URL
- (NSString *)escapeEverything;

//! Returns NSNumber from the receiver
- (NSNumber *)numberFromString;

//! Returns number of words in string
- (NSUInteger)wordCount;

//! Returns MD5 hash of the string
- (NSString *)md5;

//! Returns string with all non-alphanumerics trimmed
- (NSString *)stringByRemovingNonAlphanumerics;

//! Returns YES if substring contained in receiver
- (BOOL)containsStringSafe:(NSString *)string;

//! Returns receiver trimmed by given number of characters with ellipses appended
- (NSString *)trimToIndex:(NSInteger)index;

- (NSString *)stringByRepeatingNumberOfTimes:(NSUInteger)numberOfTimes;

- (NSString *)stringByRemovingNewLineCharacters;

- (NSString *)getURLWithParameter:(NSDictionary *)paramDictionary;
@end


