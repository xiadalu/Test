//
//  MXWRCommentHeaderView.m
//  MXNurse
//
//  Created by xiadalu on 2020/5/20.
//  Copyright © 2020 Beijing MeiXin Technology Co., Ltd. All rights reserved.
//

#import "MXWRCommentHeaderView.h"
#import <SGPagingView.h>
#import "MXWorkRoomBriefView.h"
#import "MXWRBriefModel.h"

@interface MXWRCommentHeaderView ()<SGPageTitleViewDelegate>

@property(nonatomic,strong)MXWorkRoomBriefView* briefView;

@property(nonatomic,strong)UIView* backView;
@property(nonatomic,strong)SGPageTitleView* pageTitleView;

@property(nonatomic,strong)UIView* lineView;

@end

@implementation MXWRCommentHeaderView


-(instancetype)initWithFrame:(CGRect)frame satisArray:(NSArray*)satisArray{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorMakeFromRGB(0xF5F5F5);
        _satisArray = satisArray;
        [self setUI];
        
    }
    return self;
}
//MARK: UI
-(void)setUI{
    WEAKSELF
    [self addSubview:self.briefView];
    
    self.backView = [PC_FactoryUI createViewWithColor:[UIColor whiteColor] cornerRadius:0 superView:weakSelf andBlock:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.briefView.mas_bottom).offset(10);
        make.left.right.bottom.mas_equalTo(weakSelf);
    }];
    
    UILabel* markLable = [PC_FactoryUI createLabelWithtextFont:14 textColor:UIColorMakeWithRGBA(51, 51, 51, 1.0) backGroundView:weakSelf.backView text:@"用户评价" withBlock:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.backView).offset(15);
        make.top.mas_equalTo(weakSelf.backView).offset(18);
    }];
    markLable.font = [UIFont fontWithName:@"PingFangSC-Medium" size:14];
    
    [self.backView addSubview:self.pageTitleView];
    
    [self.pageTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.backView);
        make.right.mas_equalTo(weakSelf.backView);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(markLable.mas_bottom).offset(5);
    }];
    
    [self addSubview:self.lineView];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(weakSelf);
        make.bottom.mas_equalTo(weakSelf.pageTitleView);
        make.height.mas_equalTo(0.5);
    }];
    
}
//MARK: 更新数据和高度
-(void)configWorkRoom:(MXWorkRoomListModel *)model selectedIndex:(NSInteger)selectedIndex{
    _model = model;
     MXWRBriefModel* briefModel = [self makeBriefModel:model];
    if (selectedIndex==0) {
        self.briefView.height = briefModel.allBriefHeight+30;
    }
    if (selectedIndex==1) {
        self.briefView.height = briefModel.allExpertBriefHeight+30;
    }
    [self.briefView configBriefModel:briefModel selectedIndex:selectedIndex];
    
    self.height = 90 + 10 + self.briefView.height;

    if (self.tableHeaderViewHeight) {
        self.tableHeaderViewHeight(self.height);
    }
}
//MARK: 生成BriefModel
-(MXWRBriefModel*)makeBriefModel:(MXWorkRoomListModel*)workRoomModel{
//    workRoomModel.expertBrief = @"都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据";
    MXWRBriefModel* briefModel = [[MXWRBriefModel alloc] init];
    briefModel.brief = workRoomModel.brief;
    briefModel.expertBrief = workRoomModel.expertBrief;
    CGFloat allBriefHeight = [NSString calculateWidthOrHeight:swj_screenWidth()-30 andBool:YES andStr:briefModel.brief andFond:fontValue(14)].height;
    if (allBriefHeight>100) {
        briefModel.briefHeight = 100;
    }else{
        briefModel.briefHeight = allBriefHeight;
    }
    briefModel.allBriefHeight = allBriefHeight;
    
    CGFloat allExpertBriefHeight = [NSString calculateWidthOrHeight:swj_screenWidth()-30 andBool:YES andStr:briefModel.expertBrief andFond:fontValue(14)].height;
    if (allExpertBriefHeight>100) {
        briefModel.expertBriefHeight = 100;
    }else{
        briefModel.expertBriefHeight = allExpertBriefHeight;
    }
    briefModel.allExpertBriefHeight = allExpertBriefHeight;
    
    return briefModel;
}

//MARK: 点击标题
- (void)pageTitleView:(SGPageTitleView *)pageTitleView selectedIndex:(NSInteger)selectedIndex {
}

//MARK: 懒加载pageTitleView
-(SGPageTitleView*)pageTitleView{
    if (!_pageTitleView) {
        NSMutableArray* titles = [[NSMutableArray alloc] init];
        for (MXSatisfactionModel*model in self.satisArray) {
            NSString* title = [NSString stringWithFormat:@"%@(%ld)",model.level,model.num];
            [titles addObject:title];
        }
        SGPageTitleViewConfigure* configure = [SGPageTitleViewConfigure pageTitleViewConfigure];
        configure.showIndicator = NO;
        configure.showBottomSeparator = NO;
        configure.titleColor = UIColorFromRGB(0x333333);
        configure.titleSelectedColor = UIColorFromRGB(0x9B70C2);
        configure.titleFont =fontValue(12);
        configure.titleSelectedFont = [UIFont fontWithName:@"PingFangSC-Medium" size:12];
        _pageTitleView = [SGPageTitleView pageTitleViewWithFrame:CGRectMake(0, 0, self.width, 40) delegate:self titleNames:titles configure:configure];
        _pageTitleView.backgroundColor = [UIColor clearColor];
        //后期开发点击效果的时候隐藏掉这段代码即可
        for (UIView* tempView in _pageTitleView.subviews) {
            if ([tempView isKindOfClass:[UIScrollView class]]) {
                UIScrollView* atempView = (UIScrollView*)tempView;
                for (UIButton* btn in (UIScrollView*)atempView.subviews) {
                    if ([btn isKindOfClass:[UIButton class]]) {
                        btn.userInteractionEnabled = NO;
                    }
                }
            }
        }
    }
    return _pageTitleView;
}

//MARK: 懒加载briefView
-(MXWorkRoomBriefView*)briefView{
    if (!_briefView) {
        _briefView = [[MXWorkRoomBriefView alloc] initWithFrame:CGRectMake(0, 0, swj_screenWidth(), 0)];
    }
    return _briefView;
}

-(UIView*)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = UIColorFromRGB(0xEEEEEE);
    }
    return _lineView;
}



@end
