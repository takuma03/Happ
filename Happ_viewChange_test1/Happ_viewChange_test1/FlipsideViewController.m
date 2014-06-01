//
//  FlipsideViewController.m
//  Happ_viewChange_test1
//
//  Created by tkm03 on 2014/06/01.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "FlipsideViewController.h"

@interface FlipsideViewController ()

@end

@implementation FlipsideViewController
@synthesize myStr;


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    NSString *checkStr = @"YES";
    if (myStr == checkStr) {
        self.mySw.on = YES;
    }else{
        self.mySw.on = NO;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.delegate flipsideViewControllerDidFinish:self];
}

- (IBAction)changeSW:(id)sender {
    if (self.mySw.on) {
        myStr = @"YES";
    }else{
        myStr = @"NO";
    }
}
@end
