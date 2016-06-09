//
//  Trip.h
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Trip : NSObject<NSCoding, NSCopying>

	// These are the custom object create for UI purpose which can be replaced with valid response for the app
@property (nonatomic, strong) NSString *flightNumber;
@property (nonatomic, strong) NSString *boardingTime;
@property (nonatomic, strong) NSString *seat;
@property (nonatomic, strong) NSString *source;
@property (nonatomic, strong) NSString *passengerName;
@property (nonatomic, strong) NSString *ticketClass;
@property (nonatomic, strong) NSString *departureDate;
@property (nonatomic, strong) NSString *destinationCode;
@property (nonatomic, strong) NSString *destination;
@property (nonatomic, strong) NSString *sourceCode;
@property (nonatomic, strong) NSString *group;
@property (nonatomic, strong) NSString *gateNumber;
@property (nonatomic, strong) NSString *departsTime;
@property (nonatomic, strong) NSString *arrivalDate;
@property (nonatomic, strong) NSString *agentNumber;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
