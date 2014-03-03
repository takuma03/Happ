//
//  ViewController.m
//  Happ_dateGet
//
//  Created by tkm03 on 2014/03/02.
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
    

    NSLog(@"現在日時：%@",[self timeGet]);
}


- (NSString *)timeGet{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]]; // Localeの指定
    [df setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *now = [NSDate date];
    NSString *strNow = [df stringFromDate:now];
    
    // ログ出力
    //NSLog(@"現在日時：%@", strNow);
    
    return strNow;
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
