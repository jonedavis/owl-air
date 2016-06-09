//
//  ConfirmFlightControl.h
//  Twilio
//
//  Created by Shafi on 13/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Trip;

@protocol ConfirmFlightDelegate <NSObject>

	// Delegate to pass back when user select the hang up button from the confirm UI
-(void)updateFlightChanges:(Trip *)tripDetails;
@end

@interface ConfirmFlightControl : UIViewController
	// Details from the server as Custom Object as TRIP
@property (nonatomic, strong) Trip *tripObj;


	// Delegate reference of the control on which view has to be customise
@property (nonatomic, assign) id <ConfirmFlightDelegate> delegate;
@end
