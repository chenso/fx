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
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.26 green:0.26 blue:0.26 alpha:1.0].CGColor);
    CGContextSetLineWidth(context, 4);
    for (int i = 0; i * PIXELS_PER_UNIT <= SIDE; i++) {
        CGContextMoveToPoint(context, i * PIXELS_PER_UNIT, SIDE / 2);
        CGContextAddLineToPoint(context, i * PIXELS_PER_UNIT, SIDE / 2 - PIXELS_PER_UNIT / 10);
        CGContextMoveToPoint(context, SIDE / 2 - PIXELS_PER_UNIT / 15, i * PIXELS_PER_UNIT);
        CGContextAddLineToPoint(context, SIDE / 2 + PIXELS_PER_UNIT / 15, i * PIXELS_PER_UNIT);
        UILabel *intLabelX = [[UILabel alloc] initWithFrame:CGRectMake(i * PIXELS_PER_UNIT - 15, SIDE / 2 + SIDE / 500, 80, 60)];
        [intLabelX setText:[[NSNumber numberWithInt:i - SIDE / (PIXELS_PER_UNIT * 2)] stringValue]];
        [intLabelX setFont:[UIFont systemFontOfSize:48]];
        if (i == SIDE / (PIXELS_PER_UNIT * 2)) {
            intLabelX.hidden = true;
        }
        [self addSubview:intLabelX];
        if (i != SIDE / (PIXELS_PER_UNIT * 2)) {
        UILabel * intLabelY = [[UILabel alloc] initWithFrame:CGRectMake(SIDE / 2 - 100, i * PIXELS_PER_UNIT - 30, 80, 60)];
            [intLabelY setTextAlignment:NSTextAlignmentLeft];
        [intLabelY setFont:[UIFont systemFontOfSize:48]];
        [intLabelY setText:[[NSNumber numberWithInt:i - SIDE / (PIXELS_PER_UNIT * 2)]stringValue]];
        [self addSubview:intLabelY];
        }
        
        
    }
    CGContextStrokePath(context);
    // Draw two tenth lines
    /*CGContextSetLineWidth(context, 0.25);
    for (int i = 0; i * PIXELS_PER_UNIT / 5 <= SIDE; i++) {
        CGContextMoveToPoint(context, i* PIXELS_PER_UNIT / 5, 0);
        CGContextAddLineToPoint(context, i*PIXELS_PER_UNIT / 5, SIDE);
        
        CGContextMoveToPoint(context, 0, i * PIXELS_PER_UNIT / 5);
        CGContextAddLineToPoint(context, SIDE, i * PIXELS_PER_UNIT / 5);
    }
    CGContextStrokePath(context);*/
    
    // Draw marker bumps
    CGContextSetLineWidth(context, 3.5);
    for (int i = 0; i * PIXELS_PER_UNIT / 5 <= SIDE; i++) {
        CGContextMoveToPoint(context, i * PIXELS_PER_UNIT / 5, SIDE / 2);
        CGContextAddLineToPoint(context, i * PIXELS_PER_UNIT / 5, SIDE / 2 - SIDE / 200);
        
        CGContextMoveToPoint(context, SIDE / 2 - SIDE / 300, i * PIXELS_PER_UNIT / 5);
        CGContextAddLineToPoint(context, SIDE/2 + SIDE / 300, i * PIXELS_PER_UNIT / 5);
    }
    CGContextStrokePath(context);
    // draw curve
    if (_graphPoints) {
        CGContextSetLineWidth(context, 3);
        CGContextSetStrokeColorWithColor(context, [UIColor redColor].CGColor);
        for (int i = 0; i < SIDE - 1; i++) {
            NSNumber * start =[_graphPoints objectAtIndex:i ];
            NSNumber * end = [_graphPoints objectAtIndex:i + 1 ];
            
            if (![start isEqualToNumber:[NSDecimalNumber notANumber]] && ![end isEqualToNumber:[NSDecimalNumber notANumber]] && fabsf([start floatValue]) < DBL_MAX && fabsf([end floatValue]) < DBL_MAX ) {
                CGContextMoveToPoint(context, i, SIDE / 2.0 - [start floatValue] * PIXELS_PER_UNIT);
                CGContextAddLineToPoint(context, i + 1, SIDE / 2.0 - [end floatValue] * PIXELS_PER_UNIT);
            }
        }
        CGContextStrokePath(context);
    }
    // if previewed x is set, draw preview point
    if (x && _graphPoints) {
        NSNumber * y = [_graphPoints objectAtIndex:x];
        if (![y isEqualToNumber:[NSDecimalNumber notANumber]] && fabsf([y floatValue]) < DBL_MAX) {
            CGRect borderRect = CGRectMake(x - 10, SIDE / 2 - [y floatValue] * PIXELS_PER_UNIT - 10, 20.0, 20.0);
            CGContextRef context = UIGraphicsGetCurrentContext();
            CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
            CGContextSetLineWidth(context, 1.0);
            CGContextFillEllipseInRect (context, borderRect);
            CGContextStrokeEllipseInRect(context, borderRect);
            CGContextFillPath(context);
        }
    }
}

-(void) setSelectedX:(CGFloat) xSelect {
    x = xSelect;
}

-(void) setGraphPoints:(NSArray *) graphPoints {
    _graphPoints = graphPoints;
}

@end
