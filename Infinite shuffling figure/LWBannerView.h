//
//  LWBannerView.h
//  无线轮播图
//
//  Created by 赵子龙 on 16/6/3.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LWBannerViewDelegate <NSObject>

- (void)chuan:(long)page;

@end

@interface LWBannerView : UIView

// 数据源数组
@property (nonatomic,strong)NSArray *sourceArray;

// 是否需要定时轮播
@property (nonatomic,assign)BOOL isTimer;


@property(nonatomic,retain)id < LWBannerViewDelegate> delegate;

@end
