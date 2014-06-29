//
//  TabViewController1.m
//  Happ_viewChange
//
//  Created by tkm03 on 2014/06/22.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "TabViewController1.h"
#import "AppDelegate.h"
#import "sqlite3.h"

@interface TabViewController1 ()

@end

@implementation TabViewController1

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
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //self.myLabel.text = appDelegate.sns_info;
    
    
    //ユーザー情報が登録済みかどうか確認
    NSArray *sns_info = [appDelegate.sns_info componentsSeparatedByString:@","];
    NSString *sns_id = [sns_info objectAtIndex:0];
    NSLog(@"%@",sns_id);
    
    sqlite3 *sqlax;
    
    BOOL isSuccessfullyOpened = sqlite3_open([appDelegate.dataFileFullPath UTF8String], &sqlax);
    
    if (isSuccessfullyOpened != SQLITE_OK) {
        NSLog(@"sqlite開けませんでした！=> %s", sqlite3_errmsg(sqlax));
    }
    
    NSString *query;
    sqlite3_stmt *statement;
    
    query = [NSString stringWithFormat:@"SELECT * FROM users WHERE %@ LIMIT 1",sns_id];
    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    
    //もしユーザー情報が登録されていなかった場合登録する
    //本来は登録されていない場合、登録画面へ遷移する
    if (sqlite3_step(statement) != SQLITE_ROW){
        //ユーザー情報の登録
        // 開きます
        BOOL isSuccessfullyOpened = sqlite3_open([appDelegate.dataFileFullPath UTF8String], &sqlax);
        if (isSuccessfullyOpened != SQLITE_OK) {
            NSLog(@"sqlite開けませんでした！=> %s", sqlite3_errmsg(sqlax));
        }
        // 3.【queryとstatementを確保しとこう】
        NSString *query;
        sqlite3_stmt *statement;
        //query = [NSString stringWithFormat:@"INSERT INTO users VALUES(NULL,\"aaa\",\"aaa\",\"aaa\",datetime('now','localtime'),datetime('now','localtime'))"];
        query = [NSString stringWithFormat:@"INSERT INTO users VALUES(NULL,%@,datetime('now','localtime'),datetime('now','localtime'))",appDelegate.sns_info];
        //NSLog(@"%@",query);
        sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
        sqlite3_step(statement);
        sqlite3_finalize(statement);
    }else{
        char *name = (char *) sqlite3_column_text(statement,2);
        appDelegate.sns_name = [NSString stringWithCString: name encoding:NSUTF8StringEncoding];
        
        char *id = (char *) sqlite3_column_text(statement,0);
        appDelegate.user_id = [NSString stringWithCString: id encoding:NSUTF8StringEncoding];
    
    }
    self.myLabel.text = appDelegate.sns_name;
    
    sqlite3_finalize(statement);
    
    
    
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
