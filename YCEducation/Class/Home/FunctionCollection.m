//
//  FunctionCollection.m
//  YCEducation
//
//  Created by zhou on 2017/3/15.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "FunctionCollection.h"
#import "ZHCCollectionViewCell.h"
#import "UIView+Controller.h"
#import "CYLTabBarController.h"
#import "HomeViewController.h"
#import "WebViewController.h"
#import "ZHHud.h"
@interface FunctionCollection ()
{
    BOOL _click;
    
}
@property(nonatomic,strong)UICollectionView * collection;
@property (nonatomic, weak) UICollectionViewFlowLayout *flowLayout;

@end


@implementation FunctionCollection

+(instancetype)share{
    
    return [[FunctionCollection alloc]init];
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
    flowLayout.itemSize = CGSizeMake((WIDTH-3)/4, 95);
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
    mainView.scrollEnabled= NO;
    [mainView registerClass:[ZHCCollectionViewCell class] forCellWithReuseIdentifier:@"collection"];
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
    ZHCCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collection" forIndexPath:indexPath];
    NSDictionary * dict = _apList[indexPath.row];
    
    [cell setDataWithDict:dict];

    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary * dict = _apList[indexPath.row];
    int type = [dict[@"apType"]intValue];
    if (type==1) {
        
        NSLog(@"%ld",(long)indexPath.row);
        
        
        WebViewController * web = [WebViewController new];
        web.url = [PublicVoid getNewUrl:dict[@"apUrl"]];
        if ([web.url isEqualToString:@""]||web.url==nil) {
            
            [ZHHud initWithMessage:@"暂无页面"];
            return;
            
        }
        
        
        [self.collection.navigationController pushViewController:web animated:YES];
        
        
    }
    else{
        
        [self.collection.navigationController cyl_popSelectTabBarChildViewControllerAtIndex:1];

        
    }
    
   

}




@end
