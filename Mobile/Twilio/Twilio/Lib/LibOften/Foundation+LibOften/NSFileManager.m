//
//  NSFileManager.m
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "NSFileManager.h"

@implementation NSFileManager (LibOften)

+ (NSString *)documentsDirectoryPath {
    return NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)libraryDirectoryPath {
    return NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)cachesDirectoryPath {
    return NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
}

+ (NSString *)pathForCachedFile:(NSString *)filename {
    return [[NSFileManager cachesDirectoryPath] stringByAppendingPathComponent:filename];
};

@end


