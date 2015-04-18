//
//  ViewController.m
//  fx
//
//  Created by Songge Chen on 4/1/15.
//  Copyright (c) 2015 Songge Chen. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController 
@synthesize graphScrollView = _graphScrollView;
@synthesize graph = _graph;
@synthesize buttonsView = _buttonsView;
@synthesize equationView = _equationView;
@synthesize ep = _ep;
@synthesize fxLabel = _fxLabel;
@synthesize backspaceButton = _backspaceButton;
@synthesize gameState = _gameState;

#pragma View Set Up

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGameState];
    [self setUpGraph];
    [self setUpButtonView];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    CGRect scrollViewFrame = _graphScrollView.frame;
    CGFloat scaleWidth = scrollViewFrame.size.width / _graphScrollView.contentSize.width;
    CGFloat scaleHeight = scrollViewFrame.size.height / _graphScrollView.contentSize.height;
    CGFloat minScale = MIN(scaleWidth, scaleHeight);
    _graphScrollView.minimumZoomScale = minScale;
    
    _graphScrollView.maximumZoomScale = 1.0f;
    _graphScrollView.zoomScale = (minScale + 1.0f) / 2;
    [_graphScrollView setContentOffset:CGPointMake(SIDE/2 - _graphScrollView.zoomScale * SIDE / 2, SIDE /2 - _graphScrollView.zoomScale * SIDE / 2) animated:YES];
    [self centerScrollViewContents];
}

-(void) setUpButtonView {
    _buttonsView = [[UIView alloc] initWithFrame:CGRectMake(0, _graphScrollView.frame.size.height, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height - _graphScrollView.frame.size.height)];
    _buttonsView.backgroundColor = [UIColor colorWithRed:0.451 green:0.545 blue:0.655 alpha:1.0];

    _equationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _buttonsView.frame.size.width - 50, 0)];
    [_equationView setBackgroundColor:[UIColor colorWithRed:0.52 green:0.74 blue:1.00 alpha:1.0]];
    
    UIBezierPath * eqViewShadowPath = [UIBezierPath bezierPathWithRect:_equationView.bounds ];
    _equationView.layer.masksToBounds = NO;
    _equationView.layer.shadowColor = [UIColor blackColor].CGColor;
    _equationView.layer.shadowOffset = CGSizeMake(2.0f, -2.0f);
    _equationView.layer.shadowOpacity = 0.2f;
    _equationView.layer.shadowPath = eqViewShadowPath.CGPath;

    _backspaceButton = [[UIButton alloc] initWithFrame:CGRectMake((_buttonsView.frame.size.width - 20) / 2, 0, 0, 0)];
    _backspaceButton.alpha = 0.0;
    [_backspaceButton setImage:[UIImage imageNamed:@"backspace.png"] forState:UIControlStateNormal];
    [_equationView addSubview:_backspaceButton];
    
    [UIView animateWithDuration:0.5f delay:0.25f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _equationView.frame = CGRectMake(10, 10, _buttonsView.frame.size.width - 20, 50.0f *_buttonsView.frame.size.height /256.0f);
        _backspaceButton.frame = CGRectMake(_equationView.frame.size.width - _equationView.frame.size.height, 0, _equationView.frame.size.height, _equationView.frame.size.height);
        
        
    } completion: ^(BOOL finished){
        [UIView animateWithDuration:0.07f delay: 0.0f options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             //_backspaceButton.alpha = 1.0;
                             UIBezierPath * eqViewShadowPath = [UIBezierPath bezierPathWithRect:_equationView.bounds ];
                             _equationView.layer.shadowPath = eqViewShadowPath.CGPath;
                         }
                         completion:nil];
    }];
    [UIView animateWithDuration:1.0f delay: 0.5f options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         _backspaceButton.alpha = 1.0;
                     }
                     completion:nil];
    
    [_buttonsView addSubview:_equationView];
    
    [self setUpButtons];
    
    _fxLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 3 * _buttonsView.frame.size.width / 15, 2 * _buttonsView.frame.size.height / 15)];
    //[_fxLabel setText:@"f(x)="];
    [_fxLabel setFont:[UIFont fontWithName:@"ArialMT" size:30]];
    [_fxLabel setTextColor:[UIColor whiteColor]];
    //[_fxLabel setBackgroundColor:[UIColor blackColor]];
    [_equationView addSubview:_fxLabel];
    // add shadow to make buttonsView on a higher level than graphView
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:_buttonsView.bounds];
    _buttonsView.layer.masksToBounds = NO;
    _buttonsView.layer.shadowColor = [UIColor blackColor].CGColor;
    _buttonsView.layer.shadowOffset = CGSizeMake(0.0f, -6.0f);
    _buttonsView.layer.shadowOpacity = _graphScrollView.zoomScale;
    _buttonsView.layer.shadowPath = shadowPath.CGPath;
    [self setUpButtons];
    [self.view addSubview:_buttonsView];
}



-(void) setUpGameState {
    _ep = [[EquationParser alloc] init];
    NSMutableArray * test = [NSMutableArray arrayWithObjects:@"X", nil];
    _gameState = [[fxGame alloc] initWithEquation:test difficulty:0]; // TODO: set up difficulty setting
}

-(void) setUpGraph {
    UIColor * scrollBackground =[UIColor colorWithRed:0.992 green:0.996 blue:1.000 alpha:1] ;
    _graph = [[GraphView alloc] init];
    [_graph setBackgroundColor:scrollBackground];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [_graph addGestureRecognizer:tapRecognizer];
    
    
    // set up scrollView
    _graphScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width)];
    _graphScrollView.contentSize = _graph.frame.size;
    [_graphScrollView setBackgroundColor:scrollBackground];
    _graphScrollView.delegate = self;
    
    [_graphScrollView addSubview:_graph];
    [self.view addSubview:_graphScrollView];
    NSArray * equation = _gameState.equation;
    [self setCurve:equation];
}

