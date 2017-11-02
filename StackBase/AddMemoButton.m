//
//  AddMemoButton.m
//  StackBase
//
//  Created by Chris Cushman on 11/2/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "AddMemoButton.h"
#import "AddMemoController.h"

@implementation AddMemoButton

-(instancetype)initWithFrame:(CGRect)frame andTargetView:(UIView *)targetView{
    
    self = [super initWithFrame:frame];
    
    self.targetView = targetView;
    
    self.tag = 20;
    
    self.tintColor = [UIColor blackColor];
    
    [self setImage:[[UIImage imageNamed:@"AddButton.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
    
    [self addTarget:self action:@selector(addRecord) forControlEvents:UIControlEventTouchUpInside];
    
    return self;
    
}


-(void)hide{
    
    [UIView animateWithDuration:0 animations:^{
        
        self.transform = CGAffineTransformMakeTranslation(self.targetView.frame.size.width - self.frame.origin.x, 0);
        
    }];
    
}

-(void)unhide{

    [UIView animateWithDuration:1.0 animations:^{
        
        self.transform = CGAffineTransformIdentity;
        
    }];
    
}


-(void)addRecord{
    
    [self.delegate displayAddMemoView];
    
}



@end
