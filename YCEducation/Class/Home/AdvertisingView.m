
//
//  AdvertisingView.m
//  YCEducation
//
//  Created by zhou on 2017/3/8.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "AdvertisingView.h"
#import "UIView+SDExtension.h"
#import "AdvertisingCollectionViewCell.h"
NSString * const identer = @"zhcCell";

@interface AdvertisingView()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, weak) UICollectionView *collection; // 显示图片的collectionView
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) NSInteger totalItemsCount;
@end
@implementation AdvertisingView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        _autoScrollTimeInterval = 1.0;
        [self setuCollection];
        
    }
    return self;
}

+ (instancetype)selectScrollViewWithFrame:(CGRect)frame data:(NSArray *)data
{
    AdvertisingView *cycleScrollView = [[self alloc] initWithFrame:frame];
    
    
    cycleScrollView.imagesGroup = data;

    
    return cycleScrollView;
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _flowLayout.itemSize = self.frame.size;
}

- (void)setAutoScrollTimeInterval:(CGFloat)autoScrollTimeInterval
{
    _autoScrollTimeInterval = autoScrollTimeInterval;
    
    [_timer invalidate];
    _timer = nil;
    [self setupTimer];
}

// 设置显示图片的collectionView
- (void)setuCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH-80, 71.5);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH-80, 71.5) collectionViewLayout:flowLayout];
    
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[AdvertisingCollectionViewCell class] forCellWithReuseIdentifier:identer];
    mainView.dataSource = self;
    mainView.delegate = self;
    [self addSubview:mainView];
    _collection = mainView;
}

- (void)setImagesGroup:(NSArray *)imagesGroup
{
    if (!(imagesGroup.count>0)) {
        
        imagesGroup = @[@{@"title":@"暂无数据",@"from":@"军情七处",@"ctime":@"2017/1/1"}];
        
        
    }
  
    _imagesGroup = imagesGroup;
    _totalItemsCount = imagesGroup.count * 100;
    [_timer invalidate];
    _timer = nil;
    
    if (self.imagesGroup.count>0) {
         [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        [self setupTimer];
        [self.collection reloadData];
 
    }
    
}



- (void)automaticChange
{
    int currentIndex = _collection.contentOffset.y / _flowLayout.itemSize.height;
    int targetIndex = currentIndex + 1;
    if (targetIndex == _totalItemsCount) {
        targetIndex = _totalItemsCount * 0.5;
        [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
}

- (void)setupTimer
{
    if (!_timer) {
        NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:self.autoScrollTimeInterval target:self selector:@selector(automaticChange) userInfo:nil repeats:YES];
        _timer = timer;
        [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    }
    
   
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _collection.frame = self.bounds;
    if (_collection.contentOffset.y == 0) {
        [_collection scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_totalItemsCount * 0.5 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _totalItemsCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    AdvertisingCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identer forIndexPath:indexPath];
    long itemIndex = indexPath.item % self.imagesGroup.count;
    NSDictionary *data = self.imagesGroup[itemIndex];
   
    [cell setDataWithDict:data];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(selectScrollView:didSelectItemAtIndex:)]) {
        [self.delegate selectScrollView:self didSelectItemAtIndex:indexPath.item % self.imagesGroup.count];
    }
}

#pragma mark - UIScrollViewDelegate


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setupTimer];
}





@end
