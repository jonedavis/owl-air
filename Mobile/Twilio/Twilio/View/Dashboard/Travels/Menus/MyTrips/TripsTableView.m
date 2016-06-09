//
//  TripsTableView.m
//  Twilio
//
//  Created by Shafi on 11/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "TripsTableView.h"
#import "TwilioHeader.h"

@interface TripsTableView()<UITableViewDataSource,UITableViewDelegate>
{
		// Header Count to show number of list
	IBOutlet UILabel *_countLabel;
}
@end

@implementation TripsTableView

@synthesize viewDelegate;

-(void)initializeView{
		// Count Label Customisation
	[Utility roundRectCornersForObject:_countLabel withBorderWidth:1 colorRef:[UIColor lightGrayColor].CGColor radius:6];
	
		// Set TableView Delegate Datasource
	self.delegate = self;
	self.dataSource = self;
	
		// Initialize values
	_tableContentArray = [@[] mutableCopy];
	[self readDataFromFile];
}

-(void)readDataFromFile{
		// Load data from saved file
#warning this has to be replaced by api call to fetch actual list of trip
	NSString * filePath =[[NSBundle mainBundle] pathForResource:@"TripsData" ofType:@"json"];
	
	NSError * error;
	NSString* fileContents =[NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
	if(error){
		NSLog(@"Error reading file: %@",error.localizedDescription);
		return;
	}
	
	NSArray *jsonArray = (NSArray *)[NSJSONSerialization
								JSONObjectWithData:[fileContents dataUsingEncoding:NSUTF8StringEncoding] options:0 error:NULL];
	
		// Set Custom Trip object to NSArray valriable for showing in the tableView list
	for (int i = 0; i < jsonArray.count; i++) {
		NSMutableDictionary *tripDict = [[NSMutableDictionary alloc] initWithDictionary: jsonArray[i]];
		
		NSString *dateStr ;
		if (i == 0) {
			dateStr = [self dateStringFromDate:[NSDate date]];
		}
		else{
			int daysToAdd = (7*i);
			dateStr = [self dateStringFromDate:[[NSDate date] dateByAddingTimeInterval:60*60*24*daysToAdd]];
		}

		[tripDict setObject:dateStr forKey:@"departureDate"];
		[tripDict setObject:dateStr forKey:@"arrivalDate"];
		Trip *trip = [[Trip alloc] initWithDictionary:tripDict];
		
		NSLog(@"trip.departureDate -- ^%@\ntrip.arrivalDate %@",trip.departureDate,trip.arrivalDate);
		[_tableContentArray addObject:trip];
	}
}

-(NSString *)dateStringFromDate:(NSDate *)date{
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM-dd-yyyy"];
		//Optionally for time zone conversions
	[formatter setTimeZone:[NSTimeZone systemTimeZone]];
	
	return [formatter stringFromDate:date];
}

#pragma mark - UITableViewDelegate / UITableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
		/* Two sections 
			1. Trip List
			2. Mileage Rewards Balance
		 */
	return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
		// Count of List of Trips
	if (section == 0) {
		return _tableContentArray.count;
	}
#warning this has to be change based on rewards balance value getting from Server
		// Count for Rewards Balance Section
	return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0) {
			// Height for Trip Card
		return 140;
	}
		// Height for Reward Mileage
	return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
		// Customise Cell for Rewards Mileage
	if (indexPath.section == 1) {
		NSString *cellIdentifier = @"RewardsCell";
		UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		
		if (!cell) {
			cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
		}
		
		UIView *cellBgView = [cell viewWithTag:1];
		[Utility roundRectCornersForObject:cellBgView withBorderWidth:1 colorRef:[UIColor clearColor].CGColor radius:4];
		
		return cell;
	}
	else{
			// Customise cell for Trip Details
		NSString *cellIdentifier = [NSString stringWithFormat:@"Trip-%ld.%ld",(long)indexPath.section,(long)indexPath.row];
		
		TripCell *cell = (TripCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
		
			// Create Cell is null
		if (!cell) {
				// Load the top-level objects from the custom cell XIB.
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TripCell" owner:self options:nil];
				// Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
			cell = [topLevelObjects objectAtIndex:0];
		}
		
			// set Cell Title
		[cell setValuesFromTrip:_tableContentArray[indexPath.row]];
		return cell;
	}
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
		// Footer No Separator
	return 0.01;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
	return [UIView new];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	if (indexPath.section == 0) {
		if ([self.viewDelegate respondsToSelector:@selector(selectedRow:tripObj:)]) {
			Trip *tripObj = _tableContentArray[indexPath.row];
				// Passing the control to Control Class to navigate to Details View
			[self.viewDelegate selectedRow:indexPath.row tripObj:tripObj];
			
			[Flurry logEvent:@"Viewing-Pass" withParameters:@{@"User":[UsersStore shared].user.loginName,
															  @"BoardingPass":[NSString stringWithFormat:@"%@ -> %@",tripObj.source,tripObj.destination],
															  @"BoardingDate":[Utility formatDateFromString:tripObj.departureDate withFormat:@"MMM dd, yyyy"]}];

		}
	}
}

@end
