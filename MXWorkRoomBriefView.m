//
//  MXWorkRoomBriefView.m
//  MXNurse
//
//  Created by xiadalu on 2020/5/20.
//  Copyright © 2020 Beijing MeiXin Technology Co., Ltd. All rights reserved.
//

#import "MXWorkRoomBriefView.h"

@interface MXWorkRoomBriefView ()

@property(nonatomic,strong)UIView* backView;
@property(nonatomic,strong)UILabel* briefLabel;


@end

@implementation MXWorkRoomBriefView

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setUI];
    }
    return self;
}

-(void)setUI{
    self.backgroundColor = [UIColor whiteColor];
    WEAKSELF
    self.briefLabel = [PC_FactoryUI createLabelWithtextFont:14 textColor:UIColorMakeWithRGBA(153, 153, 153, 1) backGroundView:weakSelf text:@"" withBlock:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(15);
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-15);
    }];
    self.briefLabel.numberOfLines = 0;
}

-(void)configBriefModel:(MXWRBriefModel*)model selectedIndex:(NSInteger)selectedIndex{
    if (selectedIndex==0) {
        self.briefLabel.text = model.brief;
    }
    if (selectedIndex==1) {
        self.briefLabel.text = model.expertBrief;
    }
}

@end
