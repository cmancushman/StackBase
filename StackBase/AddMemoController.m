//
//  AddMemoController.m
//  StackBase
//
//  Created by Chris Cushman on 11/2/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "AddMemoController.h"




@interface AddMemoController()


@property AddMemoView *addMemoView;


@end




@implementation AddMemoController


-(void)addToView:(UIView *)view{
        
    self.addMemoView = [[AddMemoView alloc] initWithFrame:view.bounds];
    
    self.addMemoView.dataDelegate = self;
    
    [view addSubview: self.addMemoView];
    
}


-(void)textWasAccepted:(NSString *)text{
    
    [self.addMemoView remove];
    
    [self.delegate addMemo:text];
    
}

-(void)dataEntryWasExited{
    
    [self.addMemoView remove];
    
}

@end
