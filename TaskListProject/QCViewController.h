//
//  QCViewController.h
//  TaskListProject
//
//  Created by Eliot Arntz on 6/19/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCDetailViewController.h"
#import "Task.h"

@interface QCViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *taskTextField;
@property (strong, nonatomic) IBOutlet UITableView *tasksTableView;

@property (nonatomic) BOOL isTableViewInEditingMode;
@property (strong, nonatomic) NSMutableArray *tasks;

- (IBAction)editButtonPressed:(UIButton *)sender;
- (IBAction)addTaskButtonPressed:(UIButton *)sender;

@end
