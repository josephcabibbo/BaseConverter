//
//  BaseConverterViewController.m
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseConverterViewController.h"
#import <math.h>

@implementation BaseConverterViewController

@synthesize decimalLabel;
@synthesize binaryLabel;
@synthesize hexLabel;
@synthesize octalLabel;
@synthesize hexValueCollection;
@synthesize nonOctalValueCollection;
@synthesize nonBinaryValueCollection;

- (IBAction)Go 
{
    double number = 3096;         
    double tempNumber = number; // binary
    double sameNumber = number; // hex
    double theNumber = number; // octal
    
    // Data structures used to store the conversions
    NSMutableArray *binaryArray = [[NSMutableArray alloc] init];
    NSMutableArray *hexArray = [[NSMutableArray alloc] init];
    NSMutableArray *octalArray = [[NSMutableArray alloc] init];
    
    // Compute binary conversion from decimal
    while (tempNumber != 0) 
    {
        // Store the remainder
            // fmod does this: (# - (whole number result of # / base) * base)
        double remainder = fmod(tempNumber, 2.0);
        // Perform the division
        tempNumber = tempNumber / 2;
        // Drop the remainder
        tempNumber = floor(tempNumber);
        // Add apropriate binary digit
        [binaryArray addObject:[NSNumber numberWithInt:remainder]];
    }
    
    // Print the binary conversion from decimal
    while(binaryArray.count > 0)
    {        
        binaryLabel.text = [binaryLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [binaryArray lastObject]]];
        [binaryArray removeLastObject];
    }
    
    // Compute hexadecimal conversion from decimal
    while (sameNumber != 0) 
    {   
        // Store the remainder
            // fmod does this: (# - (whole number result of # / base) * base)
        double remainder = fmod(sameNumber, 16.0);
        // Perform the division
        sameNumber = sameNumber / 16;
        // Drop the remainder
        sameNumber = floor(sameNumber);
        // Evaluate remainder
        id hexEquivalent = [self hexEvaluator:remainder];
        // Add returned value to the hexArray
        [hexArray addObject:hexEquivalent];
    }
    
    // Print the hexadecimal conversion from decimal
    while (hexArray.count > 0) 
    {
        hexLabel.text = [hexLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [hexArray lastObject]]];
        [hexArray removeLastObject];
    }
    
    // Compute the octal conversion from decimal
    while(theNumber != 0)
    {
        // Store remainder
        double remainder = fmod(theNumber, 8.0);
        // Perform division
        theNumber = theNumber / 8.0;
        // Drop the remainder
        theNumber = floor(theNumber);
        // Add appropriate octal digit
        [octalArray addObject:[NSNumber numberWithInt:remainder]];
        
    }
    
    // Print the octal conversion from decimal
    while(octalArray.count > 0)
    {
        octalLabel.text = [octalLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [octalArray lastObject]]];
        [octalArray removeLastObject];
    }
}

// Enable/Disable buttons when a base button is pressed
- (IBAction)baseButtonPressed:(UIButton *)sender 
{
    // Decimal selected
    if([sender.currentTitle isEqualToString:@"Dec"])
    {
        // Disable invalid buttons
        [self disableHexValues];
        // Enable valid buttons
        [self enableDecimalValues];
    }
    // Octal selected
    if([sender.currentTitle isEqualToString:@"Oct"])
    {
        // Disable invalid buttons
        [self disableHexValues];
        [self disableNonOctalValues];
        // Enable valid buttons
        [self enableOctalValues];
    }
    // Binary selected
    if([sender.currentTitle isEqualToString:@"Bin"])
    {
        // Disable invalid buttons
        [self disableHexValues];
        [self disableNonOctalValues];
        [self disableNonBinaryValues];
    }
    // Hex selected
    if([sender.currentTitle isEqualToString:@"Hex"])
    {
        // Enable valid buttons
        [self enableHexValues];
    }
}

// This action will display the appropriate digits on the view as 
//  well as send the values to the brain to compute the other bases
- (IBAction)digitPressed:(UIButton *)sender 
{
//    NSLog(@"%@", sender.currentTitle);
}

// Convert integers > 10 to their hex equivalent
- (id)hexEvaluator:(double)remainder
{
    if(remainder < 10) 
        return [NSNumber numberWithInt:(int)remainder];
    else if(remainder < 16) 
        return [NSString stringWithFormat:@"%X", (int)remainder];
    else 
        return nil;
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
