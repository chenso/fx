//
//  fxGame.h
//  fx
//
//  Created by Songge Chen on 4/16/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//
// class for game state and logic

#import <Foundation/Foundation.h>
#import "EquationParser.h"

enum difficulty {
    AMATEUR = 0,
    INTERMEDIATE = 1,
    EXPERT = 2
};

@interface fxGame : NSObject {
    
}
@property NSMutableArray * equation;
@property enum difficulty difficultyLevel;
@property NSDictionary * termValues;
@property (strong) EquationParser * ep;

-(id) initWithEquation:(NSMutableArray *) eq difficulty:(enum difficulty) difficultyLvl;
@end
