//
//  ViewController.m
//  Calculator
//
//  Created by Douglas  Yan on 5/22/14.
//  Copyright (c) 2014 Objective_C_Test. All rights reserved.
//

#import "ViewController.h"
#import "stdlib.h"
#import "math.h"

@implementation ViewController
{
  Calculator *myCalc;
  NSMutableString *displayMessage;
}


//Instaniate objects and clear all data in the calculator
-(void)viewDidLoad
{
  [super viewDidLoad];
  myCalc = [[Calculator alloc] init];
  displayMessage = [NSMutableString stringWithCapacity:40];
  [self clearKeyPressed];
}

-(void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}


-(void) putNumberInDisplayAndCalculator: (double)number
{
  int sigDig;
  
  //Update the current number that we are working with
  self.currentNum = self.currentNum * 10 + number;
 
  //If on the first operand, store the information in the accumulator
  if(self.isOperand1)
  {
    myCalc.accumulator = self.currentNum;
    sigDig = [self getNumberOfSignificantDigits: myCalc.accumulator];
    [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, self.currentNum]];
  }
  
  //Otherwise, store information in the second operand
  else
  {
    myCalc.secondOperand = self.currentNum;
    sigDig = [self getNumberOfSignificantDigits: myCalc.secondOperand];
    [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, number]];
  }
  
  self.display.text = displayMessage;
}

-(void) putOperationInCalculator: (char) op
{
  if(self.isOperand1)
    self.isOperand1 = NO;
 
  //If more than two operands are being entered, combine the first two into the accumulator
  else if( !self.isOperand1 && !self.isJustCalc)
    [self combineOperandsIntoAccumulator];
  
  //Update the display
  NSString *opStr;
  self.operation = op;
  
  switch (op)
  {
    case '+':
      opStr = @"+";
      break;
      
    case '-':
      opStr = @"-";
      break;
      
    case '*':
      opStr = @"*";
      break;
      
    case '/':
      opStr = @"/";
      break;
  }
  
  [displayMessage appendString: opStr];
  self.display.text = displayMessage;
  
  self.isJustCalc = NO;
  self.currentNum = 0;
  myCalc.secondOperand = 0;
}

-(IBAction) plusKeyPressed
{
  myCalc.op = '+';
  [self putOperationInCalculator: '+'];
}

-(IBAction) minusKeyPressed
{
  myCalc.op = '-';
  [self putOperationInCalculator: '-'];
}

-(IBAction) multiplyKeyPressed
{
  myCalc.op = '*';
  [self putOperationInCalculator: '*'];
}

-(IBAction) divideKeyPressed
{
  myCalc.op = '/';
  [self putOperationInCalculator: '/'];
}

-(IBAction) numKeyPressed: (UIButton*) sender
{
  if(self.isOperand1)
  {
    [displayMessage setString: @""];
    self.display.text = displayMessage;
  }
  
  //If we just performed a calculator, then clear
  //the information in the calculator and start over
  if(self.isJustCalc)
  {
    [self clearKeyPressed];
    [displayMessage setString: @""];
    self.display.text = displayMessage;
    self.isJustCalc = NO;
  }
  
  int digit = (int)sender.tag;
  [self putNumberInDisplayAndCalculator: digit];
  
}

-(IBAction) decimalKeyPressed
{
  self.isDecimalPoint = YES;
  /*
  [displayMessage appendString: @"."];
  self.display.text = displayMessage;
   */
}

