//
//  ViewController.m
//  Calculator
//
//  Created by 你好帅 on 2019/7/19.
//  Copyright © 2019 你好帅. All rights reserved.
//
#import <sys/utsname.h>
#import "ViewController.h"
#import "SDAutoLayout.h"
#import "HQSButton.h"
#import "HQS_Label.h"
#import "Calculate.h"


#define ScrH [UIScreen mainScreen].bounds.size.height

CGFloat Liuhai = 0;

@interface ViewController ()

@property (nonatomic, strong) UIView *ButtonView;

@property (nonatomic, strong) UIView *MoreButtonView;

@property (nonatomic, strong) UIView *AnswerView;

@property (nonatomic, strong) UIScrollView *Secondline;

@property (nonatomic, strong) UIScrollView *Firstline;

@property (nonatomic, strong) HQS_Label *Secondlabel;

@property (nonatomic, strong) HQS_Label *Firstlabel;

//@property (nonatomic, strong) CGFloat *Liuhai;


@end

@implementation ViewController

- (HQS_Label *)Secondlabel{
    if (_Secondlabel == NULL) {
        HQS_Label *Secondlabel = [[HQS_Label alloc ]init];
        [self.Secondline addSubview:Secondlabel];
        
        _Secondlabel = Secondlabel;
        
    }
    
    return _Secondlabel;
    
}

- (HQS_Label *)Firstlabel{
    if (_Firstlabel == NULL) {
        HQS_Label *Firstlabel = [[HQS_Label alloc ]init];
        [self.Firstline addSubview:Firstlabel];
        
        _Firstlabel = Firstlabel;
        
    }
    
    return _Firstlabel;
}

-(UIView *)AnswerView{
    if (_AnswerView == NULL) {
        UIView *AnswerView = [[UIView alloc ]init];
        [self.view addSubview:AnswerView];

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
        Firstline.backgroundColor = [UIColor colorWithRed:240.0f/255.0f green:240.0f/255.0f blue:240.0f/255.0f alpha:1];
        
        _Firstline = Firstline;
        
    }
    
    return _Firstline;
    
}

