//
//  GraphView.m
//  fx
//
//  Created by Songge Chen on 4/9/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "GraphView.h"

@implementation GraphView

-(id) init {
    self = [super init];
    self.frame = CGRectMake(0, 0, SIDE, SIDE);
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    // Draw Axis
    CGContextSetLineWidth(context, 5.0);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.0].CGColor);
    CGContextMoveToPoint(context, SIDE / 2, 0);
    CGContextAddLineToPoint(context, SIDE / 2, SIDE);
    CGContextMoveToPoint(context, 0, SIDE / 2);
    CGContextAddLineToPoint(context, SIDE, SIDE / 2);
    CGContextStrokePath(context);
    
    // Draw lines per unit and UILabels
    CGContextSetStrokeColorWithColor(context, [UIColor grayColor].CGColor);
    CGContextSetLineWidth(context, 2.25);
    for (int i = 0; i * PIXELS_PER_UNIT <= SIDE; i++) {
        CGContextMoveToPoint(context, i * PIXELS_PER_UNIT, 0);
        CGContextAddLineToPoint(context, i * PIXELS_PER_UNIT, SIDE);
        CGContextMoveToPoint(context, 0, i * PIXELS_PER_UNIT);
        CGContextAddLineToPoint(context, SIDE, i * PIXELS_PER_UNIT);
        UILabel *intLabelX = [[UILabel alloc] initWithFrame:CGRectMake(i * PIXELS_PER_UNIT - 15, SIDE / 2 + SIDE / 500, 60, 60)];
        [intLabelX setText:[[NSNumber numberWithInt:i - SIDE / (PIXELS_PER_UNIT * 2)] stringValue]];
        [intLabelX setFont:[UIFont systemFontOfSize:48]];
        if (i == SIDE / (PIXELS_PER_UNIT * 2)) {
            [intLabelX setBackgroundColor:[UIColor whiteColor]];
        }
        [self addSubview:intLabelX];
        if (i != SIDE / (PIXELS_PER_UNIT * 2)) {
        UILabel * intLabelY = [[UILabel alloc] initWithFrame:CGRectMake(SIDE / 2 - SIDE / 35, i * PIXELS_PER_UNIT - 30, 60, 60)];
            [intLabelY setTextAlignment:NSTextAlignmentCenter];
        [intLabelY setFont:[UIFont systemFontOfSize:48]];
        [intLabelY setText:[[NSNumber numberWithInt:i - SIDE / (PIXELS_PER_UNIT * 2)]stringValue]];
        [intLabelY setBackgroundColor:[UIColor whiteColor]];
        [self addSubview:intLabelY];
        }
        
        
    }
    CGContextStrokePath(context);
    // Draw two tenth lines
    CGContextSetLineWidth(context, 0.25);
    for (int i = 0; i * PIXELS_PER_UNIT / 5 <= SIDE; i++) {
        CGContextMoveToPoint(context, i* PIXELS_PER_UNIT / 5, 0);
        CGContextAddLineToPoint(context, i*PIXELS_PER_UNIT / 5, SIDE);
        
        CGContextMoveToPoint(context, 0, i * PIXELS_PER_UNIT / 5);
        CGContextAddLineToPoint(context, SIDE, i * PIXELS_PER_UNIT / 5);
    }
    CGContextStrokePath(context);
    
    // Draw marker bumps
    CGContextSetLineWidth(context, 3.5);
    for (int i = 0; i * PIXELS_PER_UNIT / 5 <= SIDE; i++) {
        CGContextMoveToPoint(context, i * PIXELS_PER_UNIT / 5, SIDE / 2);
        CGContextAddLineToPoint(context, i * PIXELS_PER_UNIT / 5, SIDE / 2 - SIDE / 200);
        
        CGContextMoveToPoint(context, SIDE / 2 - SIDE / 300, i * PIXELS_PER_UNIT / 5);
        CGContextAddLineToPoint(context, SIDE/2 + SIDE / 300, i*PIXELS_PER_UNIT / 5);
    }
    CGContextStrokePath(context);
    // draw curve
    if (_graphPoints) {
        CGContextSetLineWidth(context, 3);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        for (int i = 0; i < SIDE - 1; i++) {
            if (!isnan([[_graphPoints objectAtIndex:i] floatValue]) && !isnan([[_graphPoints objectAtIndex:i + 1] floatValue])) {
                CGContextMoveToPoint(context, i, SIDE / 2.0 - [(NSNumber *) [_graphPoints objectAtIndex:i] floatValue] * PIXELS_PER_UNIT);
                CGContextAddLineToPoint(context, i + 1, SIDE / 2.0 - [(NSNumber *) [_graphPoints objectAtIndex:i + 1] floatValue] * PIXELS_PER_UNIT);
            }
        }
        CGContextStrokePath(context);
    }
}

-(void) setGraphPoints:(NSArray *) graphPoints {
    _graphPoints = graphPoints;
}

@end
