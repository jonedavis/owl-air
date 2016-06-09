//
//  TripView.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "TripView.h"
#import "TwilioHeader.h"

@interface TripView ()
{
		// Labels for the Trip Details view
	IBOutlet UILabel *_flightNumbLable,*_gateNumbLabel,*_sourceLabel,*_destLabel,*_sourceCodeLabel,
	*_destCodeLabel,*_departureDateLabel,*_arrivalDateLabel,*_boardTimeLabel,*_departsTimeLabel,*_groupLabel,*_seatLabel,*_passengerLabel,*_ticketClassLabel;
}
@end

@implementation TripView

-(id)initWithFrame:(CGRect)frame {
		/// Load view from Xib
	self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
										  owner:self
										options:nil] objectAtIndex:0];
	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.frame = frame;
		// Make corner rounded
	[Utility roundRectCornersForObject:self withBorderWidth:1 colorRef:[UIColor lightGrayColor].CGColor radius:4];
	return self;
}

#pragma mark - Configure View

-(void)setupValuesFromTrip:(Trip *)tripObj{
		// Set values for labels 
	_flightNumbLable.text = tripObj.flightNumber;
	_gateNumbLabel.text = tripObj.gateNumber;
	_sourceLabel.text = tripObj.source;
	_destLabel.text = tripObj.destination;
	_sourceCodeLabel.text = tripObj.sourceCode;
	_destCodeLabel.text = tripObj.destinationCode;
	_departureDateLabel.text = [Utility formatDateFromString:tripObj.departureDate withFormat:@"EEE, MMM dd"];
	_arrivalDateLabel.text = [Utility formatDateFromString:tripObj.arrivalDate withFormat:@"EEE, MMM dd"];
	_boardTimeLabel.text = tripObj.boardingTime;
	_departsTimeLabel.text = tripObj.departsTime;
	_groupLabel.text = tripObj.group;
	_seatLabel.text = tripObj.seat;
	_passengerLabel.text = [[UsersStore shared] user].name;
	_ticketClassLabel.text = tripObj.ticketClass;
}
@end
