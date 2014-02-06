//
//  DetailViewController.h
//  Happ_CoreDate
//
//  Created by takuma on 2014/02/06.
//  Copyright (c) 2014年 卓馬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
