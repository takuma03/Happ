//
//  ViewController.m
//  Happ_csvCreate
//
//  Created by takuma on 2014/03/03.
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
    
    NSString *DB_path = @"/Users/takuma/Library/Application Support/iPhone Simulator/7.0.3/Applications/FBBF27B6-EC7D-4EAE-9E0B-495C436C5B7A/Documents/Happ.sqlite3";
    
    sqlite3 *sqlax;
    
    BOOL isSuccessfullyOpened = sqlite3_open([DB_path UTF8String], &sqlax);
    if (isSuccessfullyOpened != SQLITE_OK) {
        NSLog(@"sqlite開けませんでした！=> %s", sqlite3_errmsg(sqlax));
    }
    
    NSString *query;
    sqlite3_stmt *statement;
    
    query = @"select * from task";
    NSString *dataFileFullPath;
    NSString *dataFileName =@"test.csv";
    
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    while (sqlite3_step(statement) == SQLITE_ROW) {
        char *id = (char *) sqlite3_column_text(statement,0);
        //NSLog(@"Found : %s", id);
        char *category = (char *) sqlite3_column_text(statement,1);
        //NSLog(@"Found : %s", category);
        char *name = (char *) sqlite3_column_text(statement,2);
        //NSLog(@"Found : %s", name);
        char *memo = (char *) sqlite3_column_text(statement,3);
        //NSLog(@"Found : %s", memo);
        char *start = (char *) sqlite3_column_text(statement,4);
        //NSLog(@"Found : %s", start);
        char *stop = (char *) sqlite3_column_text(statement,5);
        //NSLog(@"Found : %s", stop);
        char *update = (char *) sqlite3_column_text(statement,6);
        //NSLog(@"Found : %s", update);
        NSLog(@"%s,%s,%s,%s,%s,%s,%s",id,category,name,memo,start,stop,update);
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *dir = [paths objectAtIndex:0];
        NSFileManager *myFM = [NSFileManager defaultManager];
        // 物理ファイルって既にありますか？
        dataFileFullPath = [dir stringByAppendingPathComponent:dataFileName];
        BOOL fileExists = [myFM fileExistsAtPath:dataFileFullPath];
        // 無い場合はつくる
        if (! fileExists) {
            BOOL isSuccessfullyCreated = [myFM createFileAtPath:dataFileFullPath contents:nil attributes:nil];
            if (! isSuccessfullyCreated) {
                NSLog(@"新規ファイル作成に失敗しました=>%@", dataFileFullPath);
            }
        }
        NSFileHandle *fileHandle = [NSFileHandle fileHandleForWritingAtPath:dataFileFullPath];
        if (!fileHandle) {
            NSLog(@"ファイルハンドルの作成に失敗");
            return;
        }
        NSString *writeLine = [NSString stringWithFormat:@"%s,%s,%s,%s,%s,%s,%s\n",id,category,name,memo,start,stop,update];
        NSData *data = [NSData dataWithBytes:writeLine.UTF8String length:writeLine.length];
        [fileHandle seekToEndOfFile];
        
        [fileHandle writeData:data];
        
    }
    sqlite3_finalize(statement);
    NSLog(@"%@",dataFileFullPath);

    sqlite3_close(sqlax);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
