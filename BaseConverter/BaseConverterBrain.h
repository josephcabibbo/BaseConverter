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

- (NSArray *)decimalToBinary:(double)number;

@end
