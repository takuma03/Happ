//
//  ViewController.h
//  Happ_timeMeasure
//
//  Created by takuma on 2014/02/04.
//  Copyright (c) 2014年 卓馬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITextFieldDelegate>{
    int secTime;
    int minTime;
    int hourTime;
    NSTimer *tm;
    NSString *time;
    NSString *title;
    NSString *categoly;
    NSString *memo;
    
}
@property (weak, nonatomic) IBOutlet UILabel *timeView;
- (IBAction)timeStart:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *startView;
- (IBAction)timeStop:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stopView;
@property (weak, nonatomic) IBOutlet UITextField *kenmei;
@property (weak, nonatomic) IBOutlet UITextField *categoly;
@property (weak, nonatomic) IBOutlet UITextField *memo;

@end