- (UIView *)MoreButtonView{
    if (_MoreButtonView == NULL) {
        UIView *MoreButtonView = [[UIView alloc ]init];
        [self.view addSubview:MoreButtonView];
        MoreButtonView.backgroundColor = [UIColor whiteColor];
        
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
    
    self.view.backgroundColor = [UIColor whiteColor];

    if ( [ViewController isPhoneX]) {
        Liuhai  = 33;
    }
    
    
    [self setupBottonView];
    [self setupAnswerView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(input:) name:@"input" object:nil];
}

-(void)input:(NSNotification *)noti{
    
    NSString *InputString = [noti object];
    NSString *LabelString = self.Firstlabel.text;
    NSArray *SignsArray = @[@"AC",@"⇦",@"↹",@"=",@"÷"
                            ,@"×",@"-",@"+",@".",@"%",@"√"];
//    NSArray *SignsArray2 = @[@[@"(",@")",@"√",@"X²",@"1/X",@"Xⁿ"]
//                            ,@[@"[",@"]",@"X!",@"e",@"lg",@"ln"]
//                            ,@[@"{",@"}",@"‰",@"‱",@"mc",@"mr"]
//                            ,@[@"2nd",@"sinh",@"cosh",@"tanh",@"m+",@"m-"]
//                            ,@[@"sin",@"cos",@"tan",@"°",@"Rad",@"π"]];
//    NSLog(@"%i",[SignsArray  indexOfObject: InputString] );
    
    if ([InputString isEqualToString: @"Xⁿ" ] ) {
        InputString = @"^";
    }

    
    if ([SignsArray  indexOfObject: InputString] == 10) {
        InputString = @"√(";
    }
    if ([InputString isEqualToString: @"ln" ] ) {
        InputString = @"ln(";
    }
    if ([InputString isEqualToString: @"lg" ] ) {
        InputString = @"lg(";
    }

    if ([InputString isEqualToString: @"X²" ] ) {
        InputString = @"²";
    }
    if ([InputString isEqualToString: @"X!" ] ) {
        InputString = @"!";
    }
    if ([InputString isEqualToString: @"1/X" ] ) {
        InputString = @"1/";
    }
    if ([InputString isEqualToString: @"π" ] ) {
        InputString = @"3.141592";
    }
    
    if ([InputString isEqualToString: @"e" ] ) {
        InputString = @"2.718281";
    }
    
    switch ( [SignsArray  indexOfObject: InputString] ) {
        case 0 :
        {self.Firstlabel.text = nil;
         self.Secondlabel.text = nil;
        }
            break;
            
        case 1:
            {
                
                if ([self.Firstlabel.text length]) {
                    self.Firstlabel.text = [LabelString substringToIndex: [self.Firstlabel.text length]-1 ];
                }
            }
            break;

        case 2:
            break;
            
        case 3:
        {
            [self MakeCalculation: self.Firstlabel.text];
        }
            break;
        case 4:  case 5:  case 6:   case 7: case 8:
        case 9: {
            switch ([SignsArray  indexOfObject: [LabelString substringFromIndex: LabelString.length - 1 ] ]) {
                case 4:
                case 5:
                case 6:
                case 7:
                case 8:
                case 9: break;
                default:{
                    if (self.Firstlabel.text == nil) {
                        self.Firstlabel.text =  InputString;
                        self.Firstlabel.font = [UIFont systemFontOfSize: ScrH*0.1 weight:UIFontWeightThin];
                    }else{
                        self.Firstlabel.text =[self.Firstlabel.text stringByAppendingString: InputString];
                    }
                }break;
                    
            }
        } break;


        default:{
            
            if (self.Firstlabel.text == nil) {
                self.Firstlabel.text = InputString;
                self.Firstlabel.font = [UIFont systemFontOfSize: ScrH*0.1 weight:UIFontWeightThin];
            }else{
                self.Firstlabel.text =[self.Firstlabel.text stringByAppendingString: InputString];
                
            }
        }
            break;
    }
    


    
}

+ (BOOL)isPhoneX {
    BOOL iPhoneX = NO;
    if (UIDevice.currentDevice.userInterfaceIdiom != UIUserInterfaceIdiomPhone) {//判断是否是手机
        return iPhoneX;
    }
    if (@available(iOS 11.0, *)) {
        UIWindow *mainWindow = [[[UIApplication sharedApplication] delegate] window];
        if (mainWindow.safeAreaInsets.bottom > 0.0) {
            iPhoneX = YES;
        }
    }
    return iPhoneX;
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
            


            self.MoreButtonView.hidden =YES;
        }
            break;

            //右横屏
        case UIDeviceOrientationLandscapeRight:
        {
            self.ButtonView.sd_resetLayout.rightSpaceToView(self.view, Liuhai ).bottomSpaceToView(self.view, 0).widthRatioToView(self.view, 0.4f).heightRatioToView(self.view,0.7f);
            
            self.MoreButtonView.hidden =NO;
            self.MoreButtonView.sd_layout.bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, 0).rightSpaceToView(self.ButtonView, 0).heightRatioToView(self.view,0.7f);
            
            self.Firstlabel.text = nil;
            self.Secondlabel.text = nil;
            
            self.AnswerView.sd_resetLayout.bottomSpaceToView(self.ButtonView, 0).rightEqualToView(self.view).leftEqualToView(self.view).topSpaceToView(self.view, 35);
            
            self.Firstline.sd_layout.heightRatioToView(self.AnswerView, 0.5f).widthRatioToView(self.AnswerView, 1).bottomEqualToView(self.AnswerView);
            
            self.Firstlabel.sd_layout.heightRatioToView(self.Firstline, 1.0f).leftSpaceToView(self.Firstline,0  ).rightSpaceToView(self.Firstline, Liuhai).bottomEqualToView(self.Firstline);
            
            [self setupMoreBottonView];
            
        }
            break;
            //左横屏
        case UIDeviceOrientationLandscapeLeft:
        {
            self.ButtonView.sd_resetLayout.rightSpaceToView(self.view, 0).bottomSpaceToView(self.view, 0).widthRatioToView(self.view, 0.4f).heightRatioToView(self.view,0.7f);
            
            self.MoreButtonView.hidden =NO;
            self.MoreButtonView.sd_layout.bottomSpaceToView(self.view, 0).leftSpaceToView(self.view, Liuhai ).rightSpaceToView(self.ButtonView, 0).heightRatioToView(self.view,0.7f);
            
            self.Firstlabel.text = nil;
            self.Secondlabel.text = nil;

            self.AnswerView.sd_resetLayout.bottomSpaceToView(self.ButtonView, 0).rightEqualToView(self.view).leftEqualToView(self.view).topSpaceToView(self.view, 35);
            
            self.Firstline.sd_layout.heightRatioToView(self.AnswerView, 0.5f).widthRatioToView(self.AnswerView, 1).bottomEqualToView(self.AnswerView);
            
            self.Firstlabel.sd_layout.heightRatioToView(self.Firstline, 1.0f).leftSpaceToView(self.Firstline, Liuhai ).rightSpaceToView(self.Firstline, 0).bottomEqualToView(self.Firstline);
            
            [self setupMoreBottonView];

        }
            break;

        default:
            break;
    }


}


