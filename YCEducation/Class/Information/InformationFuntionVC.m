//
//  FunctionCollection.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "InformationFuntionVC.h"
#import "ZHCCollectionViewCell.h"
#import "CYLTabBarController.h"
#import "InforamtionCollectionViewCell.h"
#import "GroupViewController.h"

@interface InformationFuntionVC ()
{
    BOOL _click;
    
}
@property(nonatomic,strong)UICollectionView * collection;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end


@implementation InformationFuntionVC

+(instancetype)share{
    
    return [[InformationFuntionVC alloc]init];
}


- (instancetype)init{
    
    
    if (self = [super init]) {
        
        
        //
        NSArray * arr = @[@{@"apIcon":@"qingjia",@"apName":@"请假申请"},@{@"apIcon":@"xiaojia",@"apName":@"销假申请"},@{@"apIcon":@"chuchai",@"apName":@"出差申请"},@{@"apIcon":@"xiaoche",@"apName":@"用车申请"},@{@"apIcon":@"wupin",@"apName":@"物品申购"},@{@"apIcon":@"xietong",@"apName":@"协同办公"},@{@"apIcon":@"huodong",@"apName":@"活动管理"},@{@"apIcon":@"gengduo",@"apName":@"更多应用"}];
        _apList = arr;
        
        
        [self setuCollection];
    }
    
    
    return self;
    
}

- (void)setApList:(NSArray *)apList{
    
    
    if (apList.count>0) {
        _apList = apList;
        _click = YES;
        [self.collection reloadData];
        
        
    }
    
    
    
    
    
    
}

- (void)setuCollection
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(WIDTH/4, 84);
    flowLayout.minimumInteritemSpacing=0; //cell之间左右的
    flowLayout.minimumLineSpacing=0;      //cell上下间隔
    //    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _flowLayout = flowLayout;
    
    UICollectionView *mainView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    
    mainView.backgroundColor = [UIColor whiteColor];
    mainView.pagingEnabled = YES;
    mainView.showsHorizontalScrollIndicator = NO;
    mainView.showsVerticalScrollIndicator = NO;
    [mainView registerClass:[InforamtionCollectionViewCell class] forCellWithReuseIdentifier:@"information"];
    mainView.dataSource = self;
    mainView.delegate = self;
    _collection = mainView;
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.apList.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    InforamtionCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"information" forIndexPath:indexPath];
    NSDictionary * dict = _apList[indexPath.row];
    [cell setDataWithDict:dict];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary * dict = _apList[indexPath.row];
    
    int type = [dict[@"apType"]intValue];
    
    if (type==1) {
        
        WebViewController * wb = [WebViewController new];
        wb.url  = [PublicVoid getNewUrl:dict[@"apUrl"]];
        if ([wb.url isEqualToString:@""]||wb.url==nil) {
            
            [ZHHud initWithMessage:@"暂无页面"];
            return;
            
        }
        [self.collection.navigationController pushViewController:wb animated:YES];
        
     }
    
    
}




@end
