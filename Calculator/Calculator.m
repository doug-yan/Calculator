//
//  Calculator.m
//  Calculator
//
//  Created by Douglas  Yan on 5/22/14.
//  Copyright (c) 2014 Objective_C_Test. All rights reserved.
//

#import "Calculator.h"

@implementation Calculator

-(void) plus
{
  self.accumulator = self.accumulator + self.secondOperand;
}

-(void) minus
{
  self.accumulator = self.accumulator - self.secondOperand;
}

-(void) multiply
{
  self.accumulator = self.accumulator * self.secondOperand;
}

-(void) divide
{
  if( self.secondOperand == 0 )
    self.accumulator = NAN;
  
  else
    self.accumulator = self.accumulator / self.secondOperand;
}

@end
