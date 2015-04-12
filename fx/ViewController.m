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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    EquationParser * ep = [[EquationParser alloc] init];
    NSArray * testArray = @[@"ARCSIN", @"(", @"X", @")", @"+", @"X"];
    NSMutableArray * test = [[NSMutableArray alloc] initWithCapacity:SIDE];
    for (int i = -SIDE / 2; i < SIDE / 2; i++) {
        NSNumber * x = [NSNumber numberWithDouble:i / (SIDE / 10.0)];
        NSNumber * y = [ep parseString:testArray forX:x];
        [test addObject:y];
    }
    _graphScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width)];
    _graph = [[GraphView alloc] init];
    _graphScrollView.contentSize = _graph.frame.size;
    [_graphScrollView setBackgroundColor:[UIColor clearColor]];
    [_graph setBackgroundColor:[UIColor clearColor]];
    [_graphScrollView addSubview:_graph];
    _graphScrollView.delegate = self;
    UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewDoubleTapped:)];
    doubleTapRecognizer.numberOfTapsRequired = 2;
    doubleTapRecognizer.numberOfTouchesRequired = 1;
    [_graphScrollView addGestureRecognizer:doubleTapRecognizer];
    
    UITapGestureRecognizer *twoFingerTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewTwoFingerTapped:)];
    twoFingerTapRecognizer.numberOfTapsRequired = 1;
    twoFingerTapRecognizer.numberOfTouchesRequired = 2;
    [_graphScrollView addGestureRecognizer:twoFingerTapRecognizer];
    
    [self.view addSubview:_graphScrollView];
    
    [_graph setGraphPoints:test];
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
    _graphScrollView.zoomScale = minScale;

    [self centerScrollViewContents];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