- (void)setupAnswerView{

    self.Firstline.sd_layout.heightRatioToView(self.AnswerView, 0.5f).widthRatioToView(self.AnswerView, 1).bottomEqualToView(self.AnswerView);
    
    self.Firstlabel.sd_layout.heightRatioToView(self.Firstline, 1.0f).leftSpaceToView(self.Firstline, 0 ).rightSpaceToView(self.Firstline, 0).bottomEqualToView(self.Firstline);

    self.Secondline.sd_layout.heightRatioToView(self.AnswerView, 0.5f).widthRatioToView(self.AnswerView, 1).topEqualToView(self.AnswerView);
    
    self.Secondlabel.sd_layout.heightRatioToView(self.Secondline, 1.0f).widthRatioToView(self.Secondline, 1).bottomEqualToView(self.Secondline);
}

-(void)setupBottonView{
    
    NSArray *SignsArray = @[@[@"AC",@"⇦",@"%",@"÷"]
                       ,@[@"7",@"8",@"9",@"×"]
                       ,@[@"4",@"5",@"6",@"-"]
                       ,@[@"1",@"2",@"3",@"+"]
                       ,@[@"↹",@"0",@".",@"="]];
    
    [self setButtonView:self.ButtonView forArr:SignsArray];
    
}

-(void)setupMoreBottonView{

    NSArray *SignsArray = @[@[@"(",@")",@"√",@"X²",@"1/X",@"Xⁿ"]
                       ,@[@"[",@"]",@"X!",@"e",@"lg",@"ln"]
                       ,@[@"{",@"}",@"‰",@"‱",@"mc",@"mr"]
                       ,@[@"2nd",@"sinh",@"cosh",@"tanh",@"m+",@"m-"]
                       ,@[@"sin",@"cos",@"tan",@"°",@"Rad",@"π"]];
    
    [self setButtonView:self.MoreButtonView forArr:SignsArray ];

}

