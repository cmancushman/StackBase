//
//  AddMemoView.m
//  StackBase
//
//  Created by Chris Cushman on 11/2/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "AddMemoView.h"
#import "ViewConstants.h"




@interface AddMemoView()


@property UIView *background;

@property DataEntry *dataEntry;


@end




@implementation AddMemoView


-(void)didMoveToSuperview{
    
    [self addBackground];
    
    [self addDataEntry];
    
    [self animateIn];

    
    
}

-(void)addBackground{
    
    self.background = [[UIView alloc] initWithFrame:self.frame];
    
    self.background.alpha = 0;
    
    self.background.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.background];
    
}

-(void)addDataEntry{
    
    self.dataEntry = [[DataEntry alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.frame.size.width, 100)];
    
    self.dataEntry.dataEntryDelegate = self.dataDelegate;
    
    self.dataEntry.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height - self.dataEntry.frame.origin.y);
    
    [self addSubview:self.dataEntry];
    
}

-(void)animateIn{
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.background.alpha = .5;
        
        self.dataEntry.transform = CGAffineTransformIdentity;
        
    }];
    
}


-(void)remove{
    
    [UIView animateWithDuration:.5 animations:^{
        
        self.background.alpha = 0;
        
        self.dataEntry.transform = CGAffineTransformMakeTranslation(0, self.frame.size.height - self.dataEntry.frame.origin.y);

    } completion:^(BOOL finished) {
        
        [self.dataEntry removeFromSuperview];
        
        [self.background removeFromSuperview];
        
        [self removeFromSuperview];
        
    }];
    
}


@end
