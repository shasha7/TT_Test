//
//  UILabel+HCYLabelTapAction.h
//  TTTestProject
//
//  Created by hu hu on 2018/4/1.
//  Copyright © 2018年 hu hu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TestModel : NSObject

@property (nonatomic, copy) NSString *str;

@property (nonatomic, assign) NSRange range;

@end
@interface UILabel (HCYLabelTapAction)

/**
 *  是否打开点击效果，默认是打开
 */
//@property (nonatomic, assign) BOOL enabledTapEffect;

/**
 *  给文本添加点击事件Block回调
 *
 *  @param strings  需要添加的字符串数组
 *  @param tapClick 点击事件回调
 */
- (void)addAttributeTapActionWithStrings:(NSString *)keyString tapClicked:(void (^) (NSString *string , NSRange range , NSInteger index))tapClick;


@end
