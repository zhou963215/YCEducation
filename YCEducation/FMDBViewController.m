//
//  FMDBViewController.m
//  YCEducation
//
//  Created by zhou on 2017/3/7.
//  Copyright © 2017年 zhou. All rights reserved.
//

#import "FMDBViewController.h"
#import <FMDB/FMDB.h>
@interface FMDBViewController ()
@property(nonatomic,strong) FMDatabase *db;
@property(nonatomic,strong) NSMutableArray * dataArr;
@end

@implementation FMDBViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //2.获得数据库
    _db = [FMDatabase databaseWithPath:[self creatSqlit]];
    self.dataArr = [NSMutableArray array];
    
    [self creatTable];
    [self insertData];
   
//    [self deletaAll];
  
    [self changeData];
    
    [self getData];
    
//    [self deletaAll];
    NSLog(@"%@",NSHomeDirectory());
    
    
 

}

//1.获得数据库文件的路径

- (NSString *)creatSqlit{
    
    
    NSString *doc =[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES)  lastObject];
    
    NSString *fileName = [doc stringByAppendingPathComponent:@"student.sqlite"];

    
    return fileName;
}

//创建表单

- (void)creatTable{
    
    //3.使用如下语句，如果打开失败，可能是权限不足或者资源不足。通常打开完操作操作后，需要调用 close 方法来关闭数据库。在和数据库交互 之前，数据库必须是打开的。如果资源或权限不足无法打开或创建数据库，都会导致打开失败。

    if ([_db open]&&![_db tableExists:@"t_student"])
    {
        
        //4.创表
        BOOL result = [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_student (id integer PRIMARY KEY AUTOINCREMENT, name text NOT NULL, age integer NOT NULL);"];
        if (result)
        {
            NSLog(@"创建表成功");
        }
    }

    [_db close];
    
    
}

//添加数据

- (void)insertData{
    
    
    if ([_db open]&&[_db tableExists:@"t_student"]){
  
    FMDatabaseQueue *queue = [FMDatabaseQueue databaseQueueWithPath:[self creatSqlit]];
    [queue inDatabase:^(FMDatabase *db) {
        
        
        [db executeUpdate:@"INSERT INTO t_student(name,age) VALUES (?,?)", @"Jack",@10];
        [db executeUpdate:@"INSERT INTO t_student(name,age) VALUES (?,?)", @"Rose",@11];
        [db executeUpdate:@"INSERT INTO t_student(name,age) VALUES (?,?)", @"Jim",@12];
        
    }];
    
    }
    
    [_db close];
}

- ( void)getData{
    

    if ([_db open]) {
        
        
        FMResultSet *result =  [_db executeQuery:@"select * from t_student"];
        
        // 从结果集里面往下找
        while ([result next]) {
            
            NSDictionary * dict=@{@"name":[result stringForColumn:@"name"],@"age":[result stringForColumn:@"age"]};
            
            [_dataArr addObject:dict];
        }
        
        
    }
    
    [_db close];

}


- (void)changeData{
    
    
    
    if ([_db open]) {
        
       [ _db executeUpdate:@"UPDATE t_student SET name = ? WHERE name = ?",@"123",@"Jack"];
                
    }
    
    [_db close];
}


- (void)deletaAll{
    
    
    
    if ([_db open]) {
        //删除表

//        [_db executeUpdate:@"DROP TABLE IF EXISTS t_student;"];
        //删除表内所有数据

        [_db executeUpdate:@"DELETE FROM t_student"];

    }
    
    [_db close];

    
    
    
    
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
