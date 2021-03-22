//
//  ViewController.m
//  JCBreadCrumbView
//
//  Created by JuneCheng on 2021/3/22.
//

#import "ViewController.h"
#import "JCBreadCrumbView.h"

@interface ViewController ()

@property (nonatomic, strong) JCBreadCrumbView *breadCrumbView;///<

@property (nonatomic, strong) NSMutableArray<NSString *> *dataArray;///<

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"JCBreadCrumbView";
    
    [self.view addSubview:self.breadCrumbView];
    [self.breadCrumbView setTagWithTagArray:self.dataArray];
}

#pragma mark - Actions

/** 面包屑Action */
- (void)breadBrumbAction:(NSInteger)index {
    NSLog(@"index--->%ld",(long)index);
    
    self.dataArray = [[self.dataArray subarrayWithRange:NSMakeRange(0, index+1)] mutableCopy];
    [self.breadCrumbView setTagWithTagArray:self.dataArray];
    // 其他业务逻辑...
}

#pragma mark - 懒加载

- (JCBreadCrumbView *)breadCrumbView {
    if (!_breadCrumbView) {
        _breadCrumbView = [[JCBreadCrumbView alloc] initWithFrame:CGRectMake(0, 100, [[UIScreen mainScreen] bounds].size.width, 0)];
        _breadCrumbView.signalTagColor = [UIColor whiteColor];
        __weak typeof(self) weakSelf = self;
        [_breadCrumbView setDidselectItemBlock:^(NSInteger index, NSString *tagName) {
            [weakSelf breadBrumbAction:index];
        }];
    }
    return _breadCrumbView;
}

- (NSMutableArray<NSString *> *)dataArray {
    if (!_dataArray) {
        _dataArray = [@[@"中国",@"浙江省",@"杭州市",@"xx区",@"xxx街道",@"xxx公司"] mutableCopy];
    }
    return _dataArray;
}

@end
