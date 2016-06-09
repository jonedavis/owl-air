//
//  ConfirmBirthdayView.h
//  Twilio
//
//  Created by Shafi on 14/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ConfirmBirthdayView;

@protocol ConfirmBirthdayDelegate <NSObject>
	/* On selecting Date update the card and Remove Confirm birthday View
	 */
-(void)confirmDate:(NSString *)dateStr forView:(ConfirmBirthdayView *)view;

@end


@interface ConfirmBirthdayView : UIView

@property(nonatomic, assign) id <ConfirmBirthdayDelegate> delegate;
	// Setup view configure View and intialise values
-(void)setupView;

@end
