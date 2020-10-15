//
//  ZTSearchBar.m
//  SearchBar
//
//  Created by Jamis on 2020/10/12.
//

#import "ZTSearchBar.h"



static const CGFloat K_CANCEL_BUTTON_WIDTH = 50;

@interface ZTSearchBarField ()


@property (nonatomic, strong)UIView * iconContainer;

@end


@implementation ZTSearchBarField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup {
    _searchIconSize = CGSizeMake(16, 16);
    
    _iconInset = UIEdgeInsetsMake(0, 12, 0, 6);
    
    self.leftViewMode = UITextFieldViewModeAlways;
    self.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.returnKeyType = UIReturnKeySearch;

    self.placeholder = @"搜索";
    self.font = [UIFont systemFontOfSize:14];
    self.textColor = [UIColor blackColor];
    
    UIView * container = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 34, 16)];
    
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(12, 0, 16, 16)];
    icon.contentMode = UIViewContentModeScaleAspectFit;
    NSBundle *bundle = [NSBundle bundleForClass:[ZTSearchBar class]];
    NSURL *url = [bundle URLForResource:@"ZTSearchBar" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    NSString * iconName = [NSString stringWithFormat:@"searchBar_icon@%dx",(int)[UIScreen mainScreen].scale];
    NSString *path = [imageBundle pathForResource:iconName ofType:@"png"];
    
    icon.image = [UIImage imageWithContentsOfFile:path];
    [container addSubview:icon];
    
    self.leftView = container;
    
    self.iconContainer = container;
    self.icon = icon;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self fixIconLayout];
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    return [self fixedIconContainerFrame];
}

- (CGRect)fixedIconContainerFrame {
    CGRect frame = self.iconContainer.frame;
    frame.size.width = _searchIconSize.width + _iconInset.left + _iconInset.right;
    frame.size.height = _searchIconSize.height + _iconInset.top + _iconInset.bottom;
    frame.size.height = fmaxf(frame.size.height, CGRectGetHeight(self.bounds));
    return frame;
}

- (void)fixIconLayout {
    CGRect rect = [self fixedIconContainerFrame];
    rect.origin.x = _iconInset.left;
    rect.origin.y = (CGRectGetHeight(self.bounds) - _searchIconSize.height + _iconInset.top - _iconInset.bottom)/2;
    rect.size.width = _searchIconSize.width;
    rect.size.height = _searchIconSize.height;
    _icon.frame = rect;
}

- (void)setIconInset:(UIEdgeInsets)iconInset {
    if (!UIEdgeInsetsEqualToEdgeInsets(iconInset, _iconInset)) {
        _iconInset = iconInset;
        [self fixIconLayout];
    }
}


- (void)setSearchIconSize:(CGSize)searchIconSize {
    if (!CGSizeEqualToSize(searchIconSize, _searchIconSize)) {
        _searchIconSize = searchIconSize;
        [self fixIconLayout];
    }
}

@end







@interface ZTSearchBar ()<UITextFieldDelegate>
@property (nonatomic, assign)ZTSearchStyle style;

@property (nonatomic, strong)ZTSearchBarField * inputField;
@property (nonatomic, strong)UIButton * cancelButton;
@property (nonatomic, strong)UIImageView * inputFieldBackgroundImageView;


@end



@implementation ZTSearchBar


- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame stype:(ZTSearchStyle)style {
    self = [super initWithFrame:frame];
    if (self) {
        self.style = style;
        [self commonInit];
    }
    return self;
}

- (void)didMoveToSuperview {
    [super didMoveToSuperview];
    [self updateSubViewsLayout];
    [self updateInputContainerBackgroundCorner];
}

- (void)updateSubViewsLayout {
    CGRect searchFieldRect = CGRectInset(self.bounds, _inputFieldOffset.horizontal, _inputFieldOffset.vertical);
    if (_showsCancelButton) {
        searchFieldRect.size.width -= K_CANCEL_BUTTON_WIDTH;
    }
    CGRect cancelButtonRect = CGRectZero;
    cancelButtonRect.origin.x = CGRectGetMaxX(searchFieldRect);
    cancelButtonRect.size.width = K_CANCEL_BUTTON_WIDTH;
    cancelButtonRect.size.height = CGRectGetHeight(self.bounds);
    
    self.cancelButton.hidden = !_showsCancelButton;
    self.inputFieldBackgroundImageView.frame = searchFieldRect;
    self.inputField.frame = searchFieldRect;
    self.cancelButton.frame = cancelButtonRect;
}

