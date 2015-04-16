//
//  CalcButton.m
//  fx
//
//  Created by Songge Chen on 4/14/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "CalcButton.h"

@implementation CalcButton
-(id) initWithFrame:(CGRect)frame stringRep:(NSString *) stringrep title:(NSString *) title{
    self = [super initWithFrame:frame];
    if (self) {
        _stringRepresentation = stringrep;
    }
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    [self setTitle:title forState:UIControlStateNormal];
    return self;
}
@end
