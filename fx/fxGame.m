//
//  fxGame.m
//  fx
//
//  Created by Songge Chen on 4/16/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//


#import "fxGame.h"
const static int SEPERATOR_TOKEN_VALUE = 0;

@implementation fxGame
@synthesize equation = _equation;
@synthesize difficultyLevel = _difficultyLevel;
@synthesize termValues = _termValues;

-(id) initWithEquation:(NSMutableArray *) eq difficulty:(enum difficulty) difficultyLvl {
    self = [super init];
    if (self) {
        _equation = eq;
        _difficultyLevel = difficultyLvl;
        [self setUpTermValues];
    }
    return self;
}

-(void) setUpTermValues {
    _termValues = @{
                    @"X" : [NSNumber numberWithInt:1],
                    @"+" : [NSNumber numberWithInt:1],
                    @"-": [NSNumber numberWithInt:1],
                    @"/": [NSNumber numberWithInt:2],
                    @"*" : [NSNumber numberWithInt:2],
                    @"(" : [NSNumber numberWithInt:SEPERATOR_TOKEN_VALUE],
                    @")" : [NSNumber numberWithInt:SEPERATOR_TOKEN_VALUE],
                    @"^2" : [NSNumber numberWithInt:3],
                    @"^3" : [NSNumber numberWithInt:3],
                    @"SQRT" : [NSNumber numberWithInt:3],
                    @"CBRT" : [NSNumber numberWithInt:3],
                    @"SIN" : [NSNumber numberWithInt:3],
                    @"COS" : [NSNumber numberWithInt:3],
                    @"TAN" : [NSNumber numberWithInt:3],
                    @"ARCSIN": [NSNumber numberWithInt:3],
                    @"ARCCOS" : [NSNumber numberWithInt:3],
                    @"ARCTAN" : [NSNumber numberWithInt:3],
                    @"LN" : [NSNumber numberWithInt:3],
                    @"E" : [NSNumber numberWithInt:3],
                    };
}


@end
