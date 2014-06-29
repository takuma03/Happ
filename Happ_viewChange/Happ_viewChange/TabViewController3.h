//
//  TabViewController3.h
//  Happ_viewChange
//
//  Created by tkm03 on 2014/06/29.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TabViewController3 : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *timeView;
@property (weak, nonatomic) IBOutlet UIButton *startView;
- (IBAction)timeStart:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *stopView;
- (IBAction)timeStop:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *kenmei;
@property (weak, nonatomic) IBOutlet UITextField *category;
@property (weak, nonatomic) IBOutlet UITextField *memo;
- (IBAction)dataPreserve:(id)sender;



@end
