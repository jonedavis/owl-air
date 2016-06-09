//
//  CustomActionSheet.h
//  Twilio
//
//  Created by Shafi on 13/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@class CustomActionSheet;

@protocol CustomActionSheetDelegate <NSObject>

-(void)customActionSheet:(CustomActionSheet *)customActionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface CustomActionSheet : UIView{
	
	NSArray *buttonTitles;
	UIView *panel,*backgroundView;
}
	// Reference to delegate the action on clicking menu from sheet
@property (nonatomic, weak) id<CustomActionSheetDelegate> delegate;

-(instancetype)initWithDelegate:(id<CustomActionSheetDelegate>)delegate buttonTitles:(NSArray *)buttonTitles frame:(CGRect)frame;

-(void)showInView:(UIView *)view;

@end
