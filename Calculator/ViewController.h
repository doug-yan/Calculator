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
@property (nonatomic) BOOL operand1;
@property (nonatomic) BOOL justCalc;
@property (nonatomic) BOOL decimalPoint;
@property (nonatomic) double currentNum;
@property (nonatomic) char operation;

//Storing data from key presses
-(void) processNumber: (double) number; //used to display the digit to the screen
-(void) processOperation: (char) op;

//Operational Actions
-(IBAction) plusKey;
-(IBAction) minusKey;
-(IBAction) multiplyKey;
-(IBAction) divideKey;

//Inputting Numbers
-(IBAction) numKey: (UIButton*) sender;
-(IBAction) decimalKey;
-(IBAction) piKey;

//Miscellaneous Functions
-(IBAction) clearKey;
-(IBAction) equalsKey;
-(void) combineOperands: (double)firstOne withThe: (double)secondOne;
-(IBAction) storeValue;

-(int) getFormattedFloat: (double) itemToConvert;
/*
 Functions to add
 sin, cos, constants (pi, e), store, recall
 convert to fraction, switch to double
 set decimal accuracy
 */
@end
