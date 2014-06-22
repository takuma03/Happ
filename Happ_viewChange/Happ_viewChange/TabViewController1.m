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
    //self.myLabel.text = appDelegate.name;
    
    sqlite3 *sqlax;
    // 開きます
    BOOL isSuccessfullyOpened = sqlite3_open([appDelegate.dataFileFullPath UTF8String], &sqlax);
    if (isSuccessfullyOpened != SQLITE_OK) {
        NSLog(@"sqlite開けませんでした！=> %s", sqlite3_errmsg(sqlax));
    }
    
    // 3.【queryとstatementを確保しとこう】
    NSString *query;
    sqlite3_stmt *statement;
    //query = [NSString stringWithFormat:@"INSERT INTO users VALUES(NULL,\"aaa\",\"aaa\",\"aaa\",datetime('now','localtime'),datetime('now','localtime'))"];
    query = [NSString stringWithFormat:@"INSERT INTO users VALUES(NULL,%@,datetime('now','localtime'),datetime('now','localtime'))",appDelegate.name];
    
    //NSLog(@"%@",query);

    sqlite3_prepare_v2(sqlax, [query UTF8String], -1, &statement, nil);
    sqlite3_step(statement);
    sqlite3_finalize(statement);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
