//
//  Clculate.m
//  iClCUlator_test
//
//  Created by Liu_zc on 2019/7/22.
//  Copyright © 2019 Liu_zc. All rights reserved.
//

#import "Calculate.h"

@interface Calculate ()

@property (nonatomic, strong) NSString *Result; //结果

@property (nonatomic, strong) NSArray *SignsArray;


@end

@implementation Calculate

- (NSArray *)SignsArray{
    
    if (_SignsArray == NULL) {
        NSArray *SignsArray = @[@"+",@"-",@"×",@"÷",@"√",@"%",@"ln"];
        _SignsArray = SignsArray;
    }
    return _SignsArray;
}


- (NSString *) Calculate:(NSString *)Equation {
    
    [self dealThem:Equation];  //处理并运算字符串
    
    
    return self.Result;
}

- (void) dealThem:(NSString *)Equation {
    ///将乘除换为*/,并在符号两端加标示
    
    Equation = [Equation stringByReplacingOccurrencesOfString:@"[" withString:@"("];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"]" withString:@")"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"{" withString:@"("];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"}" withString:@")"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"(-" withString:@"(0-"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"(+" withString:@"("];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"(" withString:@"|(|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@")" withString:@"|)|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"+" withString:@"|+|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"-" withString:@"|-|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"×" withString:@"|*|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"÷" withString:@"|/|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"√" withString:@"|√|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"ln" withString:@"|ln|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"²" withString:@"|²|"];
    Equation = [Equation stringByReplacingOccurrencesOfString:@"!" withString:@"|!|"];
    NSMutableArray *array = [Equation componentsSeparatedByString:@"|"].mutableCopy;
    [array removeObject:@""];
    
    if ([array[0] isEqualToString:@"-"]||[array[0] isEqualToString:@"+"]) {
        [array insertObject:@"0" atIndex:0];
    }
    
    
    
    NSMutableArray *EquationArray  = array.mutableCopy;
    
    
    [self Compute: [self TranslateToInversePolandForClculate:EquationArray] ];

}

- (NSMutableArray *)TranslateToInversePolandForClculate: (NSMutableArray *)EquationArray{
    
    NSMutableArray *Stack  = [[NSMutableArray alloc] init];
    
    NSMutableArray *OutputArray = [[NSMutableArray alloc] init];

    
    for (int j = 0; j < EquationArray.count; j++) {  // 1、最外围，对每个操作字符进行遍历
        NSString *Chars = EquationArray[j];
        
        //操作符号判断
        BOOL flag = ([Chars isEqual:@"("] || [Chars isEqual:@")"] ||[Chars isEqual:@"/"] || [Chars isEqual:@"*"] ||[Chars isEqual:@"+"] || [Chars isEqual:@"-"]||[Chars isEqual:@"√"]||[Chars isEqual:@"ln"]||[Chars isEqual:@"²"]||[Chars isEqual:@"!"]);
        
        /// 2、如果是数字，则添加到输出串中
        if (!flag) {
            
            //            NSLog(@"我是数字");
            NSLog(@"我是2步");
            [OutputArray addObject:Chars ];  //至于输出串中
        }
        
        /// 3、如果扫描到开括号
        if ([Chars isEqual:@"("]) {
            [Stack addObject:Chars];  //将开括号"(“入栈
            NSLog(@"我是3步");
        }
        
        /// 4、如果扫描到操作符
        while (flag) {
            
            if ([Chars isEqual:@"²"]||[Chars isEqual:@"!"]) {
                [OutputArray addObject: Chars ];
//                NSLog(@"6666666");
                break;
            }
//            NSLog(@"6666666");
            
            if (Stack.count == 0 || [Stack[Stack.count - 1] isEqual:@"("]|| (([self.SignsArray indexOfObject:Chars]/2 > [self.SignsArray indexOfObject:Stack[Stack.count - 1] ]/2)&&(![Stack[Stack.count - 1] isEqual:@"√"])&&(![Stack[Stack.count - 1] isEqual:@"ln"]))  ) { // 或|| 扫描到的操作符优先级高 //这里||判断完前一个若为真，即不会判断下一个，则不会造成self.Stack.count - 1 为 -1的情况
                [Stack addObject: Chars ];  //将其入栈
                NSLog(@"我是4步1");
                break;
            } else {
                [OutputArray addObject:Stack[Stack.count - 1]];  //出栈至输出串中
                [Stack replaceObjectAtIndex:Stack.count - 1 withObject:Chars];
                //            [self.putArr addObject:self.equArr[j]];
                NSLog(@"我是4步2");
                break;
                
            }
            
        }
        
        /// 5、如果扫描到闭括号
        if ([EquationArray[j] isEqual:@")"]) {
            for (long int i = Stack.count - 1; i >= 0; i--) {
                if ([Stack[i] isEqual:@"("]) {
                    [Stack removeObjectAtIndex:i];  //出栈并销毁
                    NSLog(@"我是5步");
                    break;
                }
                [OutputArray addObject:Stack[i]];  //出栈至输出串中
                [Stack removeObjectAtIndex:i];
                NSLog(@"%@",Stack);
                
            }}
        
        /// 6、开始第二轮循环
        
    }  //最外围，对每个操作字符进行遍历
    
    /// 7、循环结束后若栈中还有操作符
    while (Stack.count) {
        for (long int i = Stack.count - 1; i >= 0; i--) {
            [OutputArray addObject:Stack[i]];  //出栈至输出串中
        }
        [Stack removeAllObjects];
    }
    
//    NSLog(@"我是最后一步");
    NSLog(@"输出串：%@",OutputArray);
    return OutputArray;
}




