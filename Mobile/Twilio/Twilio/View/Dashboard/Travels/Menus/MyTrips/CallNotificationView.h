//
//  CallNotificationView.h
//  Twilio
//
//  Created by Shafi on 18/05/15.
//  Copyright (c) 2015 Impekable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CallNotificationView : UIView

	// Label to show duration of Call
@property (nonatomic, strong) IBOutlet UILabel *durationLabel,*agentNameLabel;
@end
