//
//  Task.h
//  TaskListProject
//
//  Created by Eliot Arntz on 6/20/13.
//  Copyright (c) 2013 self.edu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Task : NSManagedObject

@property (nonatomic) BOOL isCompleted;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) id photo;
@property (nonatomic) int32_t indexNumber;

@end
