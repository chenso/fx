//
//  Stack.m
//  fx
//
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "Stack.h"

@implementation Stack

-(id) init {
    self = [super init];
    _stack = [NSMutableArray array];
    return self;
}

-(NSUInteger) count {
    return [_stack count];
}

-(id) objectAtIndex:(NSUInteger) index {
    return [_stack objectAtIndex:index];
}

- (BOOL) isEmpty {
    return [_stack count] == 0;
}

- (NSObject *) pop {
    if ([self isEmpty]) return nil;
    
    NSObject * obj = [_stack lastObject];
    [_stack removeLastObject];
    return obj;
}

- (void) push:(NSObject *) obj {
    [_stack addObject:obj];
}

-(NSObject *) peek {
    return [_stack lastObject];
}

-(void) clear {
    [_stack removeAllObjects];
}
@end
