//
//  GraphView.h
//  fx
//
//  Created by Songge Chen on 4/9/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#define PIXELS_PER_UNIT 250
#define SIDE 2500
@interface GraphView : UIView {
    NSArray * _graphPoints;
    CGFloat x;
}
-(void) setGraphPoints:(NSArray *) graphPoints;
-(void) setSelectedX:(CGFloat)xSelect;
@end
