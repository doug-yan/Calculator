//
//  ViewController.h
//  Calculator
//
//  Created by Douglas  Yan on 5/22/14.
//  Copyright (c) 2014 Objective_C_Test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Calculator.h"

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *display;
@property (nonatomic) BOOL isOperand1;
@property (nonatomic) BOOL isJustCalc;
@property (nonatomic) BOOL isDecimalPoint;
@property (nonatomic) double currentNum;
@property (nonatomic) char operation;

//Storing data from key presses
-(void) putNumberInDisplayAndCalculator: (double) number;
-(void) putOperationInCalculator: (char) op;

//Operational Actions
-(IBAction) plusKeyPressed;
-(IBAction) minusKeyPressed;
-(IBAction) multiplyKeyPressed;
-(IBAction) divideKeyPressed;

//Inputting Numbers
-(IBAction) numKeyPressed: (UIButton*) sender;
-(IBAction) decimalKeyPressed;
-(IBAction) piKeyPressed;

//Miscellaneous Functions
-(IBAction) clearKeyPressed;
-(IBAction) equalsKeyPressed;
-(void) combineOperandsIntoAccumulator;

-(int) getNumberOfSignificantDigits: (double) itemToConvert;
/*
 Functions to add
 sin, cos, store, recall
 convert to fraction, switch to double
 set decimal accuracy
 */
@end
