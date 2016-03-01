//
//  WFContentScrollView.m
//  WFContentScrollView
//
//  Created by feiwu on 15/8/25.
//  Copyright (c) 2015年 feiwu. All rights reserved.
//

#import "WFContentScrollView.h"

@interface WFContentScrollView () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WFContentScrollView

#pragma mark - init

- (instancetype)init
{
    if (self == [super init]) {
        self.currentPageIndex = 0;
        self.enableClipsToBounds = YES;
    }
    return self;
}

#pragma mark - lazy load

- (UIScrollView *)scrollView
{
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.clipsToBounds = self.enableClipsToBounds;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        [self addSubview:_scrollView];
    }
    return _scrollView;
}

#pragma mark - override

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // set scrollView attrs
    self.scrollView.frame = self.bounds;
    NSUInteger count = [self.dataSource countOfViewsInContentScrollView:self];
    CGFloat contentSizeW = self.scrollView.bounds.size.width * count;
    CGFloat contentSizeH = self.scrollView.bounds.size.height;
    self.scrollView.contentSize = CGSizeMake(contentSizeW, contentSizeH);
    self.scrollView.contentOffset = CGPointMake(self.scrollView.bounds.size.width * self.currentPageIndex, 0);
    
    // notify
    if ([self.delegate respondsToSelector:@selector(contentScrollView:didScrollMostlyToViewAtIndex:)]) {
        [self.delegate contentScrollView:self didScrollMostlyToViewAtIndex:self.currentPageIndex];
    }
    
    // notify
    if ([self.delegate respondsToSelector:@selector(contentScrollView:didScrollFinallyToViewAtIndex:)]) {
        [self.delegate contentScrollView:self didScrollFinallyToViewAtIndex:self.currentPageIndex];
    }
    
    // loadView
    [self loadViews];
}

#pragma mark - private method

- (void)loadViews
{
    NSUInteger count = [self.dataSource countOfViewsInContentScrollView:self];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.scrollView.bounds.size.width;
    CGFloat h = self.scrollView.bounds.size.height;
    for (NSUInteger i = 0; i < count; i++) {
        UIView *view = [self.dataSource  contentScrollView:self viewAtIndex:i];
        if (view.superview != self.scrollView) {
            [self.scrollView addSubview:view];
        }
        view.frame = CGRectMake(x, y, w, h);
        x += w;
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat scrollViewW = scrollView.bounds.size.width;
    CGFloat contentOffsetX = scrollView.contentOffset.x + scrollViewW * 0.5; // fake offset

    NSUInteger newPageIndex= contentOffsetX / scrollViewW;
    if (newPageIndex != self.currentPageIndex) {
        self.currentPageIndex = newPageIndex;
        if ([self.delegate respondsToSelector:@selector(contentScrollView:didScrollMostlyToViewAtIndex:)]) {
            [self.delegate contentScrollView:self didScrollMostlyToViewAtIndex:self.currentPageIndex];
        }
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(contentScrollView:didScrollFinallyToViewAtIndex:)]) {
        [self.delegate contentScrollView:self didScrollFinallyToViewAtIndex:self.currentPageIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([self.delegate respondsToSelector:@selector(contentScrollView:didScrollFinallyToViewAtIndex:)]) {
        [self.delegate contentScrollView:self didScrollFinallyToViewAtIndex:self.currentPageIndex];
    }
}

#pragma mark - public method

- (void)scrollToViewAtIndex:(NSUInteger)index
{
    [self.scrollView setContentOffset:CGPointMake(index * self.scrollView.bounds.size.width, 0) animated:YES];
}

@end