- (NSString *) Compute:(NSMutableArray *)arr {
    for (int i = 0; i < arr.count; i++) {
        if ([arr[i] isEqual:@"/"] ||[arr[i] isEqual:@"*"] ||[arr[i] isEqual:@"+"] || [arr[i] isEqual:@"-"]|| [arr[i] isEqual:@"√"]|| [arr[i] isEqual:@"ln"]
            || [arr[i] isEqual:@"²"]|| [arr[i] isEqual:@"!"]) {
            ///取前两位进行计算
            if ([arr[i] isEqual:@"+"]) {
                float temp1 = [arr[i-2] floatValue];
                float temp2 = [arr[i-1] floatValue];
                float tempTotal = temp1 + temp2;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-2];
                [arr removeObjectAtIndex:i-2]; ///i-(1+1)
                i = -1;
                continue;
            }
            if ([arr[i] isEqual:@"-"]) {
                float temp1 = [arr[i-2] floatValue];
                float temp2 = [arr[i-1] floatValue];
                float tempTotal = temp1 - temp2;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-2];
                [arr removeObjectAtIndex:i-2]; ///i-(1+1)
                i = -1;
                continue;
            }
            if ([arr[i] isEqual:@"*"]) {
                float temp1 = [arr[i-2] floatValue];
                float temp2 = [arr[i-1] floatValue];
                float tempTotal = temp1 * temp2;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-2];
                [arr removeObjectAtIndex:i-2]; ///i-(1+1) 之前移除了一个，所以要多移一位
                NSLog(@"----%@",arr);
                i = -1;
                continue;
            }
            if ([arr[i] isEqual:@"/"]) {
                float temp1 = [arr[i-2] floatValue];
                float temp2 = [arr[i-1] floatValue];
                float tempTotal = temp1 / temp2;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-2];
                [arr removeObjectAtIndex:i-2]; ///i-(1+1)
                i = -1;
                continue;
            }
            if ([arr[i] isEqual:@"√"]) {
                float temp1 = [arr[i-1] floatValue];
                float tempTotal = sqrt (temp1);
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-1];
                i = -1;
                continue;
            }
            if ([arr[i] isEqual:@"ln"]) {
                float temp1 = [arr[i-1] floatValue];
                float tempTotal = logf(temp1);
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-1];
                i = -1;
                continue;
            }
            if ([arr[i] isEqual:@"²"]) {
                float temp1 = [arr[i-1] floatValue];
                float tempTotal = temp1*temp1;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-1];
                i = -1;
                continue;
            }
            if ([arr[i] isEqual:@"!"]) {
                int temp1 = [arr[i-1] intValue];
                float tempTotal = 1 ;
                for(int n=1;n<=temp1;n++)
                    tempTotal=tempTotal*n;
                [arr replaceObjectAtIndex:i withObject:[NSString stringWithFormat:@"%f",tempTotal]];
                [arr removeObjectAtIndex:i-1];
                i = -1;
                continue;
            }
        }
    
    }

    NSString *num = [NSString stringWithFormat:@"%@",@([arr[0] floatValue]) ];
    
    self.Result = num;
    
    return num  ;
}

@end
