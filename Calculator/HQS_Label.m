//
//  HQS_Label.m
//  Calculator
//
//  Created by 你好帅 on 2019/7/19.
//  Copyright © 2019 你好帅. All rights reserved.
//

#import "HQS_Label.h"

@implementation HQS_Label

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
//    self.text = @"0";
    self.textAlignment = NSTextAlignmentRight;
    
    self.font = [UIFont systemFontOfSize:27 weight:UIFontWeightLight];
    self.adjustsFontSizeToFitWidth = YES;
    
    return self;
    
}

//- (void)layoutSubviews
//{
//
//}

@end
