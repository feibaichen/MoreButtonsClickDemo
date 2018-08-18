//
//  ViewController.m
//  MoreButtonsClickDemo
//
//  Created by MacOS on 2018/8/18.
//  Copyright © 2018年 MacOS. All rights reserved.
//

#import "ViewController.h"
#import "MoreButtonClickView.h"

@interface ViewController ()<MoreButtonClickViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    //综合 销量 价格 优惠
    MoreButtonClickView *moreButtonClickView = [[MoreButtonClickView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 40)];
    moreButtonClickView.delegate = self;
    [self.view addSubview:moreButtonClickView];
}

 -(void)chooseSeletedButtonFinalValue:(NSString *)finalValue{
     
   
     NSString *str = [NSString stringWithFormat:@"按钮 = %@",finalValue];
     NSLog(@"finalValue = %@",str);
 }
                                             
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
