//
//  ViewController.m
//  Happ_timeMeasure
//
//  Created by takuma on 2014/02/04.
//  Copyright (c) 2014年 卓馬. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.stopView.alpha = 0;
    [self.kenmei setDelegate:self];
    [self.categoly setDelegate:self];
    [self.memo setDelegate:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)timeStart:(id)sender {
    tm = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    //スタートボタンを非表示
    title = self.kenmei.text;
    categoly = self.categoly.text;
    memo = self.memo.text;
    self.startView.alpha = 0;
    //ストップボタンを表示
    self.stopView.alpha =1;


}


- (void)timer{
    secTime++;
    if(secTime == 60){
        minTime++;
        secTime = 0;
        if (minTime == 60) {
            hourTime++;
            minTime = 0;
        }
    }
    self.timeView.text = [NSString stringWithFormat:@"%02d:%02d:%02d",hourTime,minTime,secTime];
    time = self.timeView.text;
}

- (IBAction)timeStop:(id)sender {
    
    self.startView.alpha = 1;
    self.stopView.alpha =0;
    [tm invalidate];
    //テスト用
    NSLog(@"%@",title);
    NSLog(@"%@",categoly);
    NSLog(@"%@",memo);
    NSLog(@"string:%@",time);
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
}

@end
