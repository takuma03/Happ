//
//  AppDelegate.h
//  Happ_viewChange_test5
//
//  Created by tkm03 on 2014/06/21.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
        NSString *name;
}

//成功するパターン
//@property (atomic, strong) NSString *name;
@property (nonatomic)NSString *name;

//失敗するパターン
//@property (nonatomic,assign)NSString *name;



@property (strong, nonatomic) UIWindow *window;

@end
