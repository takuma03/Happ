//
//  myViewController.m
//  Happ_viewChange_test2
//
//  Created by tkm03 on 2014/06/01.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "myViewController.h"
#import "AppDelegate.h"

@interface myViewController ()

@end

@implementation myViewController

- (void)viewWillAppear:(BOOL)animated
{
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.myCount++;
    self.myLabel.text = [NSString stringWithFormat:@"<%d>", appDelegate.myCount];
    
    [super viewWillAppear:animated];
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
