//
//  CalcButton.m
//  fx
//
//  Created by Songge Chen on 4/14/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "CalcButton.h"

@implementation CalcButton
-(id) initWithFrame:(CGRect)frame stringRep:(NSString *) stringrep title:(NSMutableAttributedString *) title{
    self = [super initWithFrame:frame];
    if (self) {
        _stringRepresentation = stringrep;
    }
    
    NSMutableAttributedString * hlTitle = [title mutableCopy];
    if ([stringrep isEqualToString:@"X"]) {
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.824f green:0.154f blue:0.12f alpha:1.0f]   range:NSMakeRange(0, title.length)];
        
        
        [hlTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.524f green:0.314f blue:0.22f alpha:1.0f]  range:NSMakeRange(0, title.length)];
    } else {
        [title addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.074f green:0.154f blue:0.32f alpha:1.0f]   range:NSMakeRange(0, title.length)];


        [hlTitle addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed:0.224f green:0.414f blue:0.62f alpha:1.0f]  range:NSMakeRange(0, title.length)];
    }
    [self setAttributedTitle:title forState:UIControlStateNormal];
    [self setAttributedTitle:hlTitle forState:UIControlStateHighlighted];
    

    return self;
}
@end
