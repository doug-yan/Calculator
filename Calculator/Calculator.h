//
//  Calculator.h
//  Calculator
//
//  Created by Douglas  Yan on 5/22/14.
//  Copyright (c) 2014 Objective_C_Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject
@property (nonatomic) int accumulator;
@property (nonatomic) int secondOperand;
@property (nonatomic) char op;

-(void) plus;
-(void) minus;
-(void) multiply;
-(void) divide;

-(NSString *) convertToString: (int) itemToConvert;

@end
