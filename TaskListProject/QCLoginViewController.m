//
//  QCLoginViewController.m
//  TaskListProject
//
//  Created by Eliot Arntz on 6/20/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import "QCLoginViewController.h"

@interface QCLoginViewController ()

@end

@implementation QCLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.emailTextField.delegate = self;
    self.passwordTextField.delegate = self;
    self.confirmPasswordTextField.delegate = self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.emailTextField resignFirstResponder];
    [self.passwordTextField resignFirstResponder];
    [self.confirmPasswordTextField resignFirstResponder];
    
    return YES;
}


- (IBAction)createAccountButtonPressed:(id)sender
{
    if ([self.emailTextField.text isEqualToString:@""]){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please add an Email" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
    }
    else if (self.passwordTextField.text.length < 3){
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Please make your password greater then 3 characters" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
    }
    
    else if ([self.passwordTextField.text isEqualToString:self.confirmPasswordTextField.text]){
        
        //writing to core data
        User *user = [User createEntity];
        user.email = self.emailTextField.text;
        user.password = self.passwordTextField.text;
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        
        //saving to NSUserDefaults
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        [standardDefaults setObject:self.emailTextField.text forKey:@"email"];
        [standardDefaults setBool:YES forKey:@"isUserSignedIn"];
        [standardDefaults synchronize];
        
        [self dismissViewControllerAnimated:YES completion:nil];
        //step 3
        [self.delegate loginHasBeenCompleted];
    }
    else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Some error has occured!" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles: nil];
        [alertView show];
    }
    
}
@end
