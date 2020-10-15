//
//  ZTTestController.m
//  ZTSearchBar_Example
//
//  Created by Jamis on 2020/10/15.
//  Copyright © 2020 Jemis. All rights reserved.
//

#import "ZTTestController.h"
#import <ZTSearchBar.h>

@interface ZTTestController ()

@property (nonatomic, copy)NSString * data;

@end

@implementation ZTTestController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGRect screenRect = [UIScreen mainScreen].bounds;

    ZTSearchBar * searchBar2 = [[ZTSearchBar alloc] initWithFrame:CGRectMake(0, 150, screenRect.size.width, 40) stype:ZTSearchCustomStyle];
    searchBar2.backgroundColor = [UIColor redColor];
    searchBar2.inputFieldBackgroundImageView.layer.cornerRadius = 10;
    searchBar2.inputFieldBackgroundImageView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    searchBar2.inputField.placeholder = @"搜索";
    searchBar2.inputFieldOffset = UIOffsetMake(10, 5);
    __weak typeof(self) weakself = self;
    [searchBar2 addTapSearchBarHandler:^{
        weakself.data = @"12313";
    }];
    [self.view addSubview:searchBar2];
    
}

- (void)dealloc {
    NSLog(@"%s", __func__);
}
@end
