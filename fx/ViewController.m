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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpGraph];
    [self setUpButtonView];

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

    _backspaceButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    _backspaceButton.alpha = 0.0;
    [_backspaceButton setImage:[UIImage imageNamed:@"backspace.png"] forState:UIControlStateNormal];
    [_equationView addSubview:_backspaceButton];
    
    [UIView animateWithDuration:0.5f delay:0.25f options:UIViewAnimationOptionCurveEaseOut animations:^{
        
        _equationView.frame = CGRectMake(10, 10, _buttonsView.frame.size.width - 20, 50.0f *_buttonsView.frame.size.height /256.0f);
        _backspaceButton.frame = CGRectMake(_equationView.frame.size.width - _equationView.frame.size.height, 0, _equationView.frame.size.height, _equationView.frame.size.height);
        
        
    } completion:^(BOOL finished){
        [UIView animateWithDuration:1.0f delay: 0.0f options:UIViewAnimationOptionCurveEaseOut
                         animations:^{
                             _backspaceButton.alpha = 1.0;
                             UIBezierPath * eqViewShadowPath = [UIBezierPath bezierPathWithRect:_equationView.bounds ];
                             _equationView.layer.shadowPath = eqViewShadowPath.CGPath;
                             _graph.alpha = 1.0f;
                         }
                         completion:nil];
    }];
    [_buttonsView addSubview:_equationView];
    
    // add calc buttons
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

-(void) setUpButtons {
    
}

-(void) setUpGraph {
    UIColor * scrollBackground =[UIColor colorWithRed:0.992 green:0.996 blue:1.000 alpha:1] ;
    
    
    // test equation
    _ep = [[EquationParser alloc] init];
    NSArray * testArray = @[@"X", @"^2"];
    
    
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
    NSMutableArray * curvePoints = [[NSMutableArray alloc] initWithCapacity:SIDE];
    for (int i = -SIDE / 2; i < SIDE / 2; i++) {
        NSNumber * x = [NSNumber numberWithDouble:i / (SIDE / 10.0)];
        NSNumber * y = [_ep parseEquationStringArray:testArray forX:x];
        [curvePoints addObject:y];
    }
    [self setCurve:testArray];
}

-(void) singleTap:(UITapGestureRecognizer *)recognizer {
    // TODO : create circle dot uiview instead of having to redraw the whole graph every time a location is tapped
    CGPoint location = [recognizer locationInView:recognizer.view];
    [_graph setSelectedX:location.x];
    [_graph setNeedsDisplay];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
