//
//  WFContentScrollView.h
//  WFContentScrollView
//
//  Created by feiwu on 15/8/25.
//  Copyright (c) 2015年 feiwu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WFContentScrollView;

@protocol WFContentScrollViewDataSource <NSObject>

@required

- (NSUInteger)countOfViewsInContentScrollView:(WFContentScrollView *)contentScrollView;

- (UIView *)contentScrollView:(WFContentScrollView *)contentScrollView viewAtIndex:(NSUInteger)index;

@end

@protocol WFContentScrollViewDelegate <NSObject>

@optional

// more than half is as a page
- (void)contentScrollView:(WFContentScrollView *)contentScrollView didScrollMostlyToViewAtIndex:(NSUInteger)index;

- (void)contentScrollView:(WFContentScrollView *)contentScrollView didScrollFinallyToViewAtIndex:(NSUInteger)index;

@end

@interface WFContentScrollView : UIView

@property (nonatomic, weak) id<WFContentScrollViewDataSource> dataSource;

@property (nonatomic, weak) id<WFContentScrollViewDelegate> delegate;

/**
 *  defaut is 0
 */
@property (nonatomic, assign) NSUInteger currentPageIndex;

- (void)scrollToViewAtIndex:(NSUInteger)index;

@end
