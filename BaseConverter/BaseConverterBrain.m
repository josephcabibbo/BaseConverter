//
//  BaseConverterBrain.m
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseConverterBrain.h"

@implementation BaseConverterBrain

@synthesize binaryArray = _binaryArray;
@synthesize decimalArray = _decimalArray;
@synthesize octalArray = _octalArray;
@synthesize hexArray = _hexArray;

// Lazy instantiation for binaryArray
- (NSMutableArray *)binaryArray
{
    if(_binaryArray == nil)
        _binaryArray = [[NSMutableArray alloc] init];
    return _binaryArray;
}
// Lazy instantiation for decimalArray
- (NSMutableArray *)decimalArray
{
    if(_decimalArray == nil)
        _decimalArray = [[NSMutableArray alloc] init];
    return _decimalArray;
}
// Lazy instantiation for octalArray
- (NSMutableArray *)octalArray
{
    if(_octalArray == nil)
        _octalArray = [[NSMutableArray alloc] init];
    return _octalArray;
}
// Lazy instantiation for hexArray
- (NSMutableArray *)hexArray
{
    if(_hexArray == nil)
        _hexArray = [[NSMutableArray alloc] init];
    return _hexArray;
}

// Compute decimal conversion from binary
- (void)binaryToDecimal:(NSString *)numberString
{
    int currentPower = 0;
    char currentValueChar;
    int currentValue;
    int convertedValue;
    int sum = 0;
    
    for(int i = 1; i < [numberString length] + 1; i++)
    {
        // Get the index for the last "unprocessed" character in the string
        NSUInteger index = [numberString length] - i;
        // Get the character at that index
        currentValueChar = [numberString characterAtIndex:index];
        // Convert the char to type int
        currentValue = atoi(&currentValueChar);
        // Calculate the conversion
        convertedValue = currentValue * pow(2, currentPower);
        // Add it to the "conversion sum"
        sum += convertedValue;
        // Increment the power
        currentPower++;
    }
    
    // Add converted sum to array
    [_decimalArray addObject:[NSNumber numberWithInt:sum]];
}

// Compute the decimal conversion from hexadecimal
- (void)hexToDecimal:(NSString *)numberString
{
    int currentPower = 0;
    char currentValueChar;
    int currentValue;
    int convertedValue;
    int sum = 0;
    
    for(int i = 1; i < [numberString length] + 1; i++)
    {
        // Get the index for the last "unprocessed" character in the string
        NSUInteger index = [numberString length] - i;
        // Get the character at that index
        currentValueChar = [numberString characterAtIndex:index];
        // Check to see if the char is a hex letter
        if ([self isHexLetter:currentValueChar]) 
        {
            // Switch the letter with its associated int value
            currentValue = [self switchHexLetter:currentValueChar];
        }
        else
        {
            // Convert the char to type int
            currentValue = atoi(&currentValueChar);
        }
        // Calculate the conversion
        convertedValue = currentValue * pow(16, currentPower);
        // Add it to the "conversion sum"
        sum += convertedValue;
        // Increment the power
        currentPower++;
    }
    // Add converted sum to array
    [_decimalArray addObject:[NSNumber numberWithInt:sum]];
}

// Compute the decimal conversion from octal
- (void)octalToDecimal:(NSString *)numberString
{
    int currentPower = 0;
    char currentValueChar;
    int currentValue;
    int convertedValue;
    int sum = 0;
    
    for(int i = 1; i < [numberString length] + 1; i++)
    {
        // Get the index for the last "unprocessed" character in the string
        NSUInteger index = [numberString length] - i;
        // Get the character at that index
        currentValueChar = [numberString characterAtIndex:index];
        // Convert the char to type int
        currentValue = atoi(&currentValueChar);
        // Calculate the conversion
        convertedValue = currentValue * pow(8, currentPower);
        // Add it to the "conversion sum"
        sum += convertedValue;
        // Increment the power
        currentPower++;
    }
    
    // Add converted sum to array
    [_decimalArray addObject:[NSNumber numberWithInt:sum]];
}

// Compute binary conversion from decimal
- (void)decimalToBinary:(double)number
{    
    while (number != 0) 
    {
        // Store the remainder
        //  fmod does this: (# - (whole number result of # / base) * base)
        double remainder = fmod(number, 2.0);
        // Perform the division
        number = number / 2;
        // Drop the remainder
        number = floor(number);
        // Add apropriate binary digit
        [_binaryArray addObject:[NSNumber numberWithInt:remainder]];
    }
}

// Compute hexadecimal conversion from decimal
- (void)decimalToHex:(double)number
{
    while (number != 0) 
    {   
        // Store the remainder
        // fmod does this: (# - (whole number result of # / base) * base)
        double remainder = fmod(number, 16.0);
        // Perform the division
        number = number / 16;
        // Drop the remainder
        number = floor(number);
        // Evaluate remainder
        id hexEquivalent = [self hexEvaluator:remainder];
        // Add returned value to the hexArray
        [_hexArray addObject:hexEquivalent];
    }
}

// Compute the octal conversion from decimal
- (void)decimalToOctal:(double)number
{
    while(number != 0)
    {
        // Store remainder
        double remainder = fmod(number, 8.0);
        // Perform division
        number = number / 8.0;
        // Drop the remainder
        number = floor(number);
        // Add appropriate octal digit
        [_octalArray addObject:[NSNumber numberWithInt:remainder]];
    }
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

- (BOOL)isHexLetter:(char)value
{
    switch (value) 
    {
        case 'F': return true; break;
        case 'E': return true; break;
        case 'D': return true; break;
        case 'C': return true; break;
        case 'B': return true; break;
        case 'A': return true; break;
        default: return false; break;
    }
}

- (int) switchHexLetter:(char)value
{
    switch (value) 
    {
        case 'F': return 15; break;
        case 'E': return 14; break;
        case 'D': return 13; break;
        case 'C': return 12; break;
        case 'B': return 11; break;
        case 'A': return 10; break;
        default: return -1; break;
    }
}

@end