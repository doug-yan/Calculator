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
@property (nonatomic) BOOL justPressedEquals;
@property (nonatomic) int currentNum;
@property (nonatomic) char operation;

//Storing data from key presses
-(void) processNumber: (int) number; //used to display the digit to the screen
-(void) processOperation: (char) op;

//Numerical Actions
-(IBAction) plusKey;
-(IBAction) minusKey;
-(IBAction) multiplyKey;
-(IBAction) divideKey;

//Inputting Numbers
-(IBAction) numKey: (UIButton*) sender;

//Miscellaneous Functions
-(IBAction) clearKey;
-(IBAction) equalsKey;
-(void) combineOperands: (int)firstOne withThe: (int)secondOne;
-(BOOL) isDefault;
/*
 Functions to add
 sin, cos, constants (pi, e), store, recall
 convert to fraction, switch to double
 set decimal accuracy
 */
@end
