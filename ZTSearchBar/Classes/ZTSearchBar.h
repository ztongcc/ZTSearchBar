//
//  ZTSearchBar.h
//  SearchBar
//
//  Created by Jamis on 2020/10/12.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN





@class ZTSearchBar;

typedef NS_ENUM(NSInteger, ZTSearchStyle) {
    ZTSearchOvalStyle,
    ZTSearchRoundedStyle,
    ZTSearchCustomStyle
};

@protocol ZTSearchBarDelegate <UIBarPositioningDelegate>

@optional

- (BOOL)searchBarShouldBeginEditing:(ZTSearchBar *)searchBar;                      // return NO to not become first responder
- (void)searchBarTextDidBeginEditing:(ZTSearchBar *)searchBar;                     // called when text starts editing
- (BOOL)searchBarShouldEndEditing:(ZTSearchBar *)searchBar;                        // return NO to not resign first responder
- (void)searchBarTextDidEndEditing:(ZTSearchBar *)searchBar;                       // called when text ends editing
- (void)searchBar:(ZTSearchBar *)searchBar textDidChange:(NSString *)searchText;   // called when text changes (including clear)
- (BOOL)searchBar:(ZTSearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text API_AVAILABLE(ios(3.0)); // called before text changes

- (void)searchBarSearchButtonClicked:(ZTSearchBar *)searchBar;                     // called when keyboard search button pressed
- (void)searchBarCancelButtonClicked:(ZTSearchBar *)searchBar API_UNAVAILABLE(tvos);   // called when cancel button pressed

@end


@interface ZTSearchBarField : UITextField
// default is  CGSizeMake(16, 16);
@property (nonatomic, assign)CGSize searchIconSize;
// default UIEdgeInsetsMake(0, 12, 0, 6)
@property (nonatomic, assign)UIEdgeInsets iconInset;

@property (nonatomic, strong)UIImageView * icon;

@end




@interface ZTSearchBar : UIView

// 搜索框内边距  默认为 0
@property (nonatomic,   assign)UIOffset inputFieldOffset;

@property (nonatomic,   weak)id <ZTSearchBarDelegate> delegate;

@property (nonatomic,   assign)BOOL showsCancelButton;     // default is NO

@property (nonatomic,   assign)BOOL endEditingOnClickReturnKey;     // 点击键盘上的搜索时， 是否收起键盘 default is YES

@property (nonatomic, readonly)ZTSearchBarField * inputField;

@property (nonatomic, readonly)UIButton * cancelButton;

@property (nonatomic, readonly)UIImageView * inputFieldBackgroundImageView;

@property (nonatomic, copy)NSString * text;

- (instancetype)initWithFrame:(CGRect)frame stype:(ZTSearchStyle)style;

- (void)setShowsCancelButton:(BOOL)showCancelButton animated:(BOOL)animated;

- (void)addTapSearchBarHandler:(dispatch_block_t)handler;

@end

NS_ASSUME_NONNULL_END
