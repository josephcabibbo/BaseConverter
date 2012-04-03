//
//  BaseConverterViewController.h
//  BaseConverter
//
//  Created by Joey Cabibbo on 4/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseConverterViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *binaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *hexLabel;
@property (weak, nonatomic) IBOutlet UILabel *octalLabel;

- (IBAction)Go;

@end
