//
//  TabViewController3.m
//  Happ_viewChange
//
//  Created by tkm03 on 2014/06/29.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "TabViewController3.h"
#import "AppDelegate.h"

@interface TabViewController3 ()

@end

@implementation TabViewController3

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
    self.stopView.alpha = 0;
    [self.kenmei setDelegate:self];
    [self.category setDelegate:self];
    [self.memo setDelegate:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)timeStop:(id)sender {
    self.startView.alpha = 1;
    self.stopView.alpha =0;
    [tm invalidate];
    //テスト用
    //NSLog(@"%@",title);
    //NSLog(@"%@",categoly);
    //NSLog(@"%@",memo);
    //NSLog(@"string:%@",time);
    
    stop_time = [self timeGet];
}

- (IBAction)dataPreserve:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    // 2.【sqiteを開く】
    
    // FIXME: この書き方だとメモリリークする？
    //sqlite3という型のポインタを作成している部分
    sqlite3 *sqlax;
    // 開きます
    BOOL isSuccessfullyOpened = sqlite3_open([appDelegate.dataFileFullPath UTF8String], &sqlax);
    if (isSuccessfullyOpened != SQLITE_OK) {
        //NSLog(@"sqlite開けませんでした！=> %s", sqlite3_errmsg(sqlax));
    }
    
    // 3.【queryとstatementを確保しとこう】
    NSString *query;
    sqlite3_stmt *statement;
    
    // 4.【sql文を実行していく】
    
    NSString *sql_category = [NSString stringWithFormat:@"%@",category];
    NSString *sql_task_name = [NSString stringWithFormat:@"%@",title];
    NSString *sql_memo = [NSString stringWithFormat:@"%@",memo];
    NSString *sql_sync_flag = [NSString stringWithFormat:@"%s","0"];
    NSString *sql_start_time = [NSString stringWithFormat:@"%@",start_time];
    NSString *sql_stop_time = [NSString stringWithFormat:@"%@",stop_time];
    NSString *sql_update_time = [self timeGet];
    
    
    query = [NSString stringWithFormat:@"INSERT INTO task VALUES(NULL,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", sql_category,sql_task_name,sql_memo,sql_start_time,sql_stop_time,sql_update_time,sql_sync_flag];
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    
    
}

- (IBAction)dataSync:(id)sender {
}

- (IBAction)timeStart:(id)sender {
    tm = [NSTimer scheduledTimerWithTimeInterval:1.00 target:self selector:@selector(timer) userInfo:nil repeats:YES];
    //スタートボタンを非表示
    title = self.kenmei.text;
    category = self.category.text;
    memo = self.memo.text;
    self.startView.alpha = 0;
    
    //ストップボタンを表示
    self.stopView.alpha =1;
    
    start_time = [self timeGet];
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

- (NSString *)timeGet{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ja_JP"]]; // Localeの指定
    [df setDateFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    NSDate *now = [NSDate date];
    NSString *strNow = [df stringFromDate:now];
    
    // ログ出力
    NSLog(@"現在日時：%@", strNow);
    
    return strNow;
}


@end
