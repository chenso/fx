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
#import "fxGame.h"

@interface ViewController : UIViewController <UIScrollViewDelegate> {
    NSMutableArray * _equationButtons;
    NSDictionary * _termValues;
}
@property (strong) UIScrollView * graphScrollView;
@property (strong) UIView * buttonsView;
@property (strong) UIView * equationView;
@property (strong) GraphView * graph;
@property (strong) UILabel * fxLabel;
@property (strong) UIButton * backspaceButton;

@property (strong) EquationParser * ep;
@property (strong) fxGame * gameState;

@end

