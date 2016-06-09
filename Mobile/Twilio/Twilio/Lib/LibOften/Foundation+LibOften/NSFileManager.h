//
//  NSFileManager.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSFileManager (LibOften)

//! Returns path for documents directory
+ (NSString *)documentsDirectoryPath;

//! Returns path for library directory
+ (NSString *)libraryDirectoryPath;

//! Returns path for caches directory
+ (NSString *)cachesDirectoryPath;

// Returns absolute path for file in cache folder
+ (NSString *)pathForCachedFile:(NSString *)filename;

@end


