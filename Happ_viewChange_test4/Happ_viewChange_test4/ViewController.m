//
//  ViewController.m
//  Happ_viewChange_test4
//
//  Created by NatsukiKudou on 2014/06/02.
//  Copyright (c) 2014年 NatsukiKudou. All rights reserved.
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

- (void)viewWillAppear:(BOOL)animated {
    //[UINavigationBar appearance].titleTextAttributes = @{NSForegroundColorAttributeName: [UIColor whiteColor]};
    //self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    
    //ナビゲーションバーの背景の色の設定
    //self.navigationController.navigationBar.barTintColor = [UIColor grayColor];
    UINavigationBar *navBar = [[self navigationController] navigationBar];
    UIImage *backgroundImage = [UIImage imageNamed:@"someBackgroundImage"];
    [navBar setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    
    [super viewWillAppear:animated];
    
    
}

@end
