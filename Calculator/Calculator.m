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
  NSString* returnItem;
  
  switch(itemToConvert)
  {
    case 0:
      returnItem = @"0";
      break;
      
    case 1:
      returnItem = @"1";
      break;
      
    case 2:
      returnItem = @"2";
      break;
      
    case 3:
      returnItem = @"3";
      break;
      
    case 4:
      returnItem = @"4";
      break;
      
    case 5:
      returnItem = @"5";
      break;
      
    case 6:
      returnItem = @"6";
      break;
      
    case 7:
      returnItem = @"7";
      break;
      
    case 8:
      returnItem = @"8";
      break;
      
    case 9:
      returnItem = @"9";
      break;
  }
  
  return returnItem;
}

@end
