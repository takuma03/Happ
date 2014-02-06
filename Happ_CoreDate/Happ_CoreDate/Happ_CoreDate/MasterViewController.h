//
//  MasterViewController.h
//  Happ_CoreDate
//
//  Created by takuma on 2014/02/06.
//  Copyright (c) 2014年 卓馬. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface MasterViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
