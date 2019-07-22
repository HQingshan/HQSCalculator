//
//  ViewController.m
//  Calculator
//
//  Created by 你好帅 on 2019/7/19.
//  Copyright © 2019 你好帅. All rights reserved.
//

#import "ViewController.h"
#import "SDAutoLayout.h"
#import "HQSButton.h"

@interface ViewController ()

@property (nonatomic, strong) UIView *btnview;


@end

@implementation ViewController

- (UIView *)btnview{
    if (_btnview == NULL) {
        UIView *btnview = [[UIView alloc]init];
        
        [self.view addSubview:btnview];
        
        btnview.sd_layout.autoHeightRatio(1.25f).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).widthIs(300);
        
        btnview.backgroundColor = [UIColor whiteColor];
        _btnview = btnview;
    }
    
    return _btnview;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
    
    
    [self setupBtnView];
    
    
    
    
    
}

-(void)viewDidLayoutSubviews{
    
    
    NSLog(@"%f---------wfqvqwv",self.btnview.width);
    
    
}

- (void)viewWillLayoutSubviews{
    
//    btnview.sd_layout.autoHeightRatio(1.25f).rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).widthIs(300);
    
}

-(void)setupBtnView
{
    
    CGFloat btnsize = (self.btnview.width)/4.0f ;

    NSArray *signs = @[@"AC",@"⇦",@"%",@"÷"
                       ,@"7",@"8",@"9",@"×"
                       ,@"4",@"5",@"6",@"-"
                       ,@"1",@"2",@"3",@"+"
                       ,@"↹",@"0",@".",@"="];

    
//    HQSButton *FirstButton = [[HQSButton alloc ]init];
//    [self.btnview addSubview: FirstButton];
//    FirstButton.sd_layout.widthRatioToView(self.btnview, 0.25).autoHeightRatio(1).topSpaceToView(self.btnview, 0).leftSpaceToView(self.btnview, 0);
//
//    [FirstButton setSign: signs[0]];
    
    
//    NSLog(@"%f---------",FirstButton.width);
    NSLog(@"%f---------",self.btnview.width);
    
    for (int i = 0; i<signs.count; i++) {
        
        HQSButton *button = [[HQSButton alloc ]init];
        [self.btnview addSubview: button];
        button.sd_layout.widthRatioToView(self.btnview, 0.25).autoHeightRatio(1).topSpaceToView(self.btnview, (i/4)*btnsize).leftSpaceToView(self.btnview, (i%4)*btnsize);
        
        [button setSign: signs[i]];
    }
    
    
    
}
@end

