//
//  ZTViewController.m
//  ZTSearchBar
//
//  Created by Jemis on 10/14/2020.
//  Copyright (c) 2020 Jemis. All rights reserved.
//

#import "ZTViewController.h"
#import <ZTSearchBar.h>

@interface ZTViewController ()

@property (nonatomic, strong)ZTSearchBar * searchBar;

@end

@implementation ZTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect screenRect = [UIScreen mainScreen].bounds;
    
    ZTSearchBar * searchBar = [[ZTSearchBar alloc] initWithFrame:CGRectMake(0, 150, screenRect.size.width, 50) stype:ZTSearchOvalStyle];
    searchBar.inputField.placeholder = @"搜索";
    searchBar.inputFieldOffset = UIOffsetMake(10, 10);
    searchBar.endEditingOnClickReturnKey = NO;
    searchBar.delegate = (id)self;
    [self.view addSubview:searchBar];
    self.searchBar = searchBar;
    
    
    ZTSearchBar * searchBar1 = [[ZTSearchBar alloc] initWithFrame:CGRectMake(0, 250, screenRect.size.width, 50) stype:ZTSearchRoundedStyle];
    searchBar1.inputField.placeholder = @"搜索";
    searchBar1.inputFieldOffset = UIOffsetMake(10, 10);
    searchBar1.endEditingOnClickReturnKey = NO;
    searchBar1.delegate = (id)self;
    [self.view addSubview:searchBar1];

    
    ZTSearchBar * searchBar2 = [[ZTSearchBar alloc] initWithFrame:CGRectMake(0, 350, screenRect.size.width, 50) stype:ZTSearchCustomStyle];
    searchBar2.backgroundColor = [UIColor orangeColor];
    searchBar2.inputFieldBackgroundImageView.layer.cornerRadius = 10;
    searchBar2.inputFieldBackgroundImageView.layer.backgroundColor = [UIColor redColor].CGColor;
    searchBar2.inputField.placeholder = @"搜索";
    searchBar2.inputFieldOffset = UIOffsetMake(10, 5);
    [searchBar2 addTapSearchBarHandler:^{
        [self performSegueWithIdentifier:@"detail" sender:nil];
    }];
    [self.view addSubview:searchBar2];
    
    
    
    UISearchBar * se = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 450, screenRect.size.width, 50)];
    se.delegate = (id)self;
    se.tag = 1000;
    se.returnKeyType = UIReturnKeySearch;
    se.searchBarStyle = UISearchBarStyleMinimal;
    [self.view addSubview:se];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}


- (BOOL)searchBarShouldBeginEditing:(ZTSearchBar *)searchBar {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
    [searchBar setShowsCancelButton:YES animated:YES];
    return YES;
}                      // return NO to not become first responde
- (void)searchBarTextDidBeginEditing:(ZTSearchBar *)searchBar {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
//    [searchBar setShowsCancelButton:YES animated:YES];
}                     // called when text starts editin
- (BOOL)searchBarShouldEndEditing:(ZTSearchBar *)searchBar {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
    return YES;
}                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(ZTSearchBar *)searchBar {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
    [searchBar setShowsCancelButton:NO animated:YES];
}
- (void)searchBar:(ZTSearchBar *)searchBar textDidChange:(NSString *)searchText {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
}   // called when text changes (including clear)
- (BOOL)searchBar:(ZTSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text API_AVAILABLE(ios(3.0)) {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
    return YES;
} // called before text changes

- (void)searchBarSearchButtonClicked:(ZTSearchBar *)searchBar {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
}                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(ZTSearchBar *)searchBar API_UNAVAILABLE(tvos) {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
}  // called when cancel button pressed

- (void)searchBar:(ZTSearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope API_AVAILABLE(ios(3.0)) {
    NSLog(@"%ld, %s",searchBar.tag , __func__);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
