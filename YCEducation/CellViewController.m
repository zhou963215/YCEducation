//
//  CellViewController.m
//  YCEducation
//
//  Created by zhou on 2017/2/24.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "CellViewController.h"
#import "ZHPickerCell.h"
#import "ZHDateCell.h"
#import "NSDate+util.h"
#import "AdressSelectCell.h"
#import "InputTableViewCell.h"
#import "SubjectTableViewCell.h"
@interface CellViewController ()
{
    CGFloat  _cellHeight;

}
@property(nonatomic,strong)ZHPickerCell * pickerCell;
@property(nonatomic,strong)ZHDateCell *dateCell;
@property(nonatomic,strong)AdressSelectCell * adressCell;
@property(nonatomic,strong)InputTableViewCell * inputCell;
@property(nonatomic,strong)SubjectTableViewCell * subjectCell;
@property(nonatomic,strong)NSArray * rows;

@end

@implementation CellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.rows = @[self.pickerCell,self.dateCell,self.adressCell,self.inputCell,self.subjectCell];

    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];

    self.navigationItem.hidesBackButton = YES;


}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if(indexPath.row==4){
        
        return _cellHeight?_cellHeight:85;
    }
    return 44;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.rows.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
     return self.rows[(NSUInteger)indexPath.row];
}
- (ZHPickerCell *)pickerCell {
    if(!_pickerCell){
        _pickerCell = [[ZHPickerCell alloc] initWithRowsAndValues:@{@"a":@1, @"b":@2, @"c":@3}];
        _pickerCell.textLabel.text = @"picker";
        [_pickerCell setTitle:@"c" withValue:@3];
        _pickerCell.key = @"picker";
        //        [_pickerCell showSearchBar];
    }
    return _pickerCell;
}
- (ZHDateCell *)dateCell {
    if(!_dateCell){
        _dateCell = [[ZHDateCell alloc] init];
        _dateCell.textLabel.text = @"date";
        _dateCell.fromNow = YES;
        _dateCell.showDate = YES;
        _dateCell.dateFormat = @"yyyy-MM-dd";
        NSDate* data = [NSDate dateWithString:@"2015-11-11"];
        [_dateCell setTitle:@"2015-10-20" withValue:data];
        _dateCell.key = @"date";
        _dateCell.disabled = NO;
    }
    return _dateCell;
}
- (AdressSelectCell *)adressCell{
    
    if (!_adressCell) {
        
        _adressCell = [[AdressSelectCell alloc]init];
        _adressCell.textLabel.text= @"省市区";
        _adressCell.label.text = @"请选择省市区";
        [_adressCell updateAddressWithProvince:@"浙江省" city:@"杭州市" town:@"西湖区"];
        
    }
    
    return _adressCell;
    
}

- (InputTableViewCell*)inputCell{
    
    if (!_inputCell) {
        
        _inputCell = [[InputTableViewCell alloc]initWithValue:@"123" tip:@"123" title:@"标题"];
        [_inputCell editStyle:YES];

        [_inputCell addRightLBWithTitle:@"元"];
    }
    
    return _inputCell;
}


- (SubjectTableViewCell *)subjectCell{
    
    if (!_subjectCell) {
         WEAKSELF(wk);
        _subjectCell = [[SubjectTableViewCell alloc]initWithTitle:@"还是个标题" subject:@"" height:40];
        
        _subjectCell.UPHeight =  ^void(CGFloat heihgt){
            
            _cellHeight = heihgt;
            
            [wk roload];
        };

        
    }
    return _subjectCell;
    
}
- (void)roload{
    
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:1 inSection:0];
    
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