-(void) setUpButtons {
    // set each button up and add to button array
    
    NSArray * terms = @[@"X", @"+", @"*", @"LN", @")", @"-", @"/", @"E", @"^2", @"^3", @"SIN", @"COS", @"SQRT", @"CBRT", @"ARCSIN", @"ARCCOS"];
    NSDictionary * termStringRep = @{
                                     @"X"   : @"X",
                                     @"+"   : @"+",
                                     @"-"   : @"-",
                                     @"*"   : @"×",
                                     @"/"   : @"/",
                                     @"^2"  : @"x2",
                                     @"^3"  : @"x3",
                                     @"SQRT": @"√",
                                     @"CBRT": @"3√",
                                     @"SIN" : @"sin",
                                     @"COS" : @"cos",
                                     @"TAN" : @"tan",
                                     @"ARCSIN"  : @"sin-1",
                                     @"ARCCOS"  : @"cos-1",
                                     @"LN"   : @"ln",
                                     @"E"    : @"ex",
                                     @")"    : @")"
                                     
                     };
    _equationButtons = [[NSMutableArray alloc] initWithCapacity:[terms count]];
    CGFloat buttonWidth = _buttonsView.frame.size.width / 6.0;
    CGFloat buttonHeight = _buttonsView.frame.size.height / 5.0;
    CGFloat xIncr = _buttonsView.frame.size.width / 5.0;
    CGFloat yIncr = _buttonsView.frame.size.height / 5.6;
    int i = 0;
    int columns = 4;
    while (true) {
        for (int j = 0; j < columns; j++) {
            if(i * columns + j == [terms count]) goto end;
            NSString * term = [terms objectAtIndex:i * columns + j];
            NSNumber * pointValue = [_gameState.termValues objectForKey:term];
            NSString * stringRep = [termStringRep objectForKey:term];
            
            CalcButton * button;
            double fontSize = 35.0f * _buttonsView.frame.size.width / 768.0f;
            UIFont *fnt = [UIFont fontWithName:@"Helvetica" size:fontSize];
            
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:stringRep attributes:@{NSFontAttributeName: [fnt fontWithSize:fontSize]}];
            NSRange superscriptRange;
            
            if ([term isEqualToString:@"^2"] || [term isEqualToString:@"^3"] || [term isEqualToString:@"E"]) {
                superscriptRange = NSMakeRange(1, 1);

            } else if ([term isEqualToString:@"CBRT"]) {
                superscriptRange = NSMakeRange(0, 1);
            }
            else if ([term isEqualToString:@"ARCSIN"] || [term isEqualToString:@"ARCCOS"]) {
                superscriptRange = NSMakeRange(3, 2);
            } else {
                superscriptRange = NSMakeRange(0, 0);
            }
            [attributedString setAttributes:@{NSFontAttributeName : [fnt fontWithSize:fontSize / 2]
                                              , NSBaselineOffsetAttributeName : @10} range:superscriptRange];
            
            
            button = [[CalcButton alloc] initWithFrame:CGRectMake(j * xIncr, 1.2f * _equationView.frame.size.height + i * yIncr, buttonWidth, buttonHeight) stringRep:term title:attributedString];
            
            [button addTarget:self action:@selector(handleCalcButtonPress:) forControlEvents:UIControlEventTouchUpInside];
            
            [_equationButtons addObject:button];
            [_buttonsView addSubview:button];
        }
        i++;
    }
end: //TODO: set up send button in the bottom left of buttonview
    ;
    
}

-(void)handleCalcButtonPress:(id)sender {
    CalcButton * button = (CalcButton * ) sender;
    //TODO
    
    NSString * term = [button stringRepresentation];
    
    [[_gameState equation] insertObject:term atIndex:0];// TODO: change to location currently selected in the text field
    
}



-(void) setCurve:(NSArray * ) equation {
    NSMutableArray * curvePoints = [[NSMutableArray alloc] initWithCapacity:SIDE];
    for (int i = -SIDE / 2; i < SIDE / 2; i++) {
        NSNumber * x = [NSNumber numberWithDouble:i / (SIDE / 10.0)];
        NSNumber * y = [_ep parseEquationStringArray:equation forX:x];
        [curvePoints addObject:y];
    }
    [_graph setGraphPoints:curvePoints];
    [_graph setNeedsDisplay];
}

#pragma Gesture Handling

-(void) singleTap:(UITapGestureRecognizer *)recognizer {
    // TODO : create circle dot uiview instead of having to redraw the whole graph every time a location is tapped
            // add UILabel with (x,y) truncated to 2 decimal places whose location relative to the dot is dependent on the dot's quadrant
    CGPoint location = [recognizer locationInView:recognizer.view];
    [_graph setSelectedX:location.x];
    [_graph setNeedsDisplay];
}

#pragma zoom

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)_graphScrollView {
    return _graph;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    // the size of the shadow scales with the distance zoomed out
    _buttonsView.layer.shadowOpacity = _graphScrollView.zoomScale;
    _buttonsView.layer.shadowOffset = CGSizeMake(0.0f, -1.0 / _graphScrollView.zoomScale);
}

-(void) centerScrollViewContents{
    CGSize boundsSize = _graphScrollView.bounds.size;
    CGRect contentsFrame = _graph.frame;
    
    if (contentsFrame.size.width < boundsSize.width) {
        contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0f;
    } else {
        contentsFrame.origin.x = 0.0f;
    }
    
    if (contentsFrame.size.height < boundsSize.height) {
        contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0f;
    } else {
        contentsFrame.origin.y = 0.0f;
    }
    
    _graph.frame = contentsFrame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
