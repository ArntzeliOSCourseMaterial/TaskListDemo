//
//  QCLoginViewController.h
//  TaskListProject
//
//  Created by Eliot Arntz on 6/20/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCViewController.h"
#import "User.h"

//step 1
@protocol QCLoginViewControllerDelegate <NSObject>

-(void)loginHasBeenCompleted;

@end

@interface QCLoginViewController : UIViewController <UITextFieldDelegate>

//step 2
@property (weak) id <QCLoginViewControllerDelegate> delegate;

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *confirmPasswordTextField;

- (IBAction)createAccountButtonPressed:(id)sender;

@end
