//
//  TrollSegmentControl.h
//  TestDemo
//
//  Created by cxy on 15/6/17.
//  Copyright (c) 2015年 nandu. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrollSegmentControl;

@protocol TrollSegmentControlEventDelegate <NSObject>

@optional
- (void)TrollSegmentControl:(TrollSegmentControl *)seg selectedAtIndex:(NSInteger)index section:(NSString *)section;

@end

@interface TrollSegmentControl : UIView

- (instancetype)initWithFrame:(CGRect)frame;
@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) UIColor *indicatorColor;
@property (nonatomic, strong) UIColor *selectedSectionColor;
@property (nonatomic, strong) UIColor *unselectedSectionColor;
@property (nonatomic, assign) id<TrollSegmentControlEventDelegate>delegate;

@end
