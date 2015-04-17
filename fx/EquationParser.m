//
//  EquationParser.m
//  fx
//
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "EquationParser.h"

const static double insufficientValuesError = 12.3456;

enum rankings {
    OPEN_BRACKET_PRECEDENCE = 10,
    LEFT_ASSOC = 99,
    RIGHT_ASSOC = 98,
    NONE_ASSOC = 97
};

@implementation EquationParser

-(id) init {
    self = [super init];
    _operators = [[Stack alloc] init];
    _RPNStack = [[Queue alloc] init];
    _output = [[Stack alloc] init];
    
    [self initPrecedenceDict];
    [self initAssocDict];
    [self initOperators];
    [self initFunctions];
    return self;
}


-(NSNumber *) parseEquationStringArray:(NSArray *) equation forX:(NSNumber *) x {
    
    // Shunting Yard
    for (NSString * str in equation) {
        if ([str isEqualToString:@"X"] || [str doubleValue] != 0) {
            [_RPNStack enqueue:str];
        }
        else if ([self isFunction:str]) {
            [_operators push:str];
        } else if ([self isOperator:str]) {
            /* while there is an operator token, o2, at the top of the operator stack, and o1 its precedence is less than or equal to that of o2 */
            while ((![_operators isEmpty] && ([[_op_assoc objectForKey:str] intValue] == LEFT_ASSOC && [_op_precedence objectForKey:str] <= [_op_precedence objectForKey:[_operators peek]])) || ([[_op_assoc objectForKey:str]intValue] == RIGHT_ASSOC && [_op_precedence objectForKey:str] < [_op_precedence objectForKey:[_operators peek]])) {
                NSString * op = (NSString *) [_operators pop];
                [_RPNStack enqueue:op];
                
            }
            [_operators push:str];
        } else if ([str isEqualToString:@"("]) {
            [_operators push:str];
        } else if ([str isEqualToString:@")"]) {
            while (![(NSString * )[_operators peek] isEqualToString:@"("]) {
                if ([_operators isEmpty]) {
                    NSLog(@"Parenthesis mismatch");
                }
                NSString * op = (NSString *)[_operators pop];
                [_RPNStack enqueue:op];
                
            }
            [_operators pop];
            if (![_operators isEmpty] && [self isFunction:(NSString *)[_operators peek] ]) {
                [_RPNStack enqueue:(NSString *)[_operators pop]];
            }
        }
    }
    
    while (![_operators isEmpty]) {
        [_RPNStack enqueue:[_operators pop]];
    }
    
    // Read RPN output
    while (![_RPNStack isEmpty]) {
        NSString * elt = (NSString *)[_RPNStack dequeue];

        if ([elt isEqual:@"X"]) {
            [_output push:x];
        } else if ([elt doubleValue] != 0) {
            [_output push:[NSNumber numberWithDouble:[elt doubleValue] ]];
        } else if ([self isFunction:elt] || [self isOperator:elt]) {
            if ([elt isEqualToString:@"+"]) {
                if ([_output count] < 2) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * termTwo = (NSNumber *) [_output pop];
                NSNumber * sum = [NSNumber numberWithFloat:([termOne floatValue] + [termTwo floatValue])];
                [_output push:sum];
            } else if ([elt isEqualToString:@"-"]) {
                if ([_output count] < 2) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * termTwo = (NSNumber *) [_output pop];
                NSNumber * diff = [NSNumber numberWithFloat:([termTwo floatValue] - [termOne floatValue])];
                [_output push:diff];
            } else if ([elt isEqualToString:@"*"]) {
                if ([_output count] < 2) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * termTwo = (NSNumber *) [_output pop];
                NSNumber * mult = [NSNumber numberWithFloat:([termTwo floatValue] * [termOne floatValue])];
                [_output push:mult];
            } else if ([elt isEqualToString:@"/"]) {
                if ([_output count] < 2) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * termTwo = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:([termTwo floatValue] / [termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"^2"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:pow([termOne floatValue], 2)];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"^3"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:pow([termOne floatValue], 3)];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"SQRT"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:sqrt([termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"COS"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:cos([termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"SIN"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:sin([termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"TAN"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:tan([termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"ARCSIN"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:asin([termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"ARCCOS"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:acos([termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"ARCTAN"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:atan([termOne floatValue])];
                [_output push:div];
            }
            else if ([elt isEqualToString:@"LN"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:log([termOne floatValue])];
                [_output push:div];
            } else if ([elt isEqualToString:@"E"]) {
                if ([_output count] < 1) {
                    NSLog(@"Insufficient values");
                    return [NSNumber numberWithDouble:insufficientValuesError];
                }
                NSNumber * termOne = (NSNumber *) [_output pop];
                NSNumber * div = [NSNumber numberWithFloat:pow(M_E, [termOne floatValue])];
                [_output push:div];
            }
        }
    }
    if ([_output count] == 1) return (NSNumber *)[_output pop];
    else {
        [_output clear];
        [_RPNStack clear];
        [_operators clear];
        NSLog(@"Too many values in readRPNStack");
        return [NSNumber numberWithFloat:12.345];
    }
}



-(void) initOperators {
    _vaid_operators = @[@"+", @"-", @"/", @"*" , @"^2", @"^3"];
}

-(void) initFunctions {
    _valid_functions = @[@"SQRT", @"CBRT", @"SIN", @"COS", @"ARCSIN", @"ARCCOS", @"LN", @"E"];
}

-(void) initAssocDict {
    _op_assoc = @{
                  @"+" : [NSNumber numberWithInt:LEFT_ASSOC],
                  @"-": [NSNumber numberWithInt:LEFT_ASSOC],
                  @"/": [NSNumber numberWithInt:LEFT_ASSOC],
                  @"*" : [NSNumber numberWithInt:LEFT_ASSOC],
                  @"(" : [NSNumber numberWithInt:NONE_ASSOC],
                  @"^2" : [NSNumber numberWithInt:RIGHT_ASSOC],
                  @"^3" : [NSNumber numberWithInt:RIGHT_ASSOC],
                  @"SQRT" : [NSNumber numberWithInt:NONE_ASSOC],
                  @"CBRT" : [NSNumber numberWithInt:NONE_ASSOC],
                  @"SIN" : [NSNumber numberWithInt:NONE_ASSOC],
                  @"COS" : [NSNumber numberWithInt:NONE_ASSOC],
                  @"ARCSIN": [NSNumber numberWithInt:NONE_ASSOC],
                  @"ARCCOS" : [NSNumber numberWithInt:NONE_ASSOC],
                  @"LN" : [NSNumber numberWithInt:NONE_ASSOC],
                  @"E" : [NSNumber numberWithInt:NONE_ASSOC],
                  };
}

-(void) initPrecedenceDict {
    _op_precedence = @{
                       @"+"     : [NSNumber numberWithInt:1],
                       @"-"     : [NSNumber numberWithInt:1],
                       @"/"     : [NSNumber numberWithInt:2],
                       @"*"     : [NSNumber numberWithInt:2],
                       @"^2"    : [NSNumber numberWithInt:3],
                       @"^3"    : [NSNumber numberWithInt:3],
                       @"("     : [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"SQRT": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"CBRT": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"SIN": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"COS": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"ARCSIN": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"ARCCOS": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"LN": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       @"E": [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                       };
}

-(BOOL) isFunction:(NSString *) op {
    for (NSString * function in _valid_functions) {
        if ([op isEqualToString:function]) return true;
    }
    return false;
}

-(BOOL) isOperator: (NSString *) op {
    for (NSString * operator in _vaid_operators) {
        if ([op isEqualToString:operator]) return true;
    }
    return false;
}

-(void) printContainers {
    NSLog(@"Operators:");
    [_operators print];
    NSLog(@"Output:");
    [_RPNStack print];
    NSLog(@"AnswerStack:");
    [_output print];
}

@end
