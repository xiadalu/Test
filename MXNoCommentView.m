//
//  MXNoCommentView.m
//  MXNurse
//
//  Created by xiadalu on 2020/5/21.
//  Copyright © 2020 Beijing MeiXin Technology Co., Ltd. All rights reserved.
//

#import "MXNoCommentView.h"
#import "MXWRBriefModel.h"
#import "MXWorkRoomBriefView.h"

@interface MXNoCommentView ()

@property(nonatomic,strong)MXWorkRoomBriefView* briefView;

@property(nonatomic,strong)UIView* commentView;

@end

@implementation MXNoCommentView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorMakeFromRGB(0xF5F5F5);
        [self setUI];
    }
    return self;
}
//MARK: UI
-(void)setUI{
    
    [self addSubview:self.briefView];
    
    WEAKSELF
    self.commentView = [PC_FactoryUI createViewWithColor:[UIColor whiteColor] cornerRadius:0 superView:weakSelf andBlock:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.briefView.mas_bottom).offset(10);
        make.left.mas_equalTo(weakSelf);
        make.right.mas_equalTo(weakSelf);
        make.height.mas_equalTo(300);
    }];
    
//    UIImageView* starImageView = [PC_FactoryUI createImageViewWithView:weakSelf.commentView cornerRadius:0 imageName:@"星星" andMasoryBlock:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(weakSelf.commentView).offset(15);
//        make.top.mas_equalTo(weakSelf.commentView).offset(18);
//        make.width.height.mas_equalTo(16);
//    }];
//
    UILabel* markLable = [PC_FactoryUI createLabelWithtextFont:16 textColor:[UIColor blackColor] backGroundView:weakSelf.commentView text:@"用户评论" withBlock:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(weakSelf.commentView).offset(15);
        make.top.mas_equalTo(weakSelf.commentView).offset(18);
    }];
    
    UIImageView* noDataImageview = [PC_FactoryUI createImageViewWithView:weakSelf.commentView cornerRadius:0 imageName:@"kong" andMasoryBlock:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(weakSelf.commentView).offset(100);
        make.centerX.mas_equalTo(weakSelf.commentView);
        make.width.mas_equalTo(127);
        make.height.mas_equalTo(119);
    }];
    
    UILabel* noDataLabel = [PC_FactoryUI createLabelWithtextFont:14 textColor:UIColorFromRGB(0xCCCCCC) backGroundView:weakSelf.commentView text:@"暂无评论" withBlock:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(noDataImageview.mas_bottom).offset(20);
        make.centerX.mas_equalTo(noDataImageview);
    }];
}

//MARK: 更新数据和高度
-(void)configWorkRoom:(MXWorkRoomListModel *)model selectedIndex:(NSInteger)selectedIndex{
    _model = model;
//    model.expertBrief = @"都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据，都是一些测试数据";
     MXWRBriefModel* briefModel = [self makeBriefModel:model];
    if (selectedIndex==0) {
        self.briefView.height = briefModel.allBriefHeight + 30;
    }
    if (selectedIndex==1) {
        self.briefView.height = briefModel.allExpertBriefHeight + 30;
    }
    [self.briefView configBriefModel:briefModel selectedIndex:selectedIndex];
    
    self.height = self.commentView.height + 10 + self.briefView.height;

    if (self.tableHeaderViewHeight) {
        self.tableHeaderViewHeight(self.height);
    }
}

//MARK: 生成BriefModel
-(MXWRBriefModel*)makeBriefModel:(MXWorkRoomListModel*)workRoomModel{
    
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


//MARK: 懒加载briefView
-(MXWorkRoomBriefView*)briefView{
    if (!_briefView) {
        _briefView = [[MXWorkRoomBriefView alloc] initWithFrame:CGRectMake(0, 0, swj_screenWidth(), 0)];
    }
    return _briefView;
}


@end
