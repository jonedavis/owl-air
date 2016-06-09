//
//  LoginControl.m
//  Twilio
//
//  Created by Shafi on 09/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import "LoginControl.h"
#import "TwilioHeader.h"
#import "CommandUser.h"

@interface LoginControl ()<UIPickerViewDataSource,UIPickerViewDelegate,LoginDelegate>
{
	IBOutlet LoginView * _loginView;
	IBOutlet UIView * _pickerBGView,*_overlayView;
	IBOutlet UIPickerView *_pickerView;
	
	NSArray *_userList;
	User *_selectedUser;
}
@end

@implementation LoginControl

- (void)viewDidLoad {
    [super viewDidLoad];
	
		// customise view, hide navigation bar
	self.navigationController.navigationBarHidden = true;

		// Setup login View
	_loginView.delegate = self;
	[_loginView setupView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    [[UsersStore shared] getUserNamesWithCompletion:^(NSArray *namesList) {
//        // users
//        _userList = namesList;
//        [_pickerView reloadAllComponents];
//    }];
}

#pragma mark - Button Action
-(IBAction)loginAsGuestAction:(id)sender{
	_selectedUser = [[User alloc] initWithDictionary:@{@"login":@"Guest",@"name":@"Guest",@"profileimage":@"",@"timestamp":@([[NSDate date] timeIntervalSince1970]),@"mobile":@(0)}];
	_loginView._usernameTf.text = _selectedUser.name;
    [self loginAction];
}

- (void)loginAction {
    [[CommandLoginUser commandWithUser:_selectedUser] execute];	
	[[UsersStore shared] logoutUserFromWeb];
}


-(IBAction)pickerCancelAction:(id)sender{
	_pickerBGView.hidden = true;
	_overlayView.hidden = true;
}

-(IBAction)pickerDoneAction:(id)sender{
	_pickerBGView.hidden = true;
	_overlayView.hidden = true;
	
	User *user = _userList[[_pickerView selectedRowInComponent:0]];
    _selectedUser = user;
	_loginView._usernameTf.text = user.name;
}


#pragma mark - Login Delegate

-(void)showPickerView{
	_pickerBGView.hidden = false;
	_overlayView.hidden = false;
}

#pragma mark - UIPickerDelegate
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
	return _userList.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
	User *user = _userList[row];
	return user.name;
}

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
	UILabel *backgroundLabel = [UILabel new];
	backgroundLabel.textAlignment = NSTextAlignmentCenter;
	
	User *user = _userList[row];
	backgroundLabel.text = user.name;
	
	if (user.mobile == 1) {
		backgroundLabel.backgroundColor = [UIColor grayColor];
	}
	else{
		backgroundLabel.backgroundColor = [UIColor lightGrayColor];
	}
	return backgroundLabel;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	User *user = _userList[row];
	if (user.mobile == 1) {
		if (row <= 0) {
			[pickerView selectRow:row+1  inComponent:0 animated:true];
		}
		else if(row >= _userList.count-1){
			[pickerView selectRow:row-1  inComponent:0 animated:true];
		}
		else{
			[pickerView selectRow:row+1  inComponent:0 animated:true];
		}
	}
}

@end


