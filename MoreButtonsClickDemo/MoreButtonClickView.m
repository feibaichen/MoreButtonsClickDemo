//
//  MoreButtonClickView.m
//  MoreButtonsClickDemo
//
//  Created by MacOS on 2018/8/18.
//  Copyright © 2018年 MacOS. All rights reserved.
//

#import "MoreButtonClickView.h"
#import "SDAutoLayout.h"

#define MakeColor(r, g, b) [UIColor colorWithRed:(r) / 255.0 green:(g) / 255.0 blue:(b) / 255.0 alpha:1.0]
#define FONT(font_size) [UIFont systemFontOfSize:font_size]
#define FONT_Bold(font_size) [UIFont boldSystemFontOfSize:font_size]

@interface MoreButtonClickView ()

//底部 细线
@property(nonatomic,strong)UIView *sortSeletedBottomLine;
//底部 红色滚动条
@property(nonatomic,strong)UIView *sortSeletedBottomRedScrollLine;
//button seleted 通过额外的selectedBtn 让四个button 可以只选择其中一个
@property(nonatomic,strong)UIButton *selectedBtn;
//对外传递 哪一个button被点击的Str值
@property(nonatomic,assign)int selectedButtonFinalStr;

@end

@implementation MoreButtonClickView

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor blackColor];
        self.userInteractionEnabled = YES;
        //默认选择“综合”按钮
        _selectedButtonFinalStr = 0;
        [self setUI];
    }
    return self;
}

- (void)setUI{
    
    CGFloat btnWidth = self.frame.size.width / 4;
    NSArray *btnTitleArray = @[@"综合",@"销量",@"优惠",@"价格"];
    
    //循环创建四个button
    for (int i = 0; i < 4 ; i++) {
        
        _sortSeletedButton = [[UIButton alloc] initWithFrame:CGRectMake( btnWidth * i, 0, btnWidth, 40)];
        [_sortSeletedButton setTitle:btnTitleArray[i] forState:UIControlStateNormal];
        _sortSeletedButton.titleLabel.font = FONT_Bold(14);
        [_sortSeletedButton setTitleColor: MakeColor(150, 150, 150) forState:UIControlStateNormal];
        [_sortSeletedButton setTitleColor: MakeColor(255, 60, 30) forState:UIControlStateSelected];
        
        if (i == 3) {
            //第四个按钮添加 点击状态布局
            [_sortSeletedButton setImage:[UIImage imageNamed:@"search_icon_no"] forState:UIControlStateNormal];
            
            //添加右侧图片、左侧文字 布局
            [_sortSeletedButton setTitleEdgeInsets:UIEdgeInsetsMake(0, - _sortSeletedButton.imageView.image.size.width, 0, _sortSeletedButton.imageView.image.size.width)];
            [_sortSeletedButton setImageEdgeInsets:UIEdgeInsetsMake(0, _sortSeletedButton.titleLabel.bounds.size.width, 0, -_sortSeletedButton.titleLabel.bounds.size.width)];
        }
        
        [self addSubview:_sortSeletedButton];
        //添加点击事件
        [_sortSeletedButton addTarget:self action:@selector(sortSeletedButtonWasClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //底部 整条细线
    _sortSeletedBottomLine = [[UIView alloc] init];
    _sortSeletedBottomLine.backgroundColor = MakeColor(230, 230, 230);
    [self addSubview:_sortSeletedBottomLine];
    
    _sortSeletedBottomLine.sd_layout.bottomEqualToView(self).leftEqualToView(self).rightEqualToView(self).heightIs(0.5);
    
    //底部 滚动的菜单红条
    _sortSeletedBottomRedScrollLine = [[UIView alloc] init];
    _sortSeletedBottomRedScrollLine.backgroundColor = MakeColor(255, 60, 30);
    
    //NSLog(@"%lf",_searchSortSeletedButton.titleLabel.size.height);
    
    //遍历self 的subviews子视图 给第一个按钮传递一个默认点击事件 默认添加到第一个按钮上
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)view;
            if ([btn.titleLabel.text isEqualToString:@"综合"]) {
                [btn sendActionsForControlEvents:UIControlEventTouchUpInside];
            }
        }
    }
    
}

#pragma mark - button 被点击事件
- (void)sortSeletedButtonWasClick:(UIButton *)buttton{
    
    //NSLog(@"buttton.titleLabel.text = %@",buttton.titleLabel.text);
    
    if (buttton!= self.selectedBtn) {
        
        self.selectedBtn.selected = NO;
        buttton.selected = YES;
        self.selectedBtn = buttton;
        
        //点击哪一个buttton就添加 红色线条 到哪一个buttton上
        [buttton addSubview:_sortSeletedBottomRedScrollLine];
        _sortSeletedBottomRedScrollLine.sd_layout.bottomEqualToView(buttton).centerXIs(buttton.frame.size.width/2).heightIs(2).widthIs(20);
        
        
        //遍历self 的subviews子视图 查找"价格"按钮是否时当前被点击的按钮 若不是则切换图片
        for (UIView *view in self.subviews) {
            if ([view isKindOfClass:[UIButton class]]) {
                UIButton *btn = (UIButton *)view;
                if ([btn.titleLabel.text isEqualToString:@"价格"] && ![buttton.titleLabel.text isEqualToString:@"价格"]) {
                    [_sortSeletedButton setImage:[UIImage imageNamed:@"search_icon_no"] forState:UIControlStateNormal];
                }
            }
        }
        
    }else{
        
        self.selectedBtn.selected = YES;
    }
    
    //判断点击了哪一个button
    
    if ([buttton.titleLabel.text isEqualToString:@"综合"]) {
        _selectedButtonFinalStr = 0;
    }
    
    if ([buttton.titleLabel.text isEqualToString:@"销量"]) {
        _selectedButtonFinalStr = 1;
    }
    
    if ([buttton.titleLabel.text isEqualToString:@"优惠"]) {
        _selectedButtonFinalStr = 2;
    }
    
    //价格button 的三张图片切换
    if ([buttton.titleLabel.text isEqualToString:@"价格"]) {
        
        if ([buttton.currentImage isEqual:[UIImage imageNamed:@"search_icon_no"]]) {
            
            [buttton setImage:[UIImage imageNamed:@"search_icon_up"] forState:UIControlStateNormal];
            _selectedButtonFinalStr = 3;
            
        }else if ([buttton.currentImage isEqual:[UIImage imageNamed:@"search_icon_up"]]){
            
            [buttton setImage:[UIImage imageNamed:@"search_icon_down"] forState:UIControlStateNormal];
            _selectedButtonFinalStr = 4;
        }else{
            
            [buttton setImage:[UIImage imageNamed:@"search_icon_up"] forState:UIControlStateNormal];
            _selectedButtonFinalStr = 3;
        }
    }
    //对外传递点击区分按钮的事件
    [_delegate chooseSeletedButtonFinalValue:[NSString stringWithFormat:@"%d",_selectedButtonFinalStr]];
}


@end
