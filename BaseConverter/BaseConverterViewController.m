//
//  BaseConverterViewController.m
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseConverterViewController.h"
#import <math.h>
#import "BaseConverterBrain.h"

// Private Interface
@interface BaseConverterViewController()

// BOOLs for handling which base has been selected
@property (nonatomic) BOOL hexSelected;
@property (nonatomic) BOOL binSelected;
@property (nonatomic) BOOL decSelected;
@property (nonatomic) BOOL octSelected;

// A brain (model) to perform base conversions
@property (nonatomic, strong) BaseConverterBrain *brain;

@end

@implementation BaseConverterViewController

@synthesize decimalLabel;
@synthesize binaryLabel;
@synthesize hexLabel;
@synthesize octalLabel;
@synthesize hexValueCollection;
@synthesize nonOctalValueCollection;
@synthesize nonBinaryValueCollection;
@synthesize hexSelected;
@synthesize binSelected;
@synthesize decSelected;
@synthesize octSelected;
@synthesize brain = _brain;

// Lazy instantiation for BaseConverterBrain
- (BaseConverterBrain *)brain
{
    if(_brain == nil)
        _brain = [[BaseConverterBrain alloc] init];
    return _brain;
}

// Enable/Disable buttons when a base button is pressed
//  Handle labels (Bools and clears)
- (IBAction)baseButtonPressed:(UIButton *)sender 
{
    // Decimal selected
    if([sender.currentTitle isEqualToString:@"Dec"])
    {
        // Disable invalid buttons
        [self disableHexValues];
        // Enable valid buttons
        [self enableDecimalValues];
        // Handle selection bools
        decSelected = YES;
        binSelected = NO;
        hexSelected = NO;
        octSelected = NO;
        // Clear labels to start fresh
        [self clearLabels];
    }
    // Octal selected
    if([sender.currentTitle isEqualToString:@"Oct"])
    {
        // Disable invalid buttons
        [self disableHexValues];
        [self disableNonOctalValues];
        // Enable valid buttons
        [self enableOctalValues];
        // Handle selection bools
        decSelected = NO;
        binSelected = NO;
        hexSelected = NO;
        octSelected = YES;
        // Clear labels to start fresh
        [self clearLabels];

    }
    // Binary selected
    if([sender.currentTitle isEqualToString:@"Bin"])
    {
        // Disable invalid buttons
        [self disableHexValues];
        [self disableNonOctalValues];
        [self disableNonBinaryValues];
        // Handle selection bools
        decSelected = NO;
        binSelected = YES;
        hexSelected = NO;
        octSelected = NO;
        // Clear labels to start fresh
        [self clearLabels];

    }
    // Hex selected
    if([sender.currentTitle isEqualToString:@"Hex"])
    {
        // Enable valid buttons
        [self enableHexValues];
        // Handle selection bools
        decSelected = NO;
        binSelected = NO;
        hexSelected = YES;
        octSelected = NO;
        // Clear labels to start fresh
        [self clearLabels];
        
    }
}

// This action will display the appropriate digits on the view as 
//  well as send the values to the brain to compute the other bases
- (IBAction)digitPressed:(UIButton *)sender 
{
    // Decimal selected
    if (decSelected) 
    {
        // Display the values in the decimalLabel
        decimalLabel.text = [decimalLabel.text stringByAppendingString:sender.currentTitle];
        // Send input to brain
        [self.brain decimalToBinary:[decimalLabel.text doubleValue]];
        [self.brain decimalToHex:[decimalLabel.text doubleValue]];
        [self.brain decimalToOctal:[decimalLabel.text doubleValue]];
        // Display the conversions
        [self printBinaryConversion:[self.brain binaryArray]];
        [self printHexConversion:[self.brain hexArray]];
        [self printOctalConversion:[self.brain octalArray]];
        
    }
    // Binary selected
    if (binSelected) 
    {
        // Display the values in the binaryLabel
        binaryLabel.text = [binaryLabel.text stringByAppendingString:sender.currentTitle];
        // Send input to brain and convert to decimal
        [self.brain binaryToDecimal:binaryLabel.text];
        // Display decimal conversion
        [self printDecimalConversion:[self.brain decimalArray]];
        // Send decimal value to brain
        [self.brain decimalToHex:[decimalLabel.text doubleValue]];
        [self.brain decimalToOctal:[decimalLabel.text doubleValue]];
        // Display the remaining conversions
        [self printHexConversion:[self.brain hexArray]];
        [self printOctalConversion:[self.brain octalArray]];
    }
    // Hex selected
    if (hexSelected) 
    {
        // Display the values in the hexLabel
        hexLabel.text = [hexLabel.text stringByAppendingString:sender.currentTitle];
        // Send input to brain and convert to decimal
        [self.brain hexToDecimal:hexLabel.text];
        // Display decimal conversion
        [self printDecimalConversion:[self.brain decimalArray]];
        // Send decimal value to brain
        [self.brain decimalToBinary:[decimalLabel.text doubleValue]];
        [self.brain decimalToOctal:[decimalLabel.text doubleValue]];
        // Display the remaining conversions
        [self printBinaryConversion:[self.brain binaryArray]];
        [self printOctalConversion:[self.brain octalArray]];
    }
    // Octal selected
    if (octSelected) 
    {
        // Display the values in the octalLabel
        octalLabel.text = [octalLabel.text stringByAppendingString:sender.currentTitle];
        // Send input to brain and convert to decimal
        [self.brain octalToDecimal:octalLabel.text];
        // Display decimal conversion
        [self printDecimalConversion:[self.brain decimalArray]];
        // Send decimal value to brain
        [self.brain decimalToHex:[decimalLabel.text doubleValue]];
        [self.brain decimalToBinary:[decimalLabel.text doubleValue]];
        // Display the remaining conversions
        [self printHexConversion:[self.brain hexArray]];
        [self printBinaryConversion:[self.brain binaryArray]];
    }
}