-(IBAction) piKeyPressed
{
  //Reset if calculation just performed
  if(self.isJustCalc)
  {
    [self clearKeyPressed];
    [displayMessage setString: @""];
    self.isJustCalc = NO;
  }
  
  /*
   If we are on the first operand and there wasn't
   anything in the accumulator beforehand, set
   accumulator to value of pi. Otherwise, multiply
   whatever was in the accumulator with pi.
   
   If we are on the second operand, we make the
   same checks.
   */
  if(self.isOperand1)
  {
    if(myCalc.accumulator == 0)
    {
      myCalc.accumulator = M_PI;
      [displayMessage setString: @""];
      self.display.text = displayMessage;
    }
    
    else
      myCalc.accumulator *= M_PI;
  }
  
  else
  {
    if(myCalc.secondOperand == 0)
      myCalc.secondOperand = M_PI;
    
    else
      myCalc.secondOperand *= M_PI;
  }
  
  //Update message to the screen
  [displayMessage appendString: @"π"];
  self.display.text = displayMessage;
}

-(IBAction) clearKeyPressed
{
  int random;
  self.isOperand1 = YES;
  self.isJustCalc = NO;
  self.isDecimalPoint = NO;
  self.currentNum = 0;
  self.operation = '+';
  myCalc.accumulator = 0;
  myCalc.secondOperand = 0;
  myCalc.storeValue = 0;
  [displayMessage setString: @""];
  self.display.text = displayMessage;
  
  random = arc4random() % 5;
  switch(random)
  {
    case 0:
      [displayMessage setString: @"Don't do drugs."];
      break;
      
    case 1:
      [displayMessage setString: @"Stay in school"];
      break;
      
    case 2:
      [displayMessage setString: @"Eat vegetables"];
      break;
      
    case 3:
      [displayMessage setString: @"Don't do school"];
      break;
      
    case 4:
      [displayMessage setString: @"Stay in drugs"];
      break;
  }
  self.display.text = displayMessage;
}

-(IBAction) equalsKeyPressed
{
  int sigDig;
  NSString *opStr;
  switch(self.operation)
  {
    case '+':
      opStr = @"+";
      break;
      
    case '-':
      opStr = @"-";
      break;
      
    case '*':
      opStr = @"*";
      break;
      
    case '/':
      opStr = @"/";
      break;
  }
  
  //Get the answer
  [self combineOperandsIntoAccumulator];
  
  sigDig = [self getNumberOfSignificantDigits: myCalc.accumulator];
  
  [displayMessage setString: @""];
  [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, myCalc.accumulator]];
  self.display.text = displayMessage;
  
  self.isJustCalc = YES;

}

-(void) combineOperandsIntoAccumulator
{
  switch(self.operation)
  {
    case '+':
      [myCalc plus];
      break;
      
    case '-':
      [myCalc minus];
      break;
      
    case '*':
      [myCalc multiply];
      break;
      
    case '/':
      [myCalc divide];
      break;
  }
}

/*
 Slightly convoluted algorithm here:
 
 - First, find the length of the float with all the trailing zeros.
 - Then, multiply the parameter by 1000000 to get rid of the trailing 0's.
 - Then, start popping off end digits. If it is a zero, increment zeroCount.
    - If we pop off a non-zero integer, we know we have found a significant digit.
 - Finally, subtract the zeroCount from 6 in order to get the number of significant
    digits.
 - If the zeroCount is greater than 6, we know the original number ended in zero and 
    return 0;
 */
-(int) getNumberOfSignificantDigits: (double) itemToConvert
{
  if(itemToConvert == 0)
    return 0;
  
  double doubleTemp;
  int intTemp, dummy, zeroCount = 0, sigDigs, length = 0;

  doubleTemp = itemToConvert * 1000000;
  
  while( doubleTemp != 0 )
  {
    doubleTemp /= 10;
    length++;
  }
  
  doubleTemp = itemToConvert * 1000000;
  intTemp = (int) doubleTemp;
  dummy = intTemp % 10;
  intTemp /= 10;
  
  
  while(dummy == 0 && zeroCount < length)
  {
    dummy = intTemp % 10;
    intTemp /= 10;
    zeroCount++;
  }
  
  if( zeroCount <= 6 )
    sigDigs = 6 - zeroCount;
  
  else
    sigDigs = 0;
  
  return sigDigs;
}

@end
