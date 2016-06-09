//
//  TravelDetailControl.h
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Trip;

@protocol UpdateTripDetailsDelegate <NSObject>

	// Update List with details which has been updated after the confirmation from the Airline Executive
-(void)updateDetailsForTrip:(Trip *)tripObj withUpdatedTrip:(Trip *)updatedTrip;

@end

@interface TravelDetailControl : UIViewController

	// Details from the server as Custom Object as TRIP
@property (nonatomic, strong) Trip *tripObj;

	// Delegate Reference for the Update Details for List
@property (nonatomic, assign) id <UpdateTripDetailsDelegate> delegate;
@end
