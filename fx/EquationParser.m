//
//  EquationParser.m
//  fx
//
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "EquationParser.h"

#define OPEN_BRACKET_PRECEDENCE 10
@implementation EquationParser


-(void) initPrecedenceDict {
    NSArray * operators = [NSArray arrayWithObjects:
                           @"+",
                           @"-",
                           @"/",
                           @"*",
                           @"^",
                           @"(",
                           @"SQRT",
                           @"SIN",
                           @"COS",
                           @"TAN",
                           @"ARCSIN",
                           @"ARCCOS",
                           @"ARCTAN",
                           @"LN",
                           @"E_POW",
                           nil];
    
    NSArray * precedences = [NSArray arrayWithObjects:
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:1],
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:2],
                             [NSNumber numberWithInt:3],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             [NSNumber numberWithInt:OPEN_BRACKET_PRECEDENCE],
                             nil];
    
    _op_precedence = [NSDictionary dictionaryWithObject:operators forKey:precedences];
}


@end
