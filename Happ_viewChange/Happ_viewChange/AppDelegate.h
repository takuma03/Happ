//
//  AppDelegate.h
//  Happ_viewChange
//
//  Created by tkm03 on 2014/06/08.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "sqlite3.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    NSString *sns_id;
    NSString *sns_info;
    NSString *sns_access_token;
    NSString *dataFileName;
    NSString *dataFileFullPath;
    NSString *sns_name;
    NSString *user_id;

}

@property (nonatomic)NSString *sns_id;
@property (nonatomic)NSString *sns_info;
@property (nonatomic)NSString *sns_access_token;
@property (nonatomic)NSString *dataFileName;
@property (nonatomic)NSString *dataFileFullPath;
@property (nonatomic)NSString *sns_name;
@property (nonatomic)NSString *user_id;


@property (strong, nonatomic) UIWindow *window;

@end
