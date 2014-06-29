//
//  AppDelegate.m
//  Happ_viewChange
//
//  Created by tkm03 on 2014/06/08.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "AppDelegate.h"
#import "sqlite3.h"

@implementation AppDelegate
@synthesize sns_id;
@synthesize sns_info;
@synthesize sns_access_token;
@synthesize dataFileFullPath;
@synthesize dataFileName;
@synthesize sns_name;
@synthesize user_id;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    //変数初期化
    sns_id = nil;
    sns_info = nil;
    sns_access_token =nil;
    
    
    //DB作成
    dataFileName = @"Happ.sqlite3";
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
    //NSLog(@"DBfile is %@",dataFileFullPath);
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
    NSLog(@"%@",dataFileFullPath);
    
    
    // 3.【queryとstatementを確保しとこう】
    NSString *query;
    sqlite3_stmt *statement;
    
    query = @"CREATE TABLE IF NOT EXISTS users(id integer primary key autoincrement, sns_id text, name text, sns_access_token text, created text, modified timestamp)";
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    sqlite3_step(statement);
    sqlite3_finalize(statement);
    
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end


