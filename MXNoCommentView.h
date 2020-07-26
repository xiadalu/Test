//
//  MXNoCommentView.h
//  MXNurse
//
//  Created by xiadalu on 2020/5/21.
//  Copyright © 2020 Beijing MeiXin Technology Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MXWorkRoomListModel.h"


NS_ASSUME_NONNULL_BEGIN

@interface MXNoCommentView : UIView


@property(nonatomic,strong)MXWorkRoomListModel* model;

-(void)configWorkRoom:(MXWorkRoomListModel*)model selectedIndex:(NSInteger)selectedIndex;

@property(nonatomic,copy)void(^tableHeaderViewHeight)(CGFloat height);

@end

NS_ASSUME_NONNULL_END
