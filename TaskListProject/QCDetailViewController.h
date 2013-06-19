//
//  QCDetailViewController.h
//  TaskListProject
//
//  Created by Eliot Arntz on 6/19/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface QCDetailViewController : UIViewController

@property (strong, nonatomic) Task *taskToBePassed;
@property (strong, nonatomic) IBOutlet UILabel *informationLabel;

- (IBAction)backButtonPressed:(id)sender;

@end
