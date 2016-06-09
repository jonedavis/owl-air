//
//  TripView.h
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Trip;
@interface TripView : UIView
	/// Set Values for Label
-(void)setupValuesFromTrip:(Trip *)tripObj;
@end
