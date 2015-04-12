//
//  EquationParser.h
//  fx
//  Reads a string and outputs a double based on the x value given
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"
#import "Queue.h"

@interface EquationParser : NSObject {
    Stack * _operators;
    Queue * _output;
    
    Stack * _readRPNStack;
    NSDictionary * _op_precedence;
    NSDictionary * _op_assoc;
    NSArray * _valid_functions;
    NSArray * _vaid_operators;
}

-(NSNumber *) parseString:(NSArray *) equationString forX:(NSNumber *) x;
@end
