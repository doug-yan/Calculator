//
//  ViewController.m
//  Calculator
//
//  Created by Douglas  Yan on 5/22/14.
//  Copyright (c) 2014 Objective_C_Test. All rights reserved.
//

#import "ViewController.h"
#import "stdlib.h"

@implementation ViewController
{
  Calculator *myCalc;
  NSMutableString *displayMessage;
}
@synthesize  display, operand1, justCalc, currentNum, operation;

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

-(void) processNumber: (int)number
{
  //So that when we get a mutliple digit number one digit at a time,
  //we can properly update the string
  currentNum = currentNum * 10 + number;
  
  if(operand1)
  {
    myCalc.accumulator = currentNum;
    [displayMessage appendString: [NSString stringWithFormat: @"%i", currentNum]];
  }
  
  else
  {
    myCalc.secondOperand = currentNum;
    [displayMessage appendString: [NSString stringWithFormat: @"%i", number]];
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

-(IBAction) clearKey
{
  int random;
  operand1 = YES;
  justCalc = NO;
  currentNum = 0;
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
  printf( "This is the calculation being carried out: %i%c%i=", myCalc.accumulator, self.operation, myCalc.secondOperand);
  [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  printf("%i\n", myCalc.accumulator);
  [displayMessage setString: @""];
  [displayMessage appendString: [NSString stringWithFormat: @"%i", myCalc.accumulator]];
  self.display.text = displayMessage;
  
  justCalc = YES;

}

-(void) combineOperands:(int)firstOne withThe:(int)secondOne
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

@end
