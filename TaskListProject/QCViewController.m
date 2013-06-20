//
//  QCViewController.m
//  TaskListProject
//
//  Created by Eliot Arntz on 6/19/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import "QCViewController.h"
#import "QCCustomTableViewCell.h"


@interface QCViewController ()

@end

@implementation QCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    int x = 10;
    int y = x;
    NSLog(@"%i", y);
    
    
    self.tasksTableView.delegate = self;
    self.tasksTableView.dataSource = self;
    self.taskTextField.delegate = self;
    
    self.isTableViewInEditingMode = NO;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    self.tasks = [[NSMutableArray alloc] initWithArray:[Task findAllSortedBy:@"indexNumber" ascending:YES]];
    [self.tasksTableView reloadData];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tasksTableView setEditing:editing animated:YES];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)addTaskButtonPressed:(UIButton *)sender
{
    
    if ([self.taskTextField.text isEqualToString: @""])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"You didn't enter anything!" delegate:self cancelButtonTitle:@"Ok I promise to enter something" otherButtonTitles: nil];
        [alertView show];
    }
    else {
        Task *task = [Task createEntity];
        task.name = self.taskTextField.text;
        task.isCompleted = NO;
        task.indexNumber = self.tasks.count;        
        
        NSArray *users = [User findAll];
        
        NSUserDefaults *standardDefaults = [NSUserDefaults standardUserDefaults];
        NSString *emailOfSignedInUser = [standardDefaults objectForKey:@"email"];
        
        User *currentUser;
        for (int x = 0; x < users.count; x ++ ){
            User *user = [users objectAtIndex:x];
            if ([user.email isEqualToString:emailOfSignedInUser]){
                currentUser = user;
            }
        }
        
        
        task.user = currentUser;
        
        NSLog(@"%@", task.user);
        
        
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        
        [self.tasks addObject:task];
        [self.tasksTableView reloadData];
        [self.taskTextField resignFirstResponder];
    }
}

#pragma mark - UITableViewDataSource
//required
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    QCCustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"QCCustomTableViewCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    Task *task = [self.tasks objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = task.name;
    if (task.photo){
        cell.photo.image = task.photo;
    }
    else {
        cell.photo.image = [UIImage imageNamed:@"mario.jpeg"];
    }
    
    if (task.isCompleted == YES){
        cell.titleLabel.textColor = [UIColor greenColor];
    }
    else {
        cell.titleLabel.textColor = [UIColor redColor];
    }
    
    return cell;
}

//required
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}


#pragma mark - UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.taskTextField resignFirstResponder];
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Task *task = [self.tasks objectAtIndex:indexPath.row];
    
    QCDetailViewController *detailVC = [[QCDetailViewController alloc] initWithNibName:nil bundle:nil];
    detailVC.taskToBePassed = task;
    [self presentViewController:detailVC animated:YES completion:nil];
}


- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    
    //update my tasks array.
    Task *task = [self.tasks objectAtIndex:sourceIndexPath.row];
    [self.tasks removeObjectAtIndex:sourceIndexPath.row];
    [self.tasks insertObject:task atIndex:destinationIndexPath.row];
        
    for (int y = 0; y < self.tasks.count; y ++){
        Task *task = [self.tasks objectAtIndex:y];
        task.indexNumber = y;
    }
    
    [[NSManagedObjectContext contextForCurrentThread] saveToPersistentStoreAndWait];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        Task *task = [self.tasks objectAtIndex:indexPath.row];
        [task deleteEntity];
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
        
        [self.tasks removeObjectAtIndex:indexPath.row];
        [self.tasksTableView reloadData];
        [self.tasksTableView setEditing:NO animated:NO];
    }
}

@end
