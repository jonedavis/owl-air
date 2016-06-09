//
//  ReviewConfirmView.h
//  Twilio
//
//  Created by Shafi on 14/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Trip;
@class TripView;

@protocol ReviewConfirmDelegate<NSObject>

-(void)rejectReviewAction;
-(void)confirmReviewAction;

@end;

@interface ReviewConfirmView : UIView

	// Delegate reference to perform Confirm & Reject Button Action
@property (nonatomic, assign) id <ReviewConfirmDelegate> delegate;
@property (nonatomic, strong) IBOutlet UILabel *statusLabel;
@property (nonatomic, strong) IBOutlet UIButton *rejectButton,*confirmButton;
@property (nonatomic, strong) TripView *existingDetailCardView,*updatedDetailCardView;

@property (nonatomic, readwrite) BOOL isUpdatedDetails;

	// Setup view configure View and intialise values
-(void)setupViewWithTripDetails:(Trip *)tripObj;
-(void)updateTripDetails:(Trip *)trip;

	// Action to be taken when user select Reject from Flight Details Pages, so the will take of the newly updated flight details card from top of the Stack
-(void)popOutUpdateTripDetails;
	// Action to be taken when user select Hangout after confirmation, so the will take of the newly existing flight details card from top of the Stack
-(void)popOutExistingTripDetails;

	// On Update Remove Existing Detail Card/Old Card
-(void)updateUpdatedTripFrameSize;

	// Hide/Unhide buttons
-(void)updateButtonVisiblity:(BOOL)setHidden;
@end
