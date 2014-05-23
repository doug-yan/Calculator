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
@synthesize  display, operand1, alreadyCalc, justCalc, currentNum, operation;

- (void)viewDidLoad
{
  int random;
  [super viewDidLoad];
  myCalc = [[Calculator alloc] init];
  myCalc.accumulator = 0;
  myCalc.secondOperand = 0;
  operand1 = YES;
  alreadyCalc = NO;
  justCalc = NO;
  displayMessage = [NSMutableString stringWithCapacity:40];

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
  
  justCalc = NO;
  currentNum = 0;
  
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
}

-(IBAction) plusKey
{
  myCalc.op = '+';
  //Check to see if there was already a calculation performed
  if(alreadyCalc)
    [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  
  [self processOperation: '+'];
}

-(IBAction) minusKey
{
  myCalc.op = '-';
  if(alreadyCalc)
    [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  
  [self processOperation: '-'];
}

-(IBAction) multiplyKey
{
  myCalc.op = '*';
  if(alreadyCalc)
    [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  
  [self processOperation: '*'];
}

-(IBAction) divideKey
{
  myCalc.op = '/';
  if(alreadyCalc)
    [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  
  [self processOperation: '/'];
}

-(IBAction) numKey: (UIButton*) sender
{
  if([self isDefault])
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
  alreadyCalc = NO;
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
  alreadyCalc = YES;
  justCalc = YES;
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
  myCalc.secondOperand = currentNum;
  currentNum = 0;
  NSLog(@"This is the calculation being taken out: %i%c%i=", myCalc.accumulator, self.operation, myCalc.secondOperand);
  [self combineOperands: myCalc.accumulator withThe: myCalc.secondOperand];
  NSLog(@"%i", myCalc.accumulator);
  NSLog(@"This is the value of the new accumulator: %i", myCalc.accumulator);
  [displayMessage setString: @""];
  [displayMessage appendString: [NSString stringWithFormat: @"%i", myCalc.accumulator]];
  self.display.text = displayMessage;
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

-(BOOL) isDefault
{
  if( operand1 && !alreadyCalc )
    return YES;
  
  return NO;
}
@end
