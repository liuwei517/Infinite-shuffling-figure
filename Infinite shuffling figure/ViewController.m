//
//  ViewController.m
//  无线轮播图
//
//  Created by 赵子龙 on 16/6/3.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "ViewController.h"
#import "LWBannerView.h"
@interface ViewController ()<LWBannerViewDelegate>
{


    LWBannerView *banner;

}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    banner = [[LWBannerView alloc]initWithFrame:CGRectMake(0, 0, 414, 200)];
    
    banner.sourceArray = @[@"第一张1.jpg",@"第一张2.jpg",@"第一张3.jpg",@"第一张4.jpg",@"第一张5.jpg"];
    
    banner.backgroundColor = [UIColor redColor];
    
    banner.isTimer = YES;
    
    banner.delegate = self;
    
    [self.tableView addSubview:banner];
    
    
    // 给tableview设置一个跟轮播图一样高的表头，避免cell显示在轮播图上
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 414, 200)];
    
    self.tableView.tableHeaderView.userInteractionEnabled = NO;
    

}

- (void)chuan:(long)page{

  

}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView.contentOffset
        .y<0) {
        
        CGRect initFrame = banner.frame;
        
        
        initFrame.origin.y = scrollView.contentOffset.y;
        
        
        initFrame.size.height = 200 - scrollView.contentOffset.y;
        
        banner.frame = initFrame;
        
        
    }
    

}



@end
