//
//  ReviewConfirmView.m
//  Twilio
//
//  Created by Shafi on 14/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "ReviewConfirmView.h"
#import "TwilioHeader.h"

@interface ReviewConfirmView ()
@end

@implementation ReviewConfirmView


-(id)initWithFrame:(CGRect)frame {
		/// Load view from Xib
	self = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class])
										  owner:self
										options:nil] objectAtIndex:0];
	self.translatesAutoresizingMaskIntoConstraints = YES;
	self.frame = frame;
	return self;
}

#pragma mark - setup View

-(void)setupViewWithTripDetails:(Trip *)tripObj{
		// Hide Button & View
	[self updateButtonVisiblity:YES];
	
		// Rounded Rect buttons
	[Utility roundRectCornersForObject:_rejectButton withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:3];
	[Utility roundRectCornersForObject:_confirmButton withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:3];
	
	[self setupExistingDetailView:tripObj];
	[self setupUpdatedDetailView];
}

-(void)setupExistingDetailView:(Trip *)tripObj{
	
		// Create Existing details View
	_existingDetailCardView = [[TripView alloc] initWithFrame:CGRectMake(10, 40, [UIScreen mainScreen].bounds.size.width-20, 270)];
	_existingDetailCardView.backgroundColor = [UIColor whiteColor];
	[_existingDetailCardView setupValuesFromTrip:tripObj];
	[self addSubview:_existingDetailCardView];

		// Tap Gesture to View Details
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewExistingFlightDetails)];
	tapGesture.numberOfTapsRequired = 1;
	tapGesture.numberOfTouchesRequired = 1;
	[_existingDetailCardView addGestureRecognizer:tapGesture];
}

-(void)setupUpdatedDetailView{
		// Create Updated details View
	_updatedDetailCardView = [[TripView alloc] initWithFrame:CGRectMake(10, 90, [UIScreen mainScreen].bounds.size.width-20, 270)];
	_updatedDetailCardView.backgroundColor = [UIColor whiteColor];
	[self addSubview:_updatedDetailCardView];
	
		// Make it Hidden unless flight details are updated
	_updatedDetailCardView.hidden = YES;
	
		// Tap Gesture to View Details
	UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewUpdatedFlightDetails)];
	tapGesture.numberOfTapsRequired = 1;
	tapGesture.numberOfTouchesRequired = 1;
	[_updatedDetailCardView addGestureRecognizer:tapGesture];
}

-(void)applyShadowEffect{
		// Slight Shadow for the card View of Flight Details
	
	UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_existingDetailCardView.bounds];
	_existingDetailCardView.layer.masksToBounds = NO;
	_existingDetailCardView.layer.shadowColor = [UIColor blackColor].CGColor;
	_existingDetailCardView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
	_existingDetailCardView.layer.shadowOpacity = 0.5f;
	_existingDetailCardView.layer.shadowPath = shadowPath.CGPath;
	_existingDetailCardView.layer.masksToBounds = false;

	UIBezierPath *shadowPathTwo = [UIBezierPath bezierPathWithRect:_updatedDetailCardView.bounds];
	_updatedDetailCardView.layer.masksToBounds = NO;
	_updatedDetailCardView.layer.shadowColor = [UIColor blackColor].CGColor;
	_updatedDetailCardView.layer.shadowOffset = CGSizeMake(0.0f, 5.0f);
	_updatedDetailCardView.layer.shadowOpacity = 0.5f;
	_updatedDetailCardView.layer.shadowPath = shadowPathTwo.CGPath;
	_updatedDetailCardView.layer.masksToBounds = false;
}

-(void)updateTripDetails:(Trip *)trip{
		// Show Updated Detials View
	_updatedDetailCardView.hidden = false;
	[_updatedDetailCardView setupValuesFromTrip:trip];
	
	
	CGRect originalFrame = CGRectMake(_existingDetailCardView.frame.origin.x, _existingDetailCardView.frame.origin.y+50, _existingDetailCardView.frame.size.width, _existingDetailCardView.frame.size.height);
	CGRect tempFrame = originalFrame;
	tempFrame.origin.y = 0 - _updatedDetailCardView.frame.size.height;
	
	_updatedDetailCardView.frame = tempFrame;
	[self bringSubviewToFront:_updatedDetailCardView];
	
		// Slide animate view
	[UIView animateWithDuration:0.5
					 animations:^{
						 _updatedDetailCardView.frame = originalFrame;
					 }
					 completion:^(BOOL finished) {
							 // Unhide Buttons
						 [self updateButtonVisiblity:false];
					}];
}

-(void)updateUpdatedTripFrameSize{
		// Show Updated Detials View
	_updatedDetailCardView.hidden = false;
	
	CGRect originalUpdatingFrame = _updatedDetailCardView.frame;
	originalUpdatingFrame.origin.y = 40;
	
		// Slide animate view
	[UIView animateWithDuration:0.5
					 animations:^{
						 _updatedDetailCardView.frame = originalUpdatingFrame;
						 _updatedDetailCardView.hidden = false;
					 }
					 completion:^(BOOL finished) {
							 // Unhide Buttons
					 }];
}

-(void)popOutUpdateTripDetails{
		// Action to be taken when user select Reject from Flight Details Pages / Hangout before confirmation, so the will take of the newly updated flight details card from top of the Stack

		// Show Updated Detials View
	CGRect originalFrame = _updatedDetailCardView.frame;
	CGRect tempFrame = originalFrame;
	tempFrame.origin.y = 0 - _updatedDetailCardView.frame.size.height;
	
	[self bringSubviewToFront:_updatedDetailCardView];
	
		// Slide animate view
	[UIView animateWithDuration:0.5
					 animations:^{
						 _updatedDetailCardView.frame = tempFrame;
					 }
					 completion:^(BOOL finished) {
					 }];
}

-(void)popOutExistingTripDetails{
		// Action to be taken when user select Hangout after confirmation, so the will take of the newly existing flight details card from top of the Stack
	
		// Show Updated Detials View
	CGRect originalFrame = _existingDetailCardView.frame;
	CGRect tempFrame = originalFrame;
	tempFrame.origin.y = 0 - _existingDetailCardView.frame.size.height;
	
//	[self bringSubviewToFront:_existingDetailCardView];
	
		// Slide animate view
	[UIView animateWithDuration:0.5
					 animations:^{
						 _existingDetailCardView.frame = tempFrame;
					 }
					 completion:^(BOOL finished) {
						 [self updateUpdatedTripFrameSize];
					 }];
}

#pragma mark - Gesture Action
-(void)viewExistingFlightDetails{
		// Make Existing Details Visible
	[self bringSubviewToFront:_existingDetailCardView];
}


-(void)viewUpdatedFlightDetails{
		// Make Updated Details Visible
//	[self bringSubviewToFront:_shadowView];
	[self bringSubviewToFront:_updatedDetailCardView];
}

#pragma mark - Button Action
-(IBAction)rejectAction:(id)sender{
		// Dismiss pop back to previous Page
	if ([self.delegate respondsToSelector:@selector(rejectReviewAction)]) {
		[self.delegate rejectReviewAction];
	}
}

-(IBAction)confirmAction:(id)sender{
		// On confirm ask for Birthday
	if ([self.delegate respondsToSelector:@selector(confirmReviewAction)]) {
		[self.delegate confirmReviewAction];
	}
}

#pragma mark - Update the UI
-(void)updateButtonVisiblity:(BOOL)setHidden{
	self.rejectButton.hidden = setHidden;
	self.confirmButton.hidden = setHidden;
}
@end
