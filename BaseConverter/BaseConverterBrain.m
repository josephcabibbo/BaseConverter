//
//  BaseConverterBrain.m
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseConverterBrain.h"

@interface BaseConverterBrain()

//// Data structures used to store the conversions
//@property (nonatomic) NSMutableArray *binaryArray;
//@property (nonatomic) NSMutableArray *decimalArray;
//@property (nonatomic) NSMutableArray *octalArray;
//@property (nonatomic) NSMutableArray *hexArray;

@end

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

// Compute binary conversion from decimal
- (NSMutableArray *)decimalToBinary:(double)number
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
    
    return [_binaryArray mutableCopy];
}

// Compute hexadecimal conversion from decimal
- (NSMutableArray *)decimalToHex:(double)number
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
    
    return [_hexArray mutableCopy];
}

// Compute the octal conversion from decimal
- (NSMutableArray *)decimalToOctal:(double)number
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
    
    return [_octalArray mutableCopy];
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

@end