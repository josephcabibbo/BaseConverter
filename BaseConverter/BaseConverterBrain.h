//
//  BaseConverterBrain.h
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseConverterBrain : NSObject

// Data structures used to store the conversions
@property (nonatomic) NSMutableArray *binaryArray;
@property (nonatomic) NSMutableArray *decimalArray;
@property (nonatomic) NSMutableArray *octalArray;
@property (nonatomic) NSMutableArray *hexArray;

// Compute binary conversion from decimal
- (NSMutableArray *)decimalToBinary:(double)number;
// Compute hex conversion from decimal
- (NSMutableArray *)decimalToHex:(double)number;
// Compute the octal conversion from decimal
- (NSMutableArray *)decimalToOctal:(double)number;

@end
