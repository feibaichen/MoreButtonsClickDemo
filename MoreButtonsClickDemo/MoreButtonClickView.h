//
//  MoreButtonClickView.h
//  MoreButtonsClickDemo
//
//  Created by MacOS on 2018/8/18.
//  Copyright © 2018年 MacOS. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MoreButtonClickViewDelegate<NSObject>

//点击了哪一个按钮 通过传递字特定符串值来区分
- (void)chooseSeletedButtonFinalValue:(NSString *)finalValue;

@end

@interface MoreButtonClickView : UIView

//Delegate
@property(nonatomic,strong)id <MoreButtonClickViewDelegate>delegate;
//四个分类按钮 | 0,1,2,3,4,5
@property(nonatomic,strong)UIButton *sortSeletedButton;

@end
