//
//  ViewController.m
//  WFContentScrollView
//
//  Created by feiwu on 15/8/25.
//  Copyright (c) 2015年 feiwu. All rights reserved.
//

#import "ViewController.h"
#import "WFContentScrollView.h"

@interface ViewController () <WFContentScrollViewDataSource, WFContentScrollViewDelegate>

@property (nonatomic, strong) NSMutableArray *views;
@property (nonatomic, strong) WFContentScrollView *contentScrollView;

@end

@implementation ViewController

- (NSMutableArray *)views
{
    if (_views == nil) {
        _views = [NSMutableArray array];
        
        UIView *view0 = [[UIView alloc] init];
        view0.backgroundColor = [UIColor redColor];
        [_views addObject:view0];
        
        UIView *view1 = [[UIView alloc] init];
        view1.backgroundColor = [UIColor yellowColor];
        [_views addObject:view1];
        
        UIView *view2 = [[UIView alloc] init];
        view2.backgroundColor = [UIColor brownColor];
        [_views addObject:view2];
        
        UIView *view3 = [[UIView alloc] init];
        view3.backgroundColor = [UIColor orangeColor];
        [_views addObject:view3];
        
        UIView *view4 = [[UIView alloc] init];
        view4.backgroundColor = [UIColor greenColor];
        [_views addObject:view4];
    }
    return _views;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    WFContentScrollView *contentScrollView = [[WFContentScrollView alloc] init];
    contentScrollView.backgroundColor = [UIColor lightGrayColor];
    contentScrollView.dataSource = self;
    contentScrollView.delegate = self;
    contentScrollView.currentPageIndex = 2;
    contentScrollView.frame = CGRectMake(20, 20, self.view.bounds.size.width - 40, self.view.bounds.size.height - 40);
    [self.view addSubview:contentScrollView];
    
    self.contentScrollView = contentScrollView;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.contentScrollView scrollToViewAtIndex:0];
}

#pragma mark - WFContentScrollViewDataSource

- (NSUInteger)countOfViewsInContentScrollView:(WFContentScrollView *)contentScrollView
{
    return self.views.count;
}

- (UIView *)contentScrollView:(WFContentScrollView *)contentScrollView viewAtIndex:(NSUInteger)index
{
    UIView *view = self.views[index];
    return view;
}

#pragma mark - WFContentScrollViewDelegate

- (void)contentScrollView:(WFContentScrollView *)contentScrollView didScrollMostlyToViewAtIndex:(NSUInteger)index
{
    NSLog(@"mostly view index is %zd", index);
}

- (void)contentScrollView:(WFContentScrollView *)contentScrollView didScrollFinallyToViewAtIndex:(NSUInteger)index
{
    NSLog(@"finaly view index is %zd", index);
}

@end