- (IBAction)clearDisplayPressed 
{
    [self clearLabels];
}

- (IBAction)backspacePressed 
{
    if( decSelected )
    {
        if( ! [self.decimalLabel.text length] == 0 )
        {
            // Remove last added value
            self.decimalLabel.text = [self.decimalLabel.text substringToIndex:[self.decimalLabel.text length] - 1];
            // Send NEW input to brain
            [self.brain decimalToBinary:[decimalLabel.text doubleValue]];
            [self.brain decimalToHex:[decimalLabel.text doubleValue]];
            [self.brain decimalToOctal:[decimalLabel.text doubleValue]];
            // Display the conversions
            [self printBinaryConversion:[self.brain binaryArray]];
            [self printHexConversion:[self.brain hexArray]];
            [self printOctalConversion:[self.brain octalArray]];
        }
    }
    else if( binSelected )
    {
        if( ! [self.binaryLabel.text length] == 0 )
        {
            // Remove last added value
            self.binaryLabel.text = [self.binaryLabel.text substringToIndex:[self.binaryLabel.text length] - 1];
            // Send input to brain and convert to decimal
            [self.brain binaryToDecimal:binaryLabel.text];
            // Display decimal conversion
            [self printDecimalConversion:[self.brain decimalArray]];
            // Send decimal value to brain
            [self.brain decimalToHex:[decimalLabel.text doubleValue]];
            [self.brain decimalToOctal:[decimalLabel.text doubleValue]];
            // Display the remaining conversions
            [self printHexConversion:[self.brain hexArray]];
            [self printOctalConversion:[self.brain octalArray]];
        }
    }
    else if( hexSelected )
    {
        if( ! [self.hexLabel.text length] == 0 )
        {
            // Remove last added value
            self.hexLabel.text = [self.hexLabel.text substringToIndex:[self.hexLabel.text length] - 1];
            // Send input to brain and convert to decimal
            [self.brain hexToDecimal:hexLabel.text];
            // Display decimal conversion
            [self printDecimalConversion:[self.brain decimalArray]];
            // Send decimal value to brain
            [self.brain decimalToBinary:[decimalLabel.text doubleValue]];
            [self.brain decimalToOctal:[decimalLabel.text doubleValue]];
            // Display the remaining conversions
            [self printBinaryConversion:[self.brain binaryArray]];
            [self printOctalConversion:[self.brain octalArray]];
        }
    }
    else if( octSelected )
    {
        if( ! [self.octalLabel.text length] == 0 )
        {
            // Remove last added value
            self.octalLabel.text = [self.octalLabel.text substringToIndex:[self.octalLabel.text length] - 1];
            // Send input to brain and convert to decimal
            [self.brain octalToDecimal:octalLabel.text];
            // Display decimal conversion
            [self printDecimalConversion:[self.brain decimalArray]];
            // Send decimal value to brain
            [self.brain decimalToHex:[decimalLabel.text doubleValue]];
            [self.brain decimalToBinary:[decimalLabel.text doubleValue]];
            // Display the remaining conversions
            [self printHexConversion:[self.brain hexArray]];
            [self printBinaryConversion:[self.brain binaryArray]];
        }
    }
}

