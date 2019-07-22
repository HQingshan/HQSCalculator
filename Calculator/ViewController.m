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

@property (nonatomic, strong) UIView *ButtonView;

@property (nonatomic, strong) UIView *MoreButtonView;

@property (nonatomic, strong) UIView *AnswerView;

@property (nonatomic, strong) UIScrollView *Secondline;

@property (nonatomic, strong) UIScrollView *Firstline;


@end

@implementation ViewController

-(UIView *)AnswerView{
    if (_AnswerView == NULL) {
        UIView *AnswerView = [[UIView alloc ]init];
        [self.view addSubview:AnswerView];
//        AnswerView.backgroundColor = [UIColor greenColor];
        
        _AnswerView = AnswerView;
        
    }
    
    return _AnswerView;
    
}

-(UIScrollView *)Secondline{
    if (_Secondline == NULL) {
        UIScrollView *Secondline = [[UIScrollView alloc ]init];
        [self.AnswerView addSubview:Secondline];

        _Secondline = Secondline;
        
    }
    
    return _Secondline;
    
}

-(UIScrollView *)Firstline{
    if (_Firstline == NULL) {
        UIScrollView *Firstline = [[UIScrollView alloc ]init];
        [self.AnswerView addSubview:Firstline];
        Firstline.backgroundColor = [UIColor colorWithRed:246.0f/255.0f green:249.0f/255.0f blue:243.0f/255.0f alpha:1];
        
        _Firstline = Firstline;
        
    }
    
    return _Firstline;
    
}

- (UIView *)MoreButtonView{
    if (_MoreButtonView == NULL) {
        UIView *MoreButtonView = [[UIView alloc ]init];
        [self.view addSubview:MoreButtonView];
        MoreButtonView.backgroundColor = [UIColor greenColor];
        
        
        
        _MoreButtonView = MoreButtonView;
        
    }
    
    return _MoreButtonView;
}

- (UIView *)ButtonView{

    if (_ButtonView == NULL) {
        UIView *ButtonView = [[UIView alloc]init];
        
        [self.view addSubview:ButtonView];
        
        ButtonView.backgroundColor = [UIColor whiteColor];
        _ButtonView = ButtonView;
        
    }
    
    return _ButtonView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor =  [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
    
    
    [self setupBottonView];
    [self setupAnswerView];
    
//    NSLog(@"屏幕高----%f/n屏幕宽----%F",[UIScreen mainScreen].bounds.size.height,[UIScreen mainScreen].bounds.size.width);
//    NSLog(@"----%f----",self.view.height);
}



- (void)viewWillLayoutSubviews{

    //1.获取到屏幕旋转的方向
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    //2.根据屏幕旋转方向布局子视图
    switch (orientation) {
            //竖直方向
        case UIDeviceOrientationPortrait:
            //倒立
        case UIDeviceOrientationPortraitUpsideDown:
        {
            self.ButtonView.sd_layout.rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).autoHeightRatio(1.25f).widthIs(self.view.width_sd);
            
            self.AnswerView.sd_layout.bottomSpaceToView(self.ButtonView, 0).rightEqualToView(self.view).leftEqualToView(self.view).topSpaceToView(self.view, 44);
            
            self.Firstline.sd_layout.heightRatioToView(self.AnswerView, 0.5f).widthRatioToView(self.AnswerView, 1).bottomEqualToView(self.AnswerView);

            
            self.Secondline.sd_layout.heightRatioToView(self.AnswerView, 0.5f).widthRatioToView(self.AnswerView, 1).topEqualToView(self.AnswerView);
            
            self.MoreButtonView.hidden =YES;
        }
            break;

            //右横屏
        case UIDeviceOrientationLandscapeRight:
            //左横屏
        case UIDeviceOrientationLandscapeLeft:
        {
            self.ButtonView.sd_resetLayout.rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).widthRatioToView(self.view, 0.4f).heightRatioToView(self.view,0.7f);
            
            self.MoreButtonView.hidden =NO;
            self.MoreButtonView.sd_layout.bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.ButtonView, 0).heightRatioToView(self.view,0.7f);

        }
            break;

        default:
            break;
    }


}


