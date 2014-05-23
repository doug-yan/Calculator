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
@synthesize  display, operand1, justCalc, decimalPoint, currentNum, operation;

- (void)viewDidLoad
{
  [super viewDidLoad];
  myCalc = [[Calculator alloc] init];
  displayMessage = [NSMutableString stringWithCapacity:40];
  [self clearKey];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

-(void) processNumber: (double)number
{
  int sigDig;
  currentNum = currentNum * 10 + number;
 
  if(operand1)
  {
    myCalc.accumulator = currentNum;
    sigDig = [self getFormattedFloat: myCalc.accumulator];
    [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, currentNum]];
  }
  
  else
  {
    myCalc.secondOperand = currentNum;
    sigDig = [self getFormattedFloat: myCalc.secondOperand];
    [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, number]];
  }
  
  self.display.text = displayMessage;
}

-(void) processOperation: (char) op
{
  if(operand1)
    operand1 = NO;
  
  else if( !operand1 && !justCalc)
    [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  
  //Update the display
  NSString *opStr;
  operation = op;
  
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
  
  justCalc = NO;
  currentNum = 0;
  myCalc.secondOperand = 0;
}

-(IBAction) plusKey
{
  myCalc.op = '+';
  [self processOperation: '+'];
}

-(IBAction) minusKey
{
  myCalc.op = '-';
  [self processOperation: '-'];
}

-(IBAction) multiplyKey
{
  myCalc.op = '*';
  [self processOperation: '*'];
}

-(IBAction) divideKey
{
  myCalc.op = '/';
  [self processOperation: '/'];
}

-(IBAction) numKey: (UIButton*) sender
{
  if(operand1)
  {
    [displayMessage setString: @""];
    self.display.text = displayMessage;
  }
  
  if(justCalc)
  {
    [self clearKey];
    [displayMessage setString: @""];
    self.display.text = displayMessage;
    justCalc = NO;
  }
  
  int digit = (int)sender.tag;
  [self processNumber: digit];
  
}

-(IBAction) decimalKey
{
  decimalPoint = YES;
  /*
  [displayMessage appendString: @"."];
  self.display.text = displayMessage;
   */
}

-(IBAction) piKey
{
  if(operand1)
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

-(IBAction) clearKey
{
  int random;
  operand1 = YES;
  justCalc = NO;
  decimalPoint = NO;
  currentNum = 0;
  operation = '+';
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

-(IBAction) equalsKey
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
  [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  
  sigDig = [self getFormattedFloat: myCalc.accumulator];
  
  [displayMessage setString: @""];
  [displayMessage appendString: [NSString stringWithFormat: @"%.*lf", sigDig, myCalc.accumulator]];
  self.display.text = displayMessage;
  
  justCalc = YES;

}

-(void) combineOperands:(double)firstOne withThe:(double)secondOne
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

-(int) getFormattedFloat: (double) itemToConvert
{
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
