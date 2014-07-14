//
//  TabViewController3.h
//  Happ_viewChange
//
//  Created by tkm03 on 2014/06/29.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewController3 : UIViewController<UITextFieldDelegate>{
    int secTime;
    int minTime;
    int hourTime;
    NSString *time;
    NSTimer *tm;
    NSString *title;
    NSString *category;
    NSString *memo;
    NSString *start_time;
    NSString *stop_time;
    



}
@property (weak, nonatomic) IBOutlet UILabel *timeView;

@property (weak, nonatomic) IBOutlet UIButton *stopView;

@property (weak, nonatomic) IBOutlet UITextField *kenmei;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *memo;
@property (weak, nonatomic) IBOutlet UIButton *startView;



- (IBAction)timeStop:(id)sender;
- (IBAction)dataPreserve:(id)sender;

- (IBAction)dataSync:(id)sender;

- (IBAction)timeStart:(id)sender;

@end
