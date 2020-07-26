//
//  MXWRCommentHeaderView.h
//  MXNurse
//
//  Created by xiadalu on 2020/5/20.
//  Copyright © 2020 Beijing MeiXin Technology Co., Ltd. All rights reserved.
// 简介 + 用户评论度 = headerView

#import <UIKit/UIKit.h>
#import "MXSatisfactionModel.h"
#import "MXWorkRoomListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MXWRCommentHeaderView : UIView

@property(nonatomic,strong)NSArray<MXSatisfactionModel*>*satisArray;
@property(nonatomic,strong)MXWorkRoomListModel* model;

-(instancetype)initWithFrame:(CGRect)frame satisArray:(NSArray*)satisArray;


-(void)configWorkRoom:(MXWorkRoomListModel*)model selectedIndex:(NSInteger)selectedIndex;

@property(nonatomic,copy)void(^tableHeaderViewHeight)(CGFloat height);

@end

NS_ASSUME_NONNULL_END
