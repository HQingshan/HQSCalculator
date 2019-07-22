//
//  HQSButton.m
//  Calculator
//
//  Created by 你好帅 on 2019/7/19.
//  Copyright © 2019 你好帅. All rights reserved.
//

#import "HQSButton.h"

@implementation HQSButton

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    [self setTitle:@"+" forState:UIControlStateNormal];
    [self setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    self.titleLabel.font = [UIFont systemFontOfSize:27 weight:UIFontWeightLight];

    self.layer.borderColor = [UIColor colorWithRed:236.0f/255.0f green:237.0f/255.0f blue:237.0f/255.0f alpha:1].CGColor ;
    self.layer.borderWidth = 0.5f; //设置边框粗细
    self.layer.masksToBounds = YES;
    
    [self addTarget:self action:@selector(TouchDownAction:) forControlEvents:UIControlEventTouchDown];
    
    [self addTarget:self action:@selector(TouchUpAction:) forControlEvents:UIControlEventTouchUpInside];

    
    return self;
    
}

//- (void)layoutSubviews
//{
//
//}
-(void)TouchDownAction:(UIButton*)btn{
    btn.backgroundColor = [UIColor colorWithRed:224.0f/255.0f green:225.0f/255.0f blue:226.0f/255.0f alpha:1];
    if ([self.Sign isEqualToString:@"="]) {
        self.backgroundColor = [UIColor colorWithRed:222.0f/255.0f green:106.0f/255.0f blue:53.0f/255.0f alpha:1];
    }
}

-(void)TouchUpAction:(UIButton*)btn{
    btn.backgroundColor = [UIColor whiteColor];
    
    if ([self.Sign isEqualToString:@"="]) {
        self.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:119.0f/255.0f blue:59.0f/255.0f alpha:1];
    }
}

- (void)setSign:(NSString *)Sign
{
    _Sign = Sign;
    if ([Sign isEqualToString:@"="]) {
        self.backgroundColor = [UIColor colorWithRed:249.0f/255.0f green:119.0f/255.0f blue:59.0f/255.0f alpha:1];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    if ([Sign isEqualToString:@"AC"]|[Sign isEqualToString:@"↹"]) {
       [self setTitleColor:[UIColor colorWithRed:249.0f/255.0f green:119.0f/255.0f blue:59.0f/255.0f alpha:1] forState:UIControlStateNormal];

    }
    
     [self setTitle:Sign forState:UIControlStateNormal];
    
 
}

@end
