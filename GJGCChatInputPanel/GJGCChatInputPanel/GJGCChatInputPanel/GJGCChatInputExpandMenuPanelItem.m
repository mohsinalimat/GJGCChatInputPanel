//
//  GJGCChatInputExpandMenuPanelItem.m
//  GJGroupChat
//
//  Created by ZYVincent on 14-10-28.
//  Copyright (c) 2014年 ZYProSoft. All rights reserved.
//

#import "GJGCChatInputExpandMenuPanelItem.h"

@interface GJGCChatInputExpandMenuPanelItem ()

@property (nonatomic,strong)UIButton *iconButton;

@property (nonatomic,strong)UILabel     *titleLabel;

@property (nonatomic,copy)GJGCChatInputExpandMenuPanelItemDidTapedBlock didTapBlock;

@end

@implementation GJGCChatInputExpandMenuPanelItem

#pragma mark - 生命周期

- (instancetype)init
{
    if (self = [super init]) {
        
        [self initSubViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self initSubViews];
    }
    return self;
}

+ (GJGCChatInputExpandMenuPanelItem *)itemWithTitle:(NSString *)title
                                      withIconImageNormal:(UIImage *)iconImageNormal
                             withIconImageHighlight:(UIImage *)iconImageHighlight
                                     withActionType:(GJGCChatInputMenuPanelActionType)actionType
                                         withTapBlock:(GJGCChatInputExpandMenuPanelItemDidTapedBlock)tapBlock
{
    GJGCChatInputExpandMenuPanelItem *item = [[self alloc]init];
    [item.iconButton setBackgroundImage:iconImageNormal forState:UIControlStateNormal];
    [item.iconButton setBackgroundImage:iconImageHighlight forState:UIControlStateHighlighted];
    item.titleLabel.text = title;
    item.actionType = actionType;
    item.didTapBlock = tapBlock;
    return item;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    /* 设置位置 */
    self.iconButton.frame = CGRectMake(5, 0, self.gjcf_width-10, self.gjcf_width-10);
    
    self.titleLabel.frame = CGRectMake(0,self.iconButton.gjcf_bottom+5,self.gjcf_width,self.gjcf_height - 5 - self.iconButton.gjcf_height);
    self.titleLabel.gjcf_centerX = self.gjcf_width/2;
}

#pragma mark - 内部接口

- (void)initSubViews
{
    self.iconButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self addSubview:self.iconButton];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.backgroundColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.titleLabel];
    
    [self addTarget:self action:@selector(tapOnSelf) forControlEvents:UIControlEventTouchUpInside];
    [self.iconButton addTarget:self action:@selector(tapOnSelf) forControlEvents:UIControlEventTouchUpInside];
}

- (void)tapOnSelf
{
    if (self.didTapBlock) {
        self.didTapBlock(self);
    }
}

@end
