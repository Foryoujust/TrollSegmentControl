//
//  TrollSegmentControl.m
//  TestDemo
//
//  Created by cxy on 15/6/17.
//  Copyright (c) 2015年 nandu. All rights reserved.
//

#import "TrollSegmentControl.h"

static CGFloat const IndicatorViewHeight = 3;

@interface TrollSegmentControl()

@property (nonatomic, strong) UIView *indicatorView;
@property (nonatomic, strong) NSMutableArray *btns;
@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation TrollSegmentControl


- (instancetype)initWithFrame:(CGRect)frame{
    if(self = [super initWithFrame:frame]){
        _btns = [NSMutableArray array];
        _indicatorColor = [UIColor lightGrayColor];
        _selectedSectionColor = [UIColor blackColor];
        _unselectedSectionColor = [UIColor blackColor];
    }
    
    return self;
}

- (void)setIndicatorColor:(UIColor *)indicatorColor{
    _indicatorColor = indicatorColor;
    if(_indicatorView){
        _indicatorView.backgroundColor = _indicatorColor;
    }
}

- (void)setSelectedSectionColor:(UIColor *)selectedSectionColor{
    
    _selectedSectionColor = selectedSectionColor;
    
    if(_btns[0]){
        [_btns[0] setTitleColor:_selectedSectionColor forState:UIControlStateNormal];
    }
}

- (void)setItems:(NSArray *)items{
    if(items && items.count){
        
        CGFloat width = self.frame.size.width/items.count;
        
        if(_indicatorView == nil){
            _indicatorView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-IndicatorViewHeight, width, IndicatorViewHeight)];
            _indicatorView.backgroundColor = _indicatorColor;
            [self addSubview:_indicatorView];   
        }
        
        _selectedIndex = 0;
        
        for(NSString *item in items){
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
            NSInteger index = [items indexOfObject:item];
            [btn setFrame:CGRectMake(width*index, 0, width, self.frame.size.height-IndicatorViewHeight)];
            [btn setTitle:item forState:UIControlStateNormal];
            
            if(index == 0){
                [btn setTitleColor:_selectedSectionColor forState:UIControlStateNormal];
            }else{
                [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
            [self.btns addObject:btn];
        }
    }
}

- (void)btnPress:(UIButton *)btn{
    NSInteger index = [_btns indexOfObject:btn];
    if(index == _selectedIndex){
        return;
    }else{
        for(UIButton *btnTmp in _btns){
            if([btnTmp isEqual:btn]){
                [btnTmp setTitleColor:_selectedSectionColor forState:UIControlStateNormal];
            }else{
                [btnTmp setTitleColor:_unselectedSectionColor forState:UIControlStateNormal];
            }
        }
        
        [UIView animateWithDuration:0.2 animations:^{
        
            _indicatorView.frame = CGRectMake(btn.frame.origin.x, _indicatorView.frame.origin.y, _indicatorView.frame.size.width, _indicatorView.frame.size.height);
        }];
        _selectedIndex = index;
        
        if(_delegate && [_delegate respondsToSelector:@selector(TrollSegmentControl:selectedAtIndex:section:)]){
            [_delegate TrollSegmentControl:self selectedAtIndex:index section:btn.titleLabel.text];
        }
    }
}

@end
