//
//  ViewController.m
//  Happ_viewChange_test5
//
//  Created by tkm03 on 2014/06/21.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidAppear:(BOOL)animated
{
    [NSThread sleepForTimeInterval:3.0];
    ViewControllerItem1 *ViewControllerItem1 = [self.storyboard instantiateViewControllerWithIdentifier:@"tabView1"];
    [self presentViewController:ViewControllerItem1 animated:YES completion:nil];
}


@end
