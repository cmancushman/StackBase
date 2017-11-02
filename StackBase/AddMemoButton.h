//
//  AddMemoButton.h
//  StackBase
//
//  Created by Chris Cushman on 11/2/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <UIKit/UIKit.h>



@protocol AddMemoDelegate <NSObject>


-(void)displayAddMemoView;


@end

@interface AddMemoButton : UIButton


@property UIView *targetView;

@property id<AddMemoDelegate>delegate;


-(instancetype)initWithFrame:(CGRect)frame andTargetView:(UIView *)targetView;

-(void)hide;

-(void)unhide;


@end
