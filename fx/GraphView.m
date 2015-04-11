//
//  GraphView.m
//  fx
//
//  Created by Songge Chen on 4/9/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "GraphView.h"
enum gridUnitPixels {
    quarterUnit = 5,
    halfUnit = 10,
    unit = 20,
    fiveUnit = 100
};
@implementation GraphView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    NSMutableArray * graphArray = [[NSMutableArray alloc] initWithCapacity:100];
    for (int i = 0; i < 100; i++) {
        [graphArray addObject:[NSNumber numberWithFloat:i*i]];
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextMoveToPoint(context, 0, 0);
    for (int i = 1; i < 180; i++) {
        CGContextAddLineToPoint(context, i,  100 + 100 *sin(i/5.0) );
    }
    
    CGContextStrokePath(context);
}


@end
