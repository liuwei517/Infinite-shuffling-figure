//
//  LWBannerView.m
//  无线轮播图
//
//  Created by 赵子龙 on 16/6/3.
//  Copyright © 2016年 赵子龙. All rights reserved.
//

#import "LWBannerView.h"


@interface LWBannerView ()<UICollectionViewDelegate
,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

{
    UICollectionView *collect;
    
    UIPageControl *page;
    
    NSTimer *timer;
    
    UICollectionViewFlowLayout *layout;
    

}

@end

@implementation LWBannerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
       
        [self setCollectView:frame];
        
        [self setPage:frame];
        
    }
    return self;
}



- (void)setPage:(CGRect)frame{


    page = [[UIPageControl alloc]initWithFrame:CGRectMake(0, frame.size.height-20, frame.size.width, 20)];
    
    page.backgroundColor = [UIColor grayColor];
    
    [self addSubview:page];
    
    
}

- (void)setCollectView:(CGRect)frame{
    
    
    
    layout = [[UICollectionViewFlowLayout alloc]init];
    
    layout.itemSize = CGSizeMake(frame.size.width, frame.size.height);
    
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    layout.minimumLineSpacing = 0;
    
    collect = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) collectionViewLayout:layout];
    
    collect.pagingEnabled = YES;
    
    [self addSubview:collect];

    [collect registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];


    collect.delegate = self;
    collect.dataSource =self;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap)];
    
    [collect addGestureRecognizer:tap];
    
    
    
    
}


#pragma mark UICollectoin delegate datasource delegatelayout

- (void)tap{
    
    if ([self.delegate respondsToSelector:@selector(chuan:)]) {
        
        
        [self.delegate chuan:page.currentPage];
        
        
    }
    
    
    
    
}


-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{


    return 5;
    

}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    
    return _sourceArray.count;
    

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{


    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    
    UIImageView *imageView = [[UIImageView alloc]init];
    
    imageView.image = [UIImage imageNamed:_sourceArray[indexPath.item]];
    
    imageView.userInteractionEnabled = YES;
    
    cell.backgroundView = imageView;
    
    
    return cell;


}

- (void)setSourceArray:(NSArray *)sourceArray{

    _sourceArray = sourceArray;
    
    page.numberOfPages = sourceArray.count;

    [collect reloadData];

    [collect scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:2] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    
     page.currentPage = (int)(scrollView.contentOffset.x/scrollView.frame.size.width+0.5)%self.sourceArray.count;
    
}

- (void)setIsTimer:(BOOL)isTimer{

    _isTimer = isTimer;
    
    
    if (isTimer == YES) {
        
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
        
        
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
 
        
    }
    
   


}

- (void)nextPage{
    
    
    NSIndexPath *currentIndexPath = [[collect indexPathsForVisibleItems] lastObject];
    
    
    
    NSIndexPath *currentIndexReset = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:2];
    
    [collect scrollToItemAtIndexPath:currentIndexReset atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    // 准备下一个Item
    NSInteger nextItem = currentIndexPath.item+1;
    

    
    //准备下一个section
    NSInteger nextSection = currentIndexReset.section;
    
    if (nextItem == self.sourceArray.count) {
        
          nextItem = 0;
         nextSection++;
        
        
    }
    
    //page.currentPage = nextItem;
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    
    [collect scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{

    timer.fireDate = [NSDate distantFuture];


}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{

 
    timer.fireDate = [NSDate dateWithTimeIntervalSinceNow:2];


}


- (void)setFrame:(CGRect)frame{

    [super setFrame:frame];
    
    
    collect.frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    
    layout.itemSize = frame.size;
    
    page.frame = CGRectMake(0, frame.size.height-20, frame.size.width, 20);
    
   
    [collect reloadData];


}




- (void)dealloc{

    [timer invalidate];
    
    timer = nil;


}




@end
