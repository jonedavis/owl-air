//
//  CustomActionSheet.m
//  Twilio
//
//  Created by Shafi on 13/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "CustomActionSheet.h"
#import "TwilioHeader.h"
@implementation CustomActionSheet {
	
	CGPoint panelCenter;
	float panelHeight;
	
}

-(instancetype)initWithDelegate:(id<CustomActionSheetDelegate>)delegate buttonTitles:(NSArray *)titles frame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		buttonTitles = [[titles reverseObjectEnumerator] allObjects];
		_delegate = delegate;
		
			// Set background Transparent View
		backgroundView = [UIView new];
		backgroundView.translatesAutoresizingMaskIntoConstraints = NO;
		
			// Bottom Background view from Menu buttons
		panel = [UIView new];
		panel.translatesAutoresizingMaskIntoConstraints = NO;
		
			// Tapgesture for dismisal of sheet
		UITapGestureRecognizer *backgroungTap = [[UITapGestureRecognizer alloc]
												 initWithTarget:self
												 action:@selector(hideAlert)];
		
		backgroungTap.cancelsTouchesInView = YES;
		
		[self addGestureRecognizer:backgroungTap];
		
		[self addSubview:backgroundView];
		[self addSubview:panel];
		
	}
	
	return self;
}

-(void)showInView:(UIView *)view{
	[view.window addSubview:self];
	
		// Configure Constraint
	NSDictionary *mainViews = @{@"bg":backgroundView,@"panel":panel};
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[bg]-0-|"
																 options:0
																 metrics:nil
																   views:mainViews]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-0-[bg]-0-|"
																 options:0
																 metrics:nil
																   views:mainViews]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-0-[panel]-0-|"
																 options:0
																 metrics:nil
																   views:mainViews]];
	
	[self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[panel]-0-|"
																 options:0
																 metrics:nil
																   views:mainViews]];
	backgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.4];
	panel.backgroundColor = [UIColor whiteColor];
	
	NSMutableDictionary *views = [NSMutableDictionary new];
	
	[views setObject:panel forKey:@"panelView"];
	
	for (NSString *buttonTitle in buttonTitles) {
			// Add buttons
		UIButton *button = [[UIButton alloc] init];
		button.backgroundColor = [UIColor purpleColor];

		NSString *buttonHash = [NSString stringWithFormat:@"_%lu",(unsigned long)[buttonTitle hash]];
		
		[button setTitle:buttonTitle forState:UIControlStateNormal];
		[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		[button addTarget:self action:@selector(actionButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
		[button.layer setCornerRadius:3.0];
		if ([buttonTitles indexOfObject:buttonTitle] == 0) {
			[button setBackgroundColor:[UIColor clearColor]];
			[button setTitleColor:[Utility colorWithHexString:kAppGrayColor] forState:UIControlStateNormal];
			
			button.layer.borderColor = [Utility colorWithHexString:kAppGrayColor].CGColor;
			button.layer.borderWidth = 1;
		}
		else{
			[button setBackgroundColor:[Utility colorWithHexString:kAppGrayColor]];
		}
		button.titleLabel.font = [UIFont boldSystemFontOfSize:15];
		
		[panel addSubview:button];
		
		[views setObject:button forKey:buttonHash];
		
		button.translatesAutoresizingMaskIntoConstraints = NO;
		
		if ([buttonTitles indexOfObject:buttonTitle] == 0) {
			
			[panel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@(45)]-10-|",buttonHash]
																		  options:0
																		  metrics:nil
																			views:views]];
		} else {
			
			NSString *nextButtonHash = [NSString stringWithFormat:@"_%lu",(unsigned long)[[buttonTitles objectAtIndex:[buttonTitles indexOfObject:buttonTitle]-1] hash]];
			
			if ([buttonTitles indexOfObject:buttonTitle] != [buttonTitles count]-1) {
				
				
				[panel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[%@(45)]-8-[%@]",buttonHash,nextButtonHash]
																			  options:0
																			  metrics:nil
																				views:views]];
				
			} else {
				
				NSString *mask = @"V:|-10-[%@(45)]-8-[%@]";
				
				[panel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:mask,buttonHash,nextButtonHash]
																			  options:0
																			  metrics:nil
																				views:views]];
				
			}
			
			
		}
		
		[panel addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"|-10-[%@]-10-|",buttonHash]
																	  options:0
																	  metrics:nil
																		views:views]];
		
	}
	
	[self layoutSubviews];
	
	backgroundView.alpha = 0;
	panelCenter = panel.center;
	panelHeight = panel.frame.size.height / 2;
	
	panel.center = CGPointMake(panelCenter.x, panelCenter.y + panelHeight*2);
	
	[UIView animateWithDuration:0.2
						  delay:0
						options:7<<16
					 animations:^{
						 backgroundView.alpha = 1;
						 panel.center = panelCenter;
					 } completion:nil];
}

- (void)actionButtonPressed:(UIButton *)button {
	
	[_delegate customActionSheet:self clickedButtonAtIndex:[buttonTitles indexOfObject:button.currentTitle]];
	[self hideAlert];
	
}

- (void) hideAlert
{
	[UIView animateWithDuration:0.2
						  delay:0
						options:7<<16
					 animations:^{
						 backgroundView.alpha = 0;
						 panel.frame = CGRectMake(0, panel.frame.origin.y + panel.frame.size.height, panel.frame.size.width, panel.frame.size.height);
					 } completion:^(BOOL finished) {
						 [self removeFromSuperview];
					 }];
}


@end
