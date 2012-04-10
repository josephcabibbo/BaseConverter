//
//  BaseConverterBrain.h
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseConverterBrain : NSObject

// Data structures used to store conversions
@property (nonatomic) NSMutableArray *binaryArray;
@property (nonatomic) NSMutableArray *decimalArray;
@property (nonatomic) NSMutableArray *octalArray;
@property (nonatomic) NSMutableArray *hexArray;

// Compute binary conversion from decimal
- (void)decimalToBinary:(double)number;
// Compute hex conversion from decimal
- (void)decimalToHex:(double)number;
// Compute the octal conversion from decimal
- (void)decimalToOctal:(double)number;

// Compute the decimal conversion from binary
- (void)binaryToDecimal:(NSString *)numberString;

// Compute the decimal conversion from hexadecimal
- (void)hexToDecimal:(NSString *)numberString;

// Compute the decimal conversion from octal
- (void)octalToDecimal:(NSString *)numberString;

@end
