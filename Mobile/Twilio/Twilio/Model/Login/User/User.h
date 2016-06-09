//
//  User.h
//
//  Created by Shaffiulla Khan on 22/07/15
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
//! Zero if online and One if offline on mobile
@property (nonatomic, assign) double mobile;
//! Name to use in app
@property (nonatomic, strong) NSString *name;
//! Login name is name used in twitter login or email
@property (nonatomic, strong) NSString *loginName;
//! image url of twitter
@property (nonatomic, strong) NSString *profileimage;
//! time stamp on new user create
@property (nonatomic, assign) NSInteger timestamp;
//! Convert dictionary to User modal
+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
//! Convert dictionary to User model
- (instancetype)initWithDictionary:(NSDictionary *)dict;
//! Convert to dictionary
- (NSDictionary *)dictionaryRepresentation;
@end


