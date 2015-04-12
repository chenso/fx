//
//  Queue.m
//  fx
//
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "Queue.h"

@implementation Queue

-(id) init {
    self = [super init];
    _queue = [NSMutableArray array]; // if performance problems switch to initWithCapacity
    return self;
}

-(void) enqueue:(NSObject *)obj {
    [_queue addObject:obj];
}

-(NSObject *) dequeue {
    NSObject * obj = [_queue firstObject];
    [_queue removeObjectAtIndex:0];
    return obj;
}

-(NSObject *) peek {
    return [_queue firstObject];
}
-(BOOL) isEmpty {
    return [_queue count] == 0;
}
-(void) clear {
    [_queue removeAllObjects];
}

-(void) print {
    for (NSString * string in _queue) {
        NSLog(@"%@", string);
    }
}

@end
