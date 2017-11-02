//
//  TopBar.m
//  StackBase
//
//  Created by Chris Cushman on 11/1/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "TopBar.h"
#import "ViewConstants.h"




@interface TopBar()


@property AddMemoButton *addMemoButton;


@end




@implementation TopBar


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    [self addSeparator];
    
    [self addTitle];
    
    return self;
    
}

-(void)didMoveToSuperview{
    
    [self addButton];
    
}

-(void)addSeparator{
    
    int bottomBarHeight = TOP_BAR_SEPARATOR_HEIGHT;
    
    UIView *bottomBar = [[UIView alloc] initWithFrame:CGRectMake(15, self.frame.size.height - bottomBarHeight, self.frame.size.width - 15, bottomBarHeight)];
    
    bottomBar.backgroundColor = [UIColor blackColor];
    
    [self addSubview:bottomBar];
    
}

-(void)addTitle{
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width/2, self.frame.size.height - TOP_BAR_SEPARATOR_HEIGHT)];
    
    title.font = [UIFont fontWithName: [NSString stringWithFormat:@"%@-Bold", FONT_FAMILY] size:30];
    
    title.text = @"Memos";
    
    [self addSubview:title];
    
}


-(void)addButton{
        
    CGFloat buttonSize = 20;
    
    self.addMemoButton = [[AddMemoButton alloc] initWithFrame:CGRectMake(self.frame.size.width - 10 - buttonSize, (self.frame.size.height - TOP_BAR_SEPARATOR_HEIGHT)/2 - buttonSize/2, buttonSize, buttonSize) andTargetView: self.superview];
    
    [self.addMemoButton hide];
    
    self.addMemoButton.delegate = self.delegate;
    
    [self addSubview:self.addMemoButton];
    
}

-(void)showButton{
    
    [self.addMemoButton unhide];
    
}

-(void)hideButton{
    
    [self.addMemoButton hide];
    
}


@end
