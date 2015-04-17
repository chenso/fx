//
//  CalcButton.h
//  fx
//
//  Created by Songge Chen on 4/14/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalcButton : UIButton {
    NSString * _stringRepresentation;
    NSNumber * pointValue;
}

-(id) initWithFrame:(CGRect)frame stringRep:(NSString *)stringrep title:(NSString *) title;
@end
