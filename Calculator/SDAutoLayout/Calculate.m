//
//  clculate.m
//  iClCUlator_test
//
//  Created by Liu_zc on 2019/7/22.
//  Copyright © 2019 Liu_zc. All rights reserved.
//

#import "Calculate.h"

@interface Calculate ()
@property (nonatomic, strong) NSMutableArray *equArr;
@property (nonatomic, strong) NSMutableArray *putArr; //输出串
@property (nonatomic, strong) NSMutableArray *stack; //一个栈



@end

@implementation Calculate

- (float)clculate:(NSString *)Equ {
    
    [self dealThem:Equ];  //处理字符串
    
    [self poland]; //化为逆波兰表达式

    return [self calculate:self.putArr];
}
- (void) dealThem:(NSString *)Equ {
//    99!*!99
    ///将乘除换为*/,并在符号两端加标示
    Equ = [Equ stringByReplacingOccurrencesOfString:@"(" withString:@"!(!"];
    Equ = [Equ stringByReplacingOccurrencesOfString:@")" withString:@"!)!"];
    Equ = [Equ stringByReplacingOccurrencesOfString:@"+" withString:@"!+!"];
    Equ = [Equ stringByReplacingOccurrencesOfString:@"-" withString:@"!-!"];
    Equ = [Equ stringByReplacingOccurrencesOfString:@"×" withString:@"!*!"];
    Equ = [Equ stringByReplacingOccurrencesOfString:@"÷" withString:@"!/!"];
    self.equArr = [[NSMutableArray alloc] init];
    self.putArr = [[NSMutableArray alloc] init];
    self.stack  = [[NSMutableArray alloc] init];
    
    NSMutableArray *array = [Equ componentsSeparatedByString:@"!"].mutableCopy;
    [array removeObject:@""];
    self.equArr = array.mutableCopy;
    
    NSLog(@"%@",self.equArr);
//    /// 将Equ切成单个字符
//    for (int i = 0; i < Equ.length ; i++) {
//        NSRange subRange = NSMakeRange(i, 1);
//        [self.equArr addObject:[Equ substringWithRange:subRange]];
//        NSLog(@"%@",self.equArr);
//    }  //至此做完准备
}

- (void) poland {
    for (int j = 0; j < self.equArr.count; j++) {  // 1、最外围，对每个操作字符进行遍历
        
        /// 2、如果是数字，则添加到输出串中
        if (!([self.equArr[j] isEqual:@"("] || [self.equArr[j] isEqual:@")"] ||[self.equArr[j] isEqual:@"/"] ||[self.equArr[j] isEqual:@"*"] ||[self.equArr[j] isEqual:@"+"] || [self.equArr[j] isEqual:@"-"])) {
            
            //            NSLog(@"我是数字");
            NSLog(@"我是2步");
            [self.putArr addObject:self.equArr[j]];  //至于输出串中
        }
        
        /// 3、如果扫描到开括号
        if ([self.equArr[j] isEqual:@"("]) {
            [self.stack addObject:self.equArr[j]];  //将开括号"(“入栈
            NSLog(@"我是3步");
        }
        
        /// 4、如果扫描到操作符
        while ([self.equArr[j] isEqual:@"/"] ||[self.equArr[j] isEqual:@"*"] ||[self.equArr[j] isEqual:@"+"] || [self.equArr[j] isEqual:@"-"]) {
            
            if (self.stack.count == 0 || [self.stack[self.stack.count - 1] isEqual:@"("]|| [self priority:self.equArr[j]] ) { //或||扫描到的操作符优先级高 //这里||判断完前一个若为真，即不会判断下一个，则不会造成self.stack.count - 1 为 -1的情况
                [self.stack addObject:self.equArr[j]];  //将其入栈
                NSLog(@"我是4步1");
                break;
            } else {
                //            for (long int i = self.stack.count - 1; i >= 0; i--) {
                [self.putArr addObject:self.stack[self.stack.count - 1]];  //出栈至输出串中
                [self.stack replaceObjectAtIndex:self.stack.count - 1 withObject:self.equArr[j]];
                //            [self.putArr addObject:self.equArr[j]];
                NSLog(@"我是4步2");
                break;
                //            }
            }}
        
        /// 5、如果扫描到闭括号
        if ([self.equArr[j] isEqual:@")"]) {
            for (long int i = self.stack.count - 1; i >= 0; i--) {
                if ([self.stack[i] isEqual:@"("]) {
                    [self.stack removeObjectAtIndex:i];  //出栈并销毁
                    NSLog(@"我是5步");
                    break;
                }
                [self.putArr addObject:self.stack[i]];  //出栈至输出串中
                [self.stack removeObjectAtIndex:i];
                NSLog(@"%@",self.stack);
                
            }}
        
        /// 6、开始第二轮循环
        
    }  //最外围，对每个操作字符进行遍历
    
    /// 7、循环结束后若栈中还有操作符
    while (self.stack.count) {
        for (long int i = self.stack.count - 1; i >= 0; i--) {
            [self.putArr addObject:self.stack[i]];  //出栈至输出串中
        }
        [self.stack removeAllObjects];
    }
    
    NSLog(@"我是最后一步");
    NSLog(@"输出串：：：%@",self.putArr);
    
    ///结束
}

- (int) priority:(NSString *)x {  //判断传入计算符与栈顶计算符的优先级
    NSString *y = self.stack[self.stack.count - 1];
    if ([y isEqual:@"+"]||[y isEqual:@"-"]) {
        if ([x isEqual:@"*"]||[x isEqual:@"/"]) {
            return 1;
    }}
    return 0;
}

- (float) calculate:(NSMutableArray *)arr {
//    NSMutableArray *calArr = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < arr.count; i++) {
        if ([arr[i] isEqual:@"/"] ||[arr[i] isEqual:@"*"] ||[arr[i] isEqual:@"+"] || [arr[i] isEqual:@"-"]) {
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
        }
    
    }
    
    
    return [arr[0] floatValue];
}

@end
