//
//  NSBundle.h
//  Marquee
//
//  Created by Alexander Vasenin on 05/08/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

@import Foundation;

@interface NSBundle (LibOften)

//! Returns app dispay name
+ (NSString *)appDisplayName;

//! Returns main bundle id
+ (NSString *)bundleId;

//! Returns main bundle version
+ (NSString *)bundleVersion;

//! Returns main bundle build
+ (NSString *)bundleBuild;

@end


