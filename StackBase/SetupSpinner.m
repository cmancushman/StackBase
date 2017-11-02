//
//  Setup Spinner.m
//  StackBase
//
//  Created by Chris Cushman on 10/30/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "SetupSpinner.h"




@implementation SetupSpinner


-(instancetype)initWithSuperView:(UIView *)superView{
    
    self = [super initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    self.center = CGPointMake(superView.frame.size.width/2, superView.frame.size.height/2);
    
    self.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    
    [self startAnimating];
    
    return self;
    
}


-(void)clear{
    
    [UIView animateWithDuration:1.0 animations:^{
       
        self.alpha = 0;
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
}


@end
