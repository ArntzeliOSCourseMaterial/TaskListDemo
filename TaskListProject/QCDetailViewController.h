//
//  QCDetailViewController.h
//  TaskListProject
//
//  Created by Eliot Arntz on 6/19/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Task.h"

@interface QCDetailViewController : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) Task *taskToBePassed;
@property (strong, nonatomic) IBOutlet UILabel *informationLabel;
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;


- (IBAction)backButtonPressed:(id)sender;
- (IBAction)completeButtonPressed:(id)sender;
- (IBAction)updateButtonPressed:(id)sender;
- (IBAction)choosePhotoButtonPressed:(UIButton *)sender;

@end
