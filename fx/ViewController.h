//
//  ViewController.h
//  fx
//
//  Created by Songge Chen on 4/1/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/CAAnimation.h>
#import "EquationParser.h"
#import "GraphView.h"
#import "CalcButton.h"

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    NSMutableArray * equationButtons;
}
@property (strong, nonatomic) UIScrollView *graphScrollView;
@property (nonatomic, strong) GraphView * graph;
@property (nonatomic, strong) UIView * buttonsView;
@property (nonatomic, strong) UIView * equationView;
@property (nonatomic, strong) EquationParser * ep;
@property (nonatomic, strong) UILabel * fxLabel;
@property (nonatomic, strong) UIButton * backspaceButton;
@end

