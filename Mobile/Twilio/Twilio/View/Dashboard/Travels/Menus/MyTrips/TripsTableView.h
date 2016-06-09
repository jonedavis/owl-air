//
//  TripsTableView.h
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Trip;

@protocol TripsTableDelegate <NSObject>

/*
 Delegate action on selecting cell from the tableview
 */
-(void)selectedRow:(NSInteger)row tripObj:(Trip *)tripObj;

@end

@interface TripsTableView : UITableView

	// Array for storing list of Trips
@property (nonatomic, strong) NSMutableArray *tableContentArray;
	// Delgate object to passing action perform on Buttons
@property (nonatomic, assign) id <TripsTableDelegate> viewDelegate;

	// Set / Configure view
-(void)initializeView;
@end
