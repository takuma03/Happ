//
//  FlipsideViewController.h
//  Happ_viewChange_test1
//
//  Created by tkm03 on 2014/06/01.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

@interface FlipsideViewController : UIViewController{
    NSString *myStr;
}
@property (nonatomic, retain) NSString *myStr;
@property (weak, nonatomic) IBOutlet UISwitch *mySw;
- (IBAction)changeSW:(id)sender;

@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;

- (IBAction)done:(id)sender;

@end
