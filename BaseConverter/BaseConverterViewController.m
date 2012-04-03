//
//  BaseConverterViewController.m
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseConverterViewController.h"
#import <math.h>

@interface BaseConverterViewController ()
@end

@implementation BaseConverterViewController
@synthesize binaryLabel;
@synthesize hexLabel;

- (IBAction)Go 
{
    double number = 999;
    double sameNumber = number;
        
    NSMutableArray *binaryArray = [[NSMutableArray alloc] init];
    NSMutableArray *hexArray = [[NSMutableArray alloc] init];
    
    // Fill the binaryArray
    while (number != 0) 
    {
        BOOL noRemainder = remainder(number, 2.0) == 0;
        
        number = number / 2;

        if (noRemainder) 
        {
            [binaryArray addObject:[NSNumber numberWithInt:0]];
        }
        else
        {
            [binaryArray addObject:[NSNumber numberWithInt:1]];
            number = floor(number); // Drop the remainder
        }
    }
    
    // Print the binaryArray
    NSNumber *lastObject;
    while(binaryArray.count > 0)
    {        
        lastObject = [binaryArray lastObject];
        binaryLabel.text = [binaryLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", lastObject]];
        [binaryArray removeLastObject];
    }
    
    // Fill the hexArray
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
    
    // Print the hexArray
    while (hexArray.count > 0) 
    {
        hexLabel.text = [hexLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", [hexArray lastObject]]];
        [hexArray removeLastObject];
    }
}

- (id)hexEvaluator:(double)remainder
{
    
//    if(remainder == 0) {return [NSNumber numberWithInt:0];}
//    else if(remainder == 1) {return [NSNumber numberWithInt:1];}
//    else if(remainder == 2) {return [NSNumber numberWithInt:2];}
//    else if(remainder == 3) {return [NSNumber numberWithInt:3];}
//    else if(remainder == 4) {return [NSNumber numberWithInt:4];}
//    else if(remainder == 5) {return [NSNumber numberWithInt:5];}
//    else if(remainder == 6) {return [NSNumber numberWithInt:6];}
//    else if(remainder == 7) {return [NSNumber numberWithInt:7];}
//    else if(remainder == 8) {return [NSNumber numberWithInt:8];}
//    else if(remainder == 9) {return [NSNumber numberWithInt:9];}
//    else if(remainder == 10) {return @"A";}
//    else if(remainder == 11) {return @"B";}
//    else if(remainder == 12) {return @"C";}
//    else if(remainder == 13) {return @"D";}
//    else if(remainder == 14) {return @"E";}
//    else if(remainder == 15) {return @"F";}
//    else return nil;
    
    switch ((int)remainder) 
    {
        case 0:  return [NSNumber numberWithInt:0]; break;
        case 1:  return [NSNumber numberWithInt:1]; break;
        case 2:  return [NSNumber numberWithInt:2]; break;
        case 3:  return [NSNumber numberWithInt:3]; break;
        case 4:  return [NSNumber numberWithInt:4]; break;
        case 5:  return [NSNumber numberWithInt:5]; break;
        case 6:  return [NSNumber numberWithInt:6]; break;
        case 7:  return [NSNumber numberWithInt:7]; break;
        case 8:  return [NSNumber numberWithInt:8]; break;
        case 9:  return [NSNumber numberWithInt:9]; break;
        case 10: return @"A";; break;
        case 11: return @"B";; break;
        case 12: return @"C";; break;
        case 13: return @"D";; break;
        case 14: return @"E";; break;
        case 15: return @"F";; break;
        
        default: return nil; break;
    }
}

- (void)viewDidUnload {
    [self setBinaryLabel:nil];
    [self setHexLabel:nil];
    [super viewDidUnload];
}

@end
