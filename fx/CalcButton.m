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
    [self setTitleColor:[UIColor colorWithRed:0.024f green:0.114f blue:0.22f alpha:1.0f] forState:UIControlStateNormal];
    [self setTitleColor:[UIColor colorWithRed:0.24f green:0.34f blue:0.52f alpha:1.0f] forState:UIControlStateHighlighted];
    [self setTitle:title forState:UIControlStateNormal];
    return self;
}
@end
