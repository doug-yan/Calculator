//
//  Calculator.m
//  Calculator
//
//  Created by Douglas  Yan on 5/22/14.
//  Copyright (c) 2014 Objective_C_Test. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator
@synthesize accumulator, secondOperand, op;

-(void) plus
{
  accumulator = accumulator + secondOperand;
}

-(void) minus
{
  accumulator = accumulator - secondOperand;
}

-(void) multiply
{
  accumulator = accumulator * secondOperand;
}

-(void) divide
{
  if( secondOperand == 0 )
    accumulator = NAN;
  
  else
    accumulator = accumulator/ secondOperand;
}

-(NSString *) convertToString: (int) itemToConvert;
{
  return nil;
  //return [NSString stringWithFormat: @"%i", itemToConvert];
}

@end