- (void)setupAnswerView{

    
}

-(void)setupBottonView
{

    NSArray *signs = @[@[@"AC",@"⇦",@"%",@"÷"]
                       ,@[@"7",@"8",@"9",@"×"]
                       ,@[@"4",@"5",@"6",@"-"]
                       ,@[@"1",@"2",@"3",@"+"]
                       ,@[@"↹",@"0",@".",@"="]];

    
    UIView *line1 = [[UIView alloc] init ];
    [self.ButtonView addSubview:line1];
    line1.sd_layout.heightRatioToView(self.ButtonView, 0.2).leftSpaceToView(self.ButtonView, 0).rightSpaceToView(self.ButtonView, 0).topSpaceToView(self.ButtonView, 0);
    [self setLineView:line1 forArr:signs[0]];
    
    UIView *line2 = [[UIView alloc] init ];
    [self.ButtonView addSubview:line2];
    line2.sd_layout.heightRatioToView(self.ButtonView, 0.2).leftSpaceToView(self.ButtonView, 0).rightSpaceToView(self.ButtonView, 0).topSpaceToView(line1, 0);
    [self setLineView:line2 forArr:signs[1]];
    
    UIView *line3 = [[UIView alloc] init ];
    [self.ButtonView addSubview:line3];
    line3.sd_layout.heightRatioToView(self.ButtonView, 0.2).leftSpaceToView(self.ButtonView, 0).rightSpaceToView(self.ButtonView, 0).topSpaceToView(line2, 0);
    [self setLineView:line3 forArr:signs[2]];
    
    
    UIView *line4 = [[UIView alloc] init ];
    [self.ButtonView addSubview:line4];
    line4.sd_layout.heightRatioToView(self.ButtonView, 0.2).leftSpaceToView(self.ButtonView, 0).rightSpaceToView(self.ButtonView, 0).topSpaceToView(line3, 0);
    [self setLineView:line4 forArr:signs[3]];
    
    UIView *line5 = [[UIView alloc] init ];
    [self.ButtonView addSubview:line5];
    line5.sd_layout.heightRatioToView(self.ButtonView, 0.2).leftSpaceToView(self.ButtonView, 0).rightSpaceToView(self.ButtonView, 0).topSpaceToView(line4, 0);
    [self setLineView:line5 forArr:signs[4]];

    
}

-(void)setLineView:(UIView *)lineview forArr: (NSArray *)signs{
    
    HQSButton *button1 = [[HQSButton alloc ]init];
    [lineview addSubview: button1];
    button1.sd_layout.widthRatioToView(self.ButtonView, 0.25).topSpaceToView(lineview, 0).leftSpaceToView(lineview, 0).bottomSpaceToView(lineview, 0);
    [button1 setSign: signs[0]];
    
    HQSButton *button2 = [[HQSButton alloc ]init];
    [lineview addSubview: button2];
    button2.sd_layout.widthRatioToView(self.ButtonView, 0.25).topSpaceToView(lineview, 0).leftSpaceToView(button1, 0).bottomSpaceToView(lineview, 0);
    [button2 setSign: signs[1]];
    
    HQSButton *button3 = [[HQSButton alloc ]init];
    [lineview addSubview: button3];
    button3.sd_layout.widthRatioToView(self.ButtonView, 0.25).topSpaceToView(lineview, 0).leftSpaceToView(button2, 0).bottomSpaceToView(lineview, 0);
    [button3 setSign: signs[2]];
    
    HQSButton *button4 = [[HQSButton alloc ]init];
    [lineview addSubview: button4];
    button4.sd_layout.widthRatioToView(self.ButtonView, 0.25).topSpaceToView(lineview, 0).leftSpaceToView(button3, 0).bottomSpaceToView(lineview, 0);
    [button4 setSign: signs[3]];
    
    
    
    
}

@end

