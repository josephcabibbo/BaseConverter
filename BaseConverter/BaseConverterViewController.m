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

@synthesize binaryLabel;
@synthesize hexLabel;
@synthesize octalLabel;

- (IBAction)Go 
{
    double number = 14;
    double tempNumber = number;
    double sameNumber = number;
    
    // Data structures used to store the conversions
    NSMutableArray *binaryArray = [[NSMutableArray alloc] init];
    NSMutableArray *hexArray = [[NSMutableArray alloc] init];
    
    // Compute binary conversion
    while (tempNumber != 0) 
    {
        // Store the remainder
            // fmod does this: (# - (whole number result of # / base) * base)
        double remainder = fmod(tempNumber, 2.0);
        // Perform the division
        tempNumber = tempNumber / 2;
        // Drop the remainder
        tempNumber = floor(tempNumber);
        [binaryArray addObject:[NSNumber numberWithInt:remainder]];
    }
    
    // Print the binary conversion
    while(binaryArray.count > 0)
    {        
        binaryLabel.text = [binaryLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [binaryArray lastObject]]];
        [binaryArray removeLastObject];
    }
    
    // Compute hexadecimal conversion
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
    
    // Print the hexadecimal conversion
    while (hexArray.count > 0) 
    {
        hexLabel.text = [hexLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [hexArray lastObject]]];
        [hexArray removeLastObject];
    }
    
    // TODO:
    // Compute the octal conversion
    // Print the octal conversion
    
}

- (id)hexEvaluator:(double)remainder
{
    if(remainder < 10) 
        return [NSNumber numberWithInt:(int)remainder];
    else if(remainder < 16) 
        return [NSString stringWithFormat:@"%X", (int)remainder];
    else 
        return nil;
}

- (void)viewDidUnload {
    [self setBinaryLabel:nil];
    [self setHexLabel:nil];
    [self setOctalLabel:nil];
    [super viewDidUnload];
}

@end
