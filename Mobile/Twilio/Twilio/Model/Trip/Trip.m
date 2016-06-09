//
//  Trip.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "Trip.h"


NSString *const kTripListFlightNumber = @"flightNumber";
NSString *const kTripListBoardingTime = @"boardingTime";
NSString *const kTripListSeat = @"seat";
NSString *const kTripListSource = @"source";
NSString *const kTripListPassengerName = @"passengerName";
NSString *const kTripListTicketClass = @"ticketClass";
NSString *const kTripListDepartureDate = @"departureDate";
NSString *const kTripListDestinationCode = @"destinationCode";
NSString *const kTripListDestination = @"destination";
NSString *const kTripListSourceCode = @"sourceCode";
NSString *const kTripListGroup = @"group";
NSString *const kTripListGateNumber = @"gateNumber";
NSString *const kTripListDepartsTime = @"departsTime";
NSString *const kTripListArrivalDate = @"arrivalDate";
NSString *const kTripListAgentNumber = @"agentNumber";


@interface Trip ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation Trip

@synthesize flightNumber = _flightNumber;
@synthesize boardingTime = _boardingTime;
@synthesize seat = _seat;
@synthesize source = _source;
@synthesize passengerName = _passengerName;
@synthesize ticketClass = _ticketClass;
@synthesize departureDate = _departureDate;
@synthesize destinationCode = _destinationCode;
@synthesize destination = _destination;
@synthesize sourceCode = _sourceCode;
@synthesize group = _group;
@synthesize gateNumber = _gateNumber;
@synthesize departsTime = _departsTime;
@synthesize arrivalDate = _arrivalDate;
@synthesize agentNumber = _agentNumber;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
	return [[self alloc] initWithDictionary:dict];
}


- (instancetype)initWithDictionary:(NSDictionary *)dict
{
	self = [super init];
	
		// This check serves to make sure that a non-NSDictionary object
		// passed into the model class doesn't break the parsing.
	if(self && [dict isKindOfClass:[NSDictionary class]]) {
		self.flightNumber = [self objectOrNilForKey:kTripListFlightNumber fromDictionary:dict];
		self.boardingTime = [self objectOrNilForKey:kTripListBoardingTime fromDictionary:dict];
		self.seat = [self objectOrNilForKey:kTripListSeat fromDictionary:dict];
		self.source = [self objectOrNilForKey:kTripListSource fromDictionary:dict];
		self.passengerName = [self objectOrNilForKey:kTripListPassengerName fromDictionary:dict];
		self.ticketClass = [self objectOrNilForKey:kTripListTicketClass fromDictionary:dict];
		self.departureDate = [self objectOrNilForKey:kTripListDepartureDate fromDictionary:dict];
		self.destinationCode = [self objectOrNilForKey:kTripListDestinationCode fromDictionary:dict];
		self.destination = [self objectOrNilForKey:kTripListDestination fromDictionary:dict];
		self.sourceCode = [self objectOrNilForKey:kTripListSourceCode fromDictionary:dict];
		self.group = [self objectOrNilForKey:kTripListGroup fromDictionary:dict];
		self.gateNumber = [self objectOrNilForKey:kTripListGateNumber fromDictionary:dict];
		self.departsTime = [self objectOrNilForKey:kTripListDepartsTime fromDictionary:dict];
		self.arrivalDate = [self objectOrNilForKey:kTripListArrivalDate fromDictionary:dict];
		self.agentNumber = [self objectOrNilForKey:kTripListAgentNumber fromDictionary:dict];
	}
	
	return self;
	
}

	// Generate a Dictionary from the Available dictionary
