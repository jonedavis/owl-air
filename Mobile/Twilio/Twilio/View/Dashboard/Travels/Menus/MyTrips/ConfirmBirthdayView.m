//
//  ConfirmBirthdayView.m
//  Twilio
//
//  Created by Shafi on 14/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "ConfirmBirthdayView.h"
#import "TwilioHeader.h"

@interface ConfirmBirthdayView ()
{
		// Label to show Date on Selection
	IBOutlet UILabel *_dateLabel;
	
		// Button to Confirm Action
	IBOutlet UIButton *_confirmButton;

		// Customise System Date to Formatted Date
	NSDateFormatter *_dateFormatter;
}
@end

@implementation ConfirmBirthdayView


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

-(void)setupView{
		//date formatter with both date and time
	_dateFormatter = [[NSDateFormatter alloc] init];
	[_dateFormatter setDateFormat:@"MM-dd-yyyy"];
	
		// Rounded Rect Date Label
	[Utility roundRectCornersForObject:_dateLabel withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:4];
	
		// Rounded Rect Confirm Button
	[Utility roundRectCornersForObject:_confirmButton withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:4];
}


-(IBAction)confirmAction:(id)sender{
		// Check for Date Value if its Empty String / Nil show alert to select date
	if ([_dateLabel.text isEqualToString:@""] || !_dateLabel.text) {
		UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"" message:@"Please select date to Confirm" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
		[alertView show];
		
		return;
	}
	if ([self.delegate respondsToSelector:@selector(confirmDate:forView:)]) {
			// Pass Date to update
		[[self delegate] confirmDate:_dateLabel.text forView:self];
	}
}

	//listen to changes in the date picker and just log them
- (IBAction) datePickerDateChanged:(UIDatePicker *)paramDatePicker{
	_dateLabel.text = [_dateFormatter stringFromDate:paramDatePicker.date];
}


@end
