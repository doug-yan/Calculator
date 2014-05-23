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

- (void)viewDidLoad
{
  [super viewDidLoad];
  myCalc = [[Calculator alloc] init];
  displayMessage = [NSMutableString stringWithCapacity:40];
  [self clearKeyPressed];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void) putNumberInDisplayAndCalculator: (double)number
{
  int sigDig;

  self.currentNum = self.currentNum * 10 + number;
 
  if(self.isOperand1)
  {
    myCalc.accumulator = self.currentNum;
    sigDig = [self formatFloat: myCalc.accumulator];
    [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, self.currentNum]];
  }
  
  else
  {
    myCalc.secondOperand = self.currentNum;
    sigDig = [self formatFloat: myCalc.secondOperand];
    [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, number]];
  }
  
  self.display.text = displayMessage;
}

-(void) putOperationInCalculator: (char) op
{
  if(self.isOperand1)
    self.isOperand1 = NO;
  
  else if( !self.isOperand1 && !self.isJustCalc)
    [self combineOperandsIntoAccumulator: myCalc.accumulator
                                 withThe: myCalc.secondOperand];
  
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
  if(self.isJustCalc)
  {
    [self clearKeyPressed];
    [displayMessage setString: @""];
    self.isJustCalc = NO;
  }
  
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
  [self combineOperandsIntoAccumulator: myCalc.accumulator
                               withThe: myCalc.secondOperand];
  
  sigDig = [self formatFloat: myCalc.accumulator];
  
  [displayMessage setString: @""];
  [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, myCalc.accumulator]];
  self.display.text = displayMessage;
  
  self.isJustCalc = YES;

}

-(void) combineOperandsIntoAccumulator:(double)firstOne
                               withThe:(double)secondOne
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

-(IBAction) storeValue
{
  
}

-(int) formatFloat: (double) itemToConvert
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
  
  doubleTemp = itemToConvert* 1000000;
  intTemp = (int) doubleTemp;
  dummy = intTemp % 10;
  intTemp /= 10;
  
  
  while(dummy == 0 && zeroCount < length)
  {
    dummy = intTemp % 10;
    intTemp /= 10;
    zeroCount++;
  }
  
  sigDigs = 6 - zeroCount;
  
  return sigDigs;
}

@end
