//
//  ViewController.h
//  fx
//
//  Created by Songge Chen on 4/1/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EquationParser.h"
#import "GraphView.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>
@property (strong, nonatomic) UIScrollView *graphScrollView;
@property (nonatomic, strong) GraphView * graph;
@property (nonatomic, strong) EquationParser * ep;

@end

