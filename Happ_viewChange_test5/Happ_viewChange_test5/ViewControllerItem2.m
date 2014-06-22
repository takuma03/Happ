//
//  ViewControllerItem2.m
//  Happ_viewChange_test5
//
//  Created by tkm03 on 2014/06/21.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "ViewControllerItem2.h"
#import "AppDelegate.h"

@interface ViewControllerItem2 ()

@end

@implementation ViewControllerItem2


- (void)viewWillAppear:(BOOL)animated{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.name = @"齋藤卓馬２";
    self.myLabel.text = appDelegate.name;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
