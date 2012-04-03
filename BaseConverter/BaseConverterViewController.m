//
//  BaseConverterViewController.m
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BaseConverterViewController.h"
#import <Math.h>

@interface BaseConverterViewController ()
@end

@implementation BaseConverterViewController
@synthesize binaryLabel;

- (IBAction)Go 
{
    double number = 327;
        
    NSMutableArray *binaryArray = [[NSMutableArray alloc] init];
    
    // Fill the array with the correct binary conversion
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
    
    // Print the binary conversion in the binary label
    
    NSNumber *lastObject;
    
    while(binaryArray.count > 0)
    {        
        lastObject = [binaryArray lastObject];
        binaryLabel.text = [binaryLabel.text stringByAppendingString:[NSString stringWithFormat:@"%@", lastObject]];
        [binaryArray removeLastObject];
    }
}

- (void)viewDidUnload {
    [self setBinaryLabel:nil];
    [super viewDidUnload];
}
@end
