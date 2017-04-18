//
//  NavController.m
//  YCEducation
//
//  Created by zhou on 2017/3/6.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "NavController.h"

@interface NavController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView * tableView;
@property (nonatomic, strong) UIView *backView;

@property (nonatomic, assign) CGFloat headerHeight;
@property (nonatomic, strong) UIColor *backColor;

@property (nonatomic, strong) UIView *headerContentView;
@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) CGFloat scale;

@end

@implementation NavController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.headerHeight = 260;
    self.title = @"练市中学";
//    //去掉背景图片
//    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
//    //去掉底部线条
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];

    [self setTableView];
    
    //header
    CGRect bounds = CGRectMake(0, 0, WIDTH, self.headerHeight);
    UIView *contentView = [[UIView alloc] initWithFrame:bounds];
    contentView.backgroundColor = [UIColor blackColor];
    //背景
    UIImageView *headerImageView = [[UIImageView alloc] init];
    headerImageView.bounds = bounds;
    headerImageView.center = contentView.center;
    headerImageView.image = [UIImage imageNamed:@"backImage.jpg"];
    contentView.layer.masksToBounds = YES;
    
    self.headerImageView = headerImageView;
    self.headerContentView = contentView;
    [self.headerContentView addSubview:self.headerImageView];
    self.headerContentView.layer.masksToBounds = YES;
    
    //信息内容
    CGRect icon_frame = CGRectMake(12, self.headerContentView.bounds.size.height-80-12, 80, 80);
    UIImageView *icon = [[UIImageView alloc] initWithFrame:icon_frame];
    icon.backgroundColor = [UIColor clearColor];
    icon.image = [UIImage imageNamed:@"icon.jpg"];
    icon.layer.cornerRadius = 80/2.0f;
    icon.layer.masksToBounds = YES;
    icon.layer.borderWidth = 1.0f;
    icon.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.headerContentView addSubview:icon];
    self.icon = icon;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(108, self.headerContentView.bounds.size.height-60-12, WIDTH-108-12, 50)];
    label.text = @"这羡慕你们这些人, 年纪轻轻的就认识了才华横溢的我!";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont systemFontOfSize:15];
    label.numberOfLines = 0;
    self.label = label;
    [self.headerContentView addSubview:self.label];
    
    
    UIView *headerView = [[UIView alloc] initWithFrame:bounds];
    [headerView addSubview:self.headerContentView];
    self.tableView.tableHeaderView = headerView;;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];

}

- (void)setTableView
{
    self.tableView  = [[UITableView alloc]initWithFrame:CGRectMake(0, -64, WIDTH, HEIGHT+64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat offset_Y = scrollView.contentOffset.y;
    CGFloat alpha = (offset_Y + 40)/300.0f;
    self.backView.backgroundColor = [self.backColor colorWithAlphaComponent:alpha];
    NSLog(@"%f",offset_Y);
    if (offset_Y < -64) {
        //放大比例
        CGFloat add_topHeight = -(offset_Y+64);
        self.scale = (self.headerHeight+add_topHeight)/self.headerHeight;
        //改变 frame
        CGRect contentView_frame = CGRectMake(0, -add_topHeight, WIDTH, self.headerHeight+add_topHeight);
        self.headerContentView.frame = contentView_frame;
        CGRect imageView_frame = CGRectMake(-(WIDTH*self.scale-WIDTH)/2.0f,
                                            0,
                                            WIDTH*self.scale,
                                            self.headerHeight+add_topHeight);
        self.headerImageView.frame = imageView_frame;
        
        CGRect icon_frame = CGRectMake(12, self.headerContentView.bounds.size.height-80-12, 80, 80);
        self.icon.frame = icon_frame;
        
        self.label.frame = CGRectMake(108, self.headerContentView.bounds.size.height-60-12, WIDTH-108-12, 50);
        
    }
    
    if (offset_Y<=0&&offset_Y<=-90) {
        
        self.navigationController.navigationBar.alpha = 0;
        
    }else if(offset_Y<=500){
        
        self.navigationController.navigationBar.alpha = offset_Y/200;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