- (NSDictionary *)dictionaryRepresentation
{
	NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:self.flightNumber forKey:kTripListFlightNumber];
	[mutableDict setValue:self.boardingTime forKey:kTripListBoardingTime];
	[mutableDict setValue:self.seat forKey:kTripListSeat];
	[mutableDict setValue:self.source forKey:kTripListSource];
	[mutableDict setValue:self.passengerName forKey:kTripListPassengerName];
	[mutableDict setValue:self.ticketClass forKey:kTripListTicketClass];
	[mutableDict setValue:self.departureDate forKey:kTripListDepartureDate];
	[mutableDict setValue:self.destinationCode forKey:kTripListDestinationCode];
	[mutableDict setValue:self.destination forKey:kTripListDestination];
	[mutableDict setValue:self.sourceCode forKey:kTripListSourceCode];
	[mutableDict setValue:self.group forKey:kTripListGroup];
	[mutableDict setValue:self.gateNumber forKey:kTripListGateNumber];
	[mutableDict setValue:self.departsTime forKey:kTripListDepartsTime];
	[mutableDict setValue:self.arrivalDate forKey:kTripListArrivalDate];
	[mutableDict setValue:self.agentNumber forKey:kTripListAgentNumber];
	
	return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description
{
	return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
	id object = [dict objectForKey:aKey];
	return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super init];
	
	self.flightNumber = [aDecoder decodeObjectForKey:kTripListFlightNumber];
	self.boardingTime = [aDecoder decodeObjectForKey:kTripListBoardingTime];
	self.seat = [aDecoder decodeObjectForKey:kTripListSeat];
	self.source = [aDecoder decodeObjectForKey:kTripListSource];
	self.passengerName = [aDecoder decodeObjectForKey:kTripListPassengerName];
	self.ticketClass = [aDecoder decodeObjectForKey:kTripListTicketClass];
	self.departureDate = [aDecoder decodeObjectForKey:kTripListDepartureDate];
	self.destinationCode = [aDecoder decodeObjectForKey:kTripListDestinationCode];
	self.destination = [aDecoder decodeObjectForKey:kTripListDestination];
	self.sourceCode = [aDecoder decodeObjectForKey:kTripListSourceCode];
	self.group = [aDecoder decodeObjectForKey:kTripListGroup];
	self.gateNumber = [aDecoder decodeObjectForKey:kTripListGateNumber];
	self.departsTime = [aDecoder decodeObjectForKey:kTripListDepartsTime];
	self.arrivalDate = [aDecoder decodeObjectForKey:kTripListArrivalDate];
	self.agentNumber = [aDecoder decodeObjectForKey:kTripListAgentNumber];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	
	[aCoder encodeObject:_flightNumber forKey:kTripListFlightNumber];
	[aCoder encodeObject:_boardingTime forKey:kTripListBoardingTime];
	[aCoder encodeObject:_seat forKey:kTripListSeat];
	[aCoder encodeObject:_source forKey:kTripListSource];
	[aCoder encodeObject:_passengerName forKey:kTripListPassengerName];
	[aCoder encodeObject:_ticketClass forKey:kTripListTicketClass];
	[aCoder encodeObject:_departureDate forKey:kTripListDepartureDate];
	[aCoder encodeObject:_destinationCode forKey:kTripListDestinationCode];
	[aCoder encodeObject:_destination forKey:kTripListDestination];
	[aCoder encodeObject:_sourceCode forKey:kTripListSourceCode];
	[aCoder encodeObject:_group forKey:kTripListGroup];
	[aCoder encodeObject:_gateNumber forKey:kTripListGateNumber];
	[aCoder encodeObject:_departsTime forKey:kTripListDepartsTime];
	[aCoder encodeObject:_arrivalDate forKey:kTripListArrivalDate];
	[aCoder encodeObject:_agentNumber forKey:kTripListAgentNumber];
}

- (id)copyWithZone:(NSZone *)zone
{
	Trip *copy = [[Trip alloc] init];
	
	if (copy) {
		copy.flightNumber = [self.flightNumber copyWithZone:zone];
		copy.boardingTime = [self.boardingTime copyWithZone:zone];
		copy.seat = [self.seat copyWithZone:zone];
		copy.source = [self.source copyWithZone:zone];
		copy.passengerName = [self.passengerName copyWithZone:zone];
		copy.ticketClass = [self.ticketClass copyWithZone:zone];
		copy.departureDate = [self.departureDate copyWithZone:zone];
		copy.destinationCode = [self.destinationCode copyWithZone:zone];
		copy.destination = [self.destination copyWithZone:zone];
		copy.sourceCode = [self.sourceCode copyWithZone:zone];
		copy.group = [self.group copyWithZone:zone];
		copy.gateNumber = [self.gateNumber copyWithZone:zone];
		copy.departsTime = [self.departsTime copyWithZone:zone];
		copy.arrivalDate = [self.arrivalDate copyWithZone:zone];
		copy.agentNumber = [self.agentNumber copyWithZone:zone];
	}
	
	return copy;
}


@end


