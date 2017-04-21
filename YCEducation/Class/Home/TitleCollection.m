//
//  TitleCollection.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "TitleCollection.h"
#import "ZHCCollectionViewCell.h"
#import "UIView+Controller.h"
#import "TitleCollectionViewCell.h"
#import "WebViewController.h"
#import "ZHHud.h"
@interface TitleCollection ()
@property(nonatomic,strong)UICollectionView * collection;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;
@property(nonatomic,strong)NSArray * data;
@property(nonatomic,strong)NSDictionary  * arr;
@end
@implementation TitleCollection
+(instancetype)share{
    
    return [[TitleCollection alloc]initWith];
}


- (instancetype)initWith{
    
    
    if (self = [super init]) {
        
        [self setuCollection];
        
        
        self.data = @[@{@"imageName":@"daishenpi",@"title":@"待审批事项"},@{@"imageName":@"daicanyu",@"title":@"待参与活动"}];
        
    }
    
    
    return self;
    
}

- (void)setuCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake((WIDTH-2)/2, 50);
    flowLayout.minimumInteritemSpacing=0; //cell之间左右的
    flowLayout.minimumLineSpacing=1;      //cell上下间隔
    //    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout = flowLayout;

    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    mainView.backgroundColor = [UIColor clearColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[TitleCollectionViewCell class] forCellWithReuseIdentifier:@"collection1"];
    mainView.dataSource = self;
    mainView.delegate = self;
    _collection = mainView;
}
#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.data.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection1" forIndexPath:indexPath];
   
    NSDictionary * dict = _data[indexPath.row];
    
    [cell setDataWithDict:dict];
    
    if (self.arr) {
        NSDictionary * dict = indexPath.row?_arr[@"udActivity"]:_arr[@"udExp"];
        
        cell.numberLB.text = [NSString stringWithFormat:@"%@",dict[@"num"]];
        
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    NSLog(@"%ld",(long)indexPath.row);
    NSDictionary * dict = indexPath.row?_arr[@"udActivity"]:_arr[@"udExp"];

//    NSString * url  =  indexPath.row?[NSString stringWithFormat:@"%@",_arr[@""]]:[NSString stringWithFormat:@"%@",_arr[@""]];
    WebViewController * web = [WebViewController new];
    web.url = [PublicVoid getNewUrl:dict[@"href"]];
    if ([web.url isEqualToString:@""]||web.url==nil) {
        
        [ZHHud initWithMessage:@"暂无页面"];
        return;
        
    }

    [self.collection.navigationController pushViewController:web animated:YES];
    
    
    
}

-(void)upDataWithData:(NSDictionary *)countDict{
    
    self.arr = countDict;
    [self.collection reloadData];
       
    
}

@end
