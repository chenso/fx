//
//  Stack.h
//  fx
//
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//
#ifndef _STACK_H_
#define _STACK_H_

#import <Foundation/Foundation.h>

@interface Stack : NSObject {
    NSMutableArray * _stack;
}

- (NSUInteger) count;
- (BOOL) isEmpty;
- (NSObject *) pop;
- (void) push:(NSObject *)item;
- (NSObject *) peek;
- (void) clear;
- (void) print;
@end

#endif