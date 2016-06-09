//
//  NSString.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSString.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString (LibOften)

- (NSString *)stringByReplacingRegex:(NSString *)pattern withString:(NSString *)replacement {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:nil];
    return [regex stringByReplacingMatchesInString:self options:0 range:NSMakeRange(0, self.length) withTemplate:replacement];
}

- (NSString *)firstMatchForRegex:(NSString *)pattern {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:pattern options:0 error:nil];
    NSTextCheckingResult *match = [regex firstMatchInString:self options:0 range:NSMakeRange(0, self.length)];
    return [self substringWithRange:[match rangeAtIndex:1]];
}

- (NSString *)escapeEverything {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(NULL, (__bridge CFStringRef)self, NULL, CFSTR("!*'();:@&=+$,/?%#[]\" "), kCFStringEncodingUTF8));
}

- (NSNumber *)numberFromString {
    static NSNumberFormatter *format;
    if (!format) {
        format = [NSNumberFormatter new];
        [format setNumberStyle:NSNumberFormatterDecimalStyle];
    } return [format numberFromString:self];
}

- (NSUInteger)wordCount {
    __block NSUInteger count = 0;
    [self enumerateSubstringsInRange:NSMakeRange(0, self.length) options:NSStringEnumerationByWords usingBlock:^(NSString *character, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        count++;
    }]; return count;
}

- (NSString *)md5 {
    const char *cstr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cstr, (unsigned int)strlen(cstr), result);
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4], result[5], result[6], result[7], result[8], result[9], result[10], result[11], result[12], result[13], result[14], result[15]];
}

- (NSString *)stringByRemovingNonAlphanumerics {
    NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
    NSString *result = [[self componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
    return result;
}

- (BOOL)containsStringSafe:(NSString *)string {
    return [self rangeOfString:string].location != NSNotFound;
}

- (NSString *)trimToIndex:(NSInteger)index {
    if (self.length >= index) {
        return [[self substringToIndex:index-3] stringByAppendingString:@"..."];
    } else {
        return self;
    }
}

- (NSString *)stringByRepeatingNumberOfTimes:(NSUInteger)numberOfTimes {
    NSUInteger length = self.length * numberOfTimes;
    return [@"" stringByPaddingToLength:length withString:self startingAtIndex:0];
}

- (NSString *)stringByRemovingNewLineCharacters {
    return [[self componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]] componentsJoinedByString:@""];
}

	// Returns valid url by replacing parameters
- (NSString *)getURLWithParameter:(NSDictionary *)paramDictionary{
	NSString *validURL = self;
	
	for (NSString *key in paramDictionary.allKeys) {
		validURL  = [validURL stringByReplacingOccurrencesOfString:key withString:paramDictionary[key]];
	}
	
	return validURL;
}

@end