// Disable hex buttons
- (IBAction)disableHexValues 
{
    for(UIButton *hexButton in hexValueCollection)
    {
        hexButton.enabled = NO;
        [hexButton setAlpha:.3];
    }
}

// Disable non octal buttons
- (IBAction)disableNonOctalValues 
{
    for(UIButton *nonOctalButton in nonOctalValueCollection)
    {
        nonOctalButton.enabled = NO;
        [nonOctalButton setAlpha:.3];
    }
}

// Disable non binary buttons
- (IBAction)disableNonBinaryValues 
{
    for(UIButton *nonBinaryButton in nonBinaryValueCollection)
    {
        nonBinaryButton.enabled = NO;
        [nonBinaryButton setAlpha:.3];
    }
}

// Enable valid decimal buttons
- (IBAction)enableDecimalValues 
{
    // Combine octal and binary button collections in one array
    NSMutableArray *decimalButtonCollection = [NSMutableArray array];
    [decimalButtonCollection addObjectsFromArray:nonBinaryValueCollection];
    [decimalButtonCollection addObjectsFromArray:nonOctalValueCollection];
    
    for(UIButton *decimalButton in decimalButtonCollection)
    {
        decimalButton.enabled = YES;
        [decimalButton setAlpha:1];
    }
}

// Enable valid octal buttons
- (IBAction)enableOctalValues 
{    
    for(UIButton *octalButton in nonBinaryValueCollection)
    {
        octalButton.enabled = YES;
        [octalButton setAlpha:1];
    }
}

// Enable valid hex buttons
- (IBAction)enableHexValues 
{
    // Combine octal, binary, and decimal button collections in one array
    NSMutableArray *allHexButtons = [NSMutableArray array];
    [allHexButtons addObjectsFromArray:nonOctalValueCollection];
    [allHexButtons addObjectsFromArray:nonBinaryValueCollection];
    [allHexButtons addObjectsFromArray:hexValueCollection];
    
    for(UIButton *hexButton in allHexButtons)
    {
        hexButton.enabled = YES;
        [hexButton setAlpha:1];
    }
}

// Clear all labels
- (void)clearLabels
{
    decimalLabel.text = @"";
    octalLabel.text = @"";
    binaryLabel.text = @"";
    hexLabel.text = @"";
    
}

// Print the binary conversion
- (void)printBinaryConversion:(NSMutableArray *)binArray
{ 
    // Reset the binaryLabel for new output
    binaryLabel.text = @"";
    // Print the binary conversion
    while(binArray.count > 0)
    {        
        binaryLabel.text = [binaryLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [binArray lastObject]]];
        [binArray removeLastObject];
    }    
}

// Print the hexadecimal conversion
- (void)printHexConversion:(NSMutableArray *)hexArray
{
    // Reset the hexLabel for new output
    hexLabel.text = @"";
    // Print the hexadecimal conversion
    while (hexArray.count > 0) 
    {
        hexLabel.text = [hexLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [hexArray lastObject]]];
        [hexArray removeLastObject];
    }
}

// Print the octal conversion
- (void)printOctalConversion:(NSMutableArray *)octArray
{
    // Reset the octalLabel for new output
    octalLabel.text = @"";
    // Print the octal conversion
    while(octArray.count > 0)
    {
        octalLabel.text = [octalLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [octArray lastObject]]];
        [octArray removeLastObject];
    }
}

- (void)printDecimalConversion:(NSMutableArray *)decArray
{
    // Reset the decimalLabel for new output
    decimalLabel.text = @"";
    // Print the decimal conversion
    while(decArray.count > 0)
    {
        decimalLabel.text = [decimalLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [decArray lastObject]]];
        [decArray removeLastObject];
    }
}

// The default settings upon loading app
- (void) viewDidLoad
{
    decSelected = YES;
    [self disableHexValues];
    // Initialize Arrays
    [self.brain binaryArray];
    [self.brain decimalArray];
    [self.brain octalArray];
    [self.brain hexArray];
}

- (void)viewDidUnload {
    [self setBinaryLabel:nil];
    [self setHexLabel:nil];
    [self setOctalLabel:nil];
    [self setDecimalLabel:nil];
    [self setHexValueCollection:nil];
    [self setNonOctalValueCollection:nil];
    [self setNonBinaryValueCollection:nil];
    [super viewDidUnload];
}

@end
