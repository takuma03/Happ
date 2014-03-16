//
//  ViewController.m
//  Happ_timeMeasure
//
//  Created by takuma on 2014/02/04.
//  Copyright (c) 2014年 卓馬. All rights reserved.
//

#import "ViewController.h"
#import "sqlite3.h"

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

- (IBAction)timeStop:(id)sender {
    
    self.startView.alpha = 1;
    self.stopView.alpha =0;
    [tm invalidate];
    //テスト用
    NSLog(@"%@",title);
    NSLog(@"%@",categoly);
    NSLog(@"%@",memo);
    NSLog(@"string:%@",time);
    
    stop_time = [self timeGet];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)theTextField{
    [theTextField resignFirstResponder];
    return YES;
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








- (IBAction)dataPreserve:(id)sender {
    NSString *dataFileName = @"Happ.sqlite3";
    // 1.【物理ファイルを準備します】
    // 使用可能なファイルパスを全て取得する
    NSArray *availablePats = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 最初のものを使用する
    NSString *dir = [availablePats objectAtIndex:0];
    // ファイルマネージャを召還する
    NSFileManager *myFM = [NSFileManager defaultManager];
    // 物理ファイルって既にありますか？
    //stringByAppendingPathComponent データの末尾に追加する
    dataFileFullPath = [dir stringByAppendingPathComponent:dataFileName];
    NSLog(@"DBfile is %@",dataFileFullPath);
    BOOL fileExists = [myFM fileExistsAtPath:dataFileFullPath];
    // 無い場合はつくる
    if (! fileExists) {
        //createFileAtPathファイルを作成する
        BOOL isSuccessfullyCreated = [myFM createFileAtPath:dataFileFullPath contents:nil attributes:nil];
        if (! isSuccessfullyCreated) {
            NSLog(@"新規ファイル作成に失敗しました=>%@", dataFileFullPath);
        }
    }
    
    // 2.【sqiteを開く】
    
    // FIXME: この書き方だとメモリリークする？
    //sqlite3という型のポインタを作成している部分
    sqlite3 *sqlax;
    // 開きます
    BOOL isSuccessfullyOpened = sqlite3_open([dataFileFullPath UTF8String], &sqlax);
    if (isSuccessfullyOpened != SQLITE_OK) {
        NSLog(@"sqlite開けませんでした！=> %s", sqlite3_errmsg(sqlax));
    }
    
    // 3.【queryとstatementを確保しとこう】
    NSString *query;
    sqlite3_stmt *statement;
    
    // 4.【sql文を実行していく】
    
    // CREATE IF NOT EXISTS
    query = @"CREATE TABLE IF NOT EXISTS task(task_id integer primary key autoincrement, category text, task_name text, memo text, start_time text, stop_time text, update_time timestamp)";
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    
    // INSERT
    //NSString *name = [NSString stringWithFormat:@"%@%d",@"otiai",arc4random() % 99];
    
    NSString *sql_category = [NSString stringWithFormat:@"%@",categoly];
    NSString *sql_task_name = [NSString stringWithFormat:@"%@",title];
    NSString *sql_memo = [NSString stringWithFormat:@"%@",memo];
    NSString *sql_start_time = [NSString stringWithFormat:@"%@",start_time];
    NSString *sql_stop_time = [NSString stringWithFormat:@"%@",stop_time];
    NSString *sql_update_time = [self timeGet];
    
    
    NSLog(@"sql_update_time is %@",sql_update_time);

    query = [NSString stringWithFormat:@"INSERT INTO task VALUES(NULL,\"%@\",\"%@\",\"%@\",\"%@\",\"%@\",\"%@\")", sql_category,sql_task_name,sql_memo,sql_start_time,sql_stop_time,sql_update_time];
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    
}

- (IBAction)dataSync:(id)sender {
    NSLog(@"%@",dataFileFullPath);
    NSArray *availablePats = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    // 最初のものを使用する
    NSString *dir = [availablePats objectAtIndex:0];
    

    
    
    
}
@end
