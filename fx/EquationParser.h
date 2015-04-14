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
    Queue * _RPNStack;
    
    Stack * _output;
    
    NSDictionary * _op_precedence;
    NSDictionary * _op_assoc;
    NSArray * _valid_functions;
    NSArray * _vaid_operators;
}

-(NSNumber *) parseEquationStringArray:(NSArray *) equationString forX:(NSNumber *) x;
@end
