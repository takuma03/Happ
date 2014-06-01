//
//  MainViewController.h
//  Happ_viewChange_test1
//
//  Created by tkm03 on 2014/06/01.
//  Copyright (c) 2014年 tkm03. All rights reserved.
//

#import "FlipsideViewController.h"

@interface MainViewController : UIViewController <FlipsideViewControllerDelegate>{
    NSString *dispStr;
}
@property (weak, nonatomic) IBOutlet UILabel *myLabel;

@end
