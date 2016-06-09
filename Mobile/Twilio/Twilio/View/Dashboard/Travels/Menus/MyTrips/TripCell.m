//
//  TripCell.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "TripCell.h"
#import "TwilioHeader.h"

@interface TripCell(){
		// Label for showing value fetched from the API Response
	IBOutlet UILabel *_titleLabel,*_dateLabel,*_sourceLabel,*_destLabel,*_timeLabel,*_flightNumbLable,*_gateNumbLabel,*_groupLabel,*_seatLabel;
	
		// Background View for Rounded Rect
	IBOutlet UIView *_backgroundView,*_groupBackgroundView;
}
@end

@implementation TripCell

- (void)awakeFromNib {
	
		// Rounded Rect for Background View
	[Utility roundRectCornersForObject:_backgroundView withBorderWidth:1 colorRef:[UIColor lightGrayColor].CGColor radius:6];
	
	[Utility roundRectCornersForObject:_groupBackgroundView withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:3];
}

	// Setting Values for Label in the Cell which are from API Response
-(void)setValuesFromTrip:(Trip *)tripObj{
	_titleLabel.text = tripObj.destination;
	_dateLabel.text = [Utility formatDateFromString:tripObj.departureDate withFormat:@"MMM dd, yyyy"];
	_sourceLabel.text = tripObj.sourceCode;
	_destLabel.text = tripObj.destinationCode;
	_timeLabel.text = tripObj.departsTime;
	_flightNumbLable.text = tripObj.flightNumber;
	_gateNumbLabel.text = tripObj.gateNumber;
	_groupLabel.text = tripObj.group;
	_seatLabel.text = tripObj.seat;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
