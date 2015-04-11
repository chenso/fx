//
//  EquationParser.h
//  fx
//
//  Created by Songge Chen on 4/11/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Stack.h"

@interface EquationParser : NSObject {
    Stack * _operators;
    Stack * _output;
    NSDictionary * _op_precedence;
}
@end
