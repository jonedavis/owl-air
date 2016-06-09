//
//  TripCell.h
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Trip;

@interface TripCell : UITableViewCell

	// Setting Values for Label in the Cell which are from API Response
-(void)setValuesFromTrip:(Trip *)tripObj;
@end