-(void)setButtonView:(UIView *)ButtonView forArr: (NSArray *)SignsArray{
    
    
    UIView *line1 = [[UIView alloc] init ];
    [ButtonView addSubview:line1];
    line1.sd_layout.heightRatioToView(ButtonView, 0.2).leftSpaceToView(ButtonView, 0).rightSpaceToView(ButtonView, 0).topSpaceToView(ButtonView, 0);
    [self setLineView:line1 WithButtonView:ButtonView  forArr:SignsArray[0]];
    
    UIView *line2 = [[UIView alloc] init ];
    [ButtonView addSubview:line2];
    line2.sd_layout.heightRatioToView(ButtonView, 0.2).leftSpaceToView(ButtonView, 0).rightSpaceToView(ButtonView, 0).topSpaceToView(line1, 0);
    [self setLineView:line2 WithButtonView:ButtonView  forArr:SignsArray[1]];
    
    UIView *line3 = [[UIView alloc] init ];
    [ButtonView addSubview:line3];
    line3.sd_layout.heightRatioToView(ButtonView, 0.2).leftSpaceToView(ButtonView, 0).rightSpaceToView(ButtonView, 0).topSpaceToView(line2, 0);
    [self setLineView:line3 WithButtonView:ButtonView  forArr:SignsArray[2]];
    
    
    UIView *line4 = [[UIView alloc] init ];
    [ButtonView addSubview:line4];
    line4.sd_layout.heightRatioToView(ButtonView, 0.2).leftSpaceToView(ButtonView, 0).rightSpaceToView(ButtonView, 0).topSpaceToView(line3, 0);
    [self setLineView:line4 WithButtonView:ButtonView  forArr:SignsArray[3]];
    
    UIView *line5 = [[UIView alloc] init ];
    [ButtonView addSubview:line5];
    line5.sd_layout.heightRatioToView(ButtonView, 0.2).leftSpaceToView(ButtonView, 0).rightSpaceToView(ButtonView, 0).topSpaceToView(line4, 0);
    [self setLineView:line5 WithButtonView:ButtonView forArr:SignsArray[4]];
    
    
    
}

-(void)setLineView:(UIView *)lineview WithButtonView:(UIView *)ButtonView forArr: (NSArray *)signs{
    
    HQSButton *button1 = [[HQSButton alloc ]init];
    [lineview addSubview: button1];
    button1.sd_layout.widthRatioToView(ButtonView, 1.0f/signs.count).topSpaceToView(lineview, 0).leftSpaceToView(lineview, 0).bottomSpaceToView(lineview, 0);
    [button1 setSign: signs[0]];
    
    HQSButton *button2 = [[HQSButton alloc ]init];
    [lineview addSubview: button2];
    button2.sd_layout.widthRatioToView(ButtonView, 1.0f/signs.count).topSpaceToView(lineview, 0).leftSpaceToView(button1, 0).bottomSpaceToView(lineview, 0);
    [button2 setSign: signs[1]];
    
    HQSButton *button3 = [[HQSButton alloc ]init];
    [lineview addSubview: button3];
    button3.sd_layout.widthRatioToView(ButtonView, 1.0f/signs.count).topSpaceToView(lineview, 0).leftSpaceToView(button2, 0).bottomSpaceToView(lineview, 0);
    [button3 setSign: signs[2]];
    
    HQSButton *button4 = [[HQSButton alloc ]init];
    [lineview addSubview: button4];
    button4.sd_layout.widthRatioToView(ButtonView, 1.0f/signs.count).topSpaceToView(lineview, 0).leftSpaceToView(button3, 0).bottomSpaceToView(lineview, 0);
    [button4 setSign: signs[3]];
    
    if (signs.count > 4) {
        
        HQSButton *button5 = [[HQSButton alloc ]init];
        [lineview addSubview: button5];
        button5.sd_layout.widthRatioToView(ButtonView, 1.0f/signs.count).topSpaceToView(lineview, 0).leftSpaceToView(button4, 0).bottomSpaceToView(lineview, 0);
        [button5 setSign: signs[4]];
        
        HQSButton *button6 = [[HQSButton alloc ]init];
        [lineview addSubview: button6];
        button6.sd_layout.widthRatioToView(ButtonView, 1.0f/signs.count).topSpaceToView(lineview, 0).leftSpaceToView(button5, 0).bottomSpaceToView(lineview, 0);
        [button6 setSign: signs[5]];
        
    }

    
    
}

-(void)MakeCalculation:(NSString *)MuthString{

    
    Calculate *cal = [[Calculate alloc] init];
    
//    NSLog(@"------%@-----",@([cal Clculate:MuthString].floatValue));
    self.Secondlabel.text = [NSString stringWithFormat:@"%@",@([cal  Calculate:MuthString].floatValue)];
    self.Secondlabel.font = [UIFont systemFontOfSize: ScrH*0.1 weight:UIFontWeightThin];
    
}


@end

