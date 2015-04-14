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
@synthesize ep = _ep;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _ep = [[EquationParser alloc] init];
    NSArray * testArray = @[@"X", @"+", @"X", @"^2"];
    
    _graph = [[GraphView alloc] init];
    [_graph setBackgroundColor:[UIColor clearColor]];
    
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTap:)];
    [tapRecognizer setNumberOfTapsRequired:1];
    [_graph addGestureRecognizer:tapRecognizer];
    
    // set up scrollView
    _graphScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width)];
    _graphScrollView.contentSize = _graph.frame.size;
    [_graphScrollView setBackgroundColor:[UIColor clearColor]];
    _graphScrollView.delegate = self;

    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [_graphScrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [_graphScrollView addGestureRecognizer:twoFingerTapRecognizer];
    
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

- (void)scrollViewTwoFingerTapped:(UITapGestureRecognizer*)recognizer {
    // Zoom out
    CGFloat newZoomScale = _graphScrollView.zoomScale / 1.5f;
    newZoomScale = MAX(newZoomScale, _graphScrollView.minimumZoomScale);
    [_graphScrollView setZoomScale:newZoomScale animated:YES];
}

- (void)scrollViewDoubleTapped:(UITapGestureRecognizer*)recognizer {
    CGPoint pointInView = [recognizer locationInView:_graph];

    CGFloat newZoomScale = _graphScrollView.zoomScale * 1.5f;
    newZoomScale = MIN(newZoomScale, _graphScrollView.maximumZoomScale);
    
    CGSize scrollViewSize = _graphScrollView.bounds.size;
    
    CGFloat w = scrollViewSize.width / newZoomScale;
    CGFloat h = scrollViewSize.height / newZoomScale;
    CGFloat x = pointInView.x - (w / 2.0f);
    CGFloat y = pointInView.y - (h / 2.0f);
    
    CGRect rectToZoomTo = CGRectMake(x, y, w, h);
    
    [_graphScrollView zoomToRect:rectToZoomTo animated:YES];
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)_graphScrollView {
    return _graph;
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
