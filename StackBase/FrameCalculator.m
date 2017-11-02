//
//  FrameCalculator.m
//  StackBase
//
//  Created by Chris Cushman on 10/31/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "FrameCalculator.h"




@implementation FrameCalculator


+(CGRect)frameOfDesiredText:(NSString *)text withFont:(UIFont *)font andWidth:(CGFloat)width{
    
    CGSize constraintSize = CGSizeMake(width, MAXFLOAT);
    
    CGRect labelFrame = [text boundingRectWithSize: constraintSize options:NSStringDrawingUsesLineFragmentOrigin| NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:font} context:nil];
    
    return labelFrame;
    
}


@end
