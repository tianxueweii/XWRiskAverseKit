//
//  XWRiskAverseKitDemoViewController.m
//  XWRiskAverseKit
//
//  Created by tianxueweii on 08/17/2018.
//  Copyright (c) 2018 tianxueweii. All rights reserved.
//

#import "XWRiskAverseKitDemoViewController.h"

#define DemoTableCellIdentifier @"DemoTableCellIdentifier"
#define DemoTableCellTitleKey @"demo_title"
#define DemoTableCellBlockKey @"demo_block"

typedef void (^DemoTableCellBlock)(void);

@interface XWRiskAverseKitDemoViewController ()<UITableViewDelegate, UITableViewDataSource>

/** 列表 */
@property(nonatomic, strong)UITableView *tableView;

/** 列表数据 */
@property(nonatomic, strong)NSArray *tableViewDatas;

@end

@implementation XWRiskAverseKitDemoViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
}

#pragma mark - =========================Getter/Setter方法=========================


/**
 该位置添加名称及对应事件
 */
- (NSArray *)tableViewDatas{
    if (!_tableViewDatas) {
        _tableViewDatas = @[
//                            @{
//                                DemoTableCellTitleKey:@"<#列表项标题#>",
//                                DemoTableCellBlockKey:<#^(void)列表点击事件#>,
//                                },
                            ];
    }
    return _tableViewDatas;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height) style:UITableViewStylePlain];
        _tableView.rowHeight = 80.f;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:DemoTableCellIdentifier];
        
    }
    return _tableView;
}


#pragma mark - =========================UITableViewDelegate, UITableViewDataSource=========================

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.tableViewDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:DemoTableCellIdentifier forIndexPath:indexPath];
    
    cell.textLabel.text = self.tableViewDatas[indexPath.row][DemoTableCellTitleKey];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    DemoTableCellBlock block = self.tableViewDatas[indexPath.row][DemoTableCellBlockKey];
    if (block) {
        block();
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
