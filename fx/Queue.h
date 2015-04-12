//
//  Queue.h
//  fx
//
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Queue : NSObject {
    NSMutableArray * _queue;
}

-(void) enqueue: (NSObject *) obj;
-(NSObject * ) dequeue;
-(NSObject *) peek;
-(BOOL) isEmpty;
-(void) clear;
-(void) print;
@end
