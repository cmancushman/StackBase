//
//  FrameCalculator.h
//  StackBase
//
//  Created by Chris Cushman on 10/31/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>




@interface FrameCalculator : NSObject


+(CGRect)frameOfDesiredText:(NSString *)text withFont:(UIFont *)font andWidth:(CGFloat)width;


@end
