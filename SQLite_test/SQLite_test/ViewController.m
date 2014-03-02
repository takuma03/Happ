//
//  ViewController.m
//  SQLite_test
//
//  Created by tkm03 on 2014/03/01.
//  Copyright (c) 2014年 tkm03. All rights reserved.
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
    NSString *dataFileName = @"unkolist.sqlite3";
    NSString *dataFileFullPath;
    
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
    query = @"CREATE TABLE IF NOT EXISTS unkos (name TEXT)";
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    
    // INSERT
    NSString *name = [NSString stringWithFormat:@"%@%d",@"otiai",arc4random() % 99];
    query = [NSString stringWithFormat:@"INSERT INTO unkos VALUES(\"%@\")", name];
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    // SELECT
    query = @"SELECT name FROM unkos";
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    while (sqlite3_step(statement) == SQLITE_ROW) {
        char *ownerNameChars = (char *) sqlite3_column_text(statement,0);
        NSLog(@"Found : %s", ownerNameChars);
    }
    sqlite3_finalize(statement);
    
    // 5.【sqlite閉じる】
    sqlite3_close(sqlax);
    
    // }}} ここまで書いた
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