- (void)updateInputContainerBackgroundCorner {
    if (_style == ZTSearchOvalStyle) {
        self.inputFieldBackgroundImageView.layer.cornerRadius = CGRectGetHeight(_inputField.bounds)/2;
        self.inputFieldBackgroundImageView.layer.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1].CGColor;
    }else if (_style == ZTSearchRoundedStyle) {
        self.inputFieldBackgroundImageView.layer.cornerRadius = 6;
        self.inputFieldBackgroundImageView.layer.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1].CGColor;
    }
}

- (void)setShowsCancelButton:(BOOL)showsCancelButton animated:(BOOL)animated {
    _showsCancelButton = showsCancelButton;
    CGRect searchFieldRect = CGRectInset(self.bounds, _inputFieldOffset.horizontal, _inputFieldOffset.vertical);
    
    if (showsCancelButton) {
        self.cancelButton.hidden = NO;
        searchFieldRect.size.width -= K_CANCEL_BUTTON_WIDTH;
    }
    CGRect cancelButtonRect = CGRectZero;
    cancelButtonRect.origin.x = CGRectGetMaxX(searchFieldRect);
    cancelButtonRect.size.width = K_CANCEL_BUTTON_WIDTH;
    cancelButtonRect.size.height = CGRectGetHeight(self.bounds);
    
    [UIView animateWithDuration:animated?0.15:0.01 animations:^{
        self.inputFieldBackgroundImageView.frame = searchFieldRect;
        self.inputField.frame = searchFieldRect;
        self.cancelButton.frame = cancelButtonRect;
    } completion:^(BOOL finished) {
        self.cancelButton.hidden = !showsCancelButton;
    }];
}

- (void)commonInit {
    self.endEditingOnClickReturnKey = YES;
    
    [self addSubview:self.inputFieldBackgroundImageView];
    [self addSubview:self.inputField];
    [self addSubview:self.cancelButton];
}

- (void)onCancel:(UIButton *)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarCancelButtonClicked:)]) {
        [self.delegate searchBarCancelButtonClicked:self];
    }
    [self.inputField resignFirstResponder];
}

- (void)onInputFieldEditingDidEndOnExit:(ZTSearchBarField *)field {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarSearchButtonClicked:)]) {
        return [self.delegate searchBarSearchButtonClicked:self];
    }
}

#pragma mark - textField delegate -

- (BOOL)textFieldShouldReturn:(ZTSearchBarField *)textField {
    return self.endEditingOnClickReturnKey;
}

- (void)textFieldDidChangeSelection:(ZTSearchBarField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:textDidChange:)]) {
        return [self.delegate searchBar:self textDidChange:textField.text];
    }
}

- (BOOL)textFieldShouldBeginEditing:(ZTSearchBarField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldBeginEditing:)]) {
        return [self.delegate searchBarShouldBeginEditing:self];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(ZTSearchBarField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidBeginEditing:)]) {
        [self.delegate searchBarTextDidBeginEditing:self];
    }
}

- (BOOL)textFieldShouldEndEditing:(ZTSearchBarField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarShouldEndEditing:)]) {
        return [self.delegate searchBarShouldEndEditing:self];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(ZTSearchBarField *)textField {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBarTextDidEndEditing:)]) {
        [self.delegate searchBarTextDidEndEditing:self];
    }
}

- (BOOL)textField:(ZTSearchBarField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchBar:shouldChangeTextInRange:replacementText:)]) {
        return [self.delegate searchBar:self shouldChangeTextInRange:range replacementText:string];
    }
    return YES;
}

- (void)setText:(NSString *)text {
    self.inputField.text = text;
}

- (NSString *)text {
    return self.inputField.text;
}

#pragma mark - getter -
- (ZTSearchBarField *)inputField {
    if (!_inputField) {
        _inputField = [[ZTSearchBarField alloc] init];
        [_inputField addTarget:self action:@selector(onInputFieldEditingDidEndOnExit:) forControlEvents:UIControlEventEditingDidEndOnExit];
        _inputField.delegate = self;
    }
    return _inputField;
}

- (UIButton *)cancelButton {
    if (!_cancelButton) {
        _cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        _cancelButton.adjustsImageWhenHighlighted = YES;
        _cancelButton.adjustsImageWhenDisabled = YES;
        [_cancelButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
        _cancelButton.hidden = YES;
    }
    return _cancelButton;
}

- (UIImageView *)inputFieldBackgroundImageView {
    if (!_inputFieldBackgroundImageView) {
        _inputFieldBackgroundImageView = [[UIImageView alloc] init];
    }
    return _inputFieldBackgroundImageView;
}
@end
