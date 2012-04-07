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

- (NSMutableArray *)decimalToBinary:(double)number
{    
    // Compute binary conversion from decimal
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

@end