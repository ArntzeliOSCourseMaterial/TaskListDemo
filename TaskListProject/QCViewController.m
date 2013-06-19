//
//  QCViewController.m
//  TaskListProject
//
//  Created by Eliot Arntz on 6/19/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import "QCViewController.h"

@interface QCViewController ()

@end

@implementation QCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
        
    self.tasksTableView.delegate = self;
    self.tasksTableView.dataSource = self;
    self.taskTextField.delegate = self;
    
    self.isTableViewInEditingMode = NO;
    
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewDidAppear:(BOOL)animated
{
    NSLog(@"viewDidAppear %@", [Task findAll]);
    self.tasks = [[NSMutableArray alloc] initWithArray:[Task findAll]];
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
    
    
    Task *task = [Task createEntity];
    task.name = self.taskTextField.text;
    task.isCompleted = NO;
    
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];

    [self.tasks addObject:task];
    [self.tasksTableView reloadData];
    [self.taskTextField resignFirstResponder];
}

#pragma mark - UITableViewDataSource
//required
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];

    Task *task = [self.tasks objectAtIndex:indexPath.row];
    
    tableViewCell.textLabel.text = task.name;
    
    if (task.isCompleted == YES){
        
    }
    
    return tableViewCell;
}
//required
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tasks.count;
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
