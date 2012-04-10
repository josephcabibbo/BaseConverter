//
//  BaseConverterViewController.h
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseConverterViewController : UIViewController

// Displayed Labels
@property (weak, nonatomic) IBOutlet UILabel *decimalLabel;
@property (weak, nonatomic) IBOutlet UILabel *binaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *hexLabel;
@property (weak, nonatomic) IBOutlet UILabel *octalLabel;

// OutletConnections for disabling non valid buttons
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *hexValueCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *nonOctalValueCollection;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *nonBinaryValueCollection;

// Handles the selection of different bases
- (IBAction)baseButtonPressed:(UIButton *)sender;

// Handles the input
- (IBAction)digitPressed:(UIButton *)sender;

// Handles the clear button
- (IBAction)clearDisplayPressed;

// Handles the backspace button
- (IBAction)backspacePressed;
@end
