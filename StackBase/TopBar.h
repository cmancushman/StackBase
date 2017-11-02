//
//  TopBar.h
//  StackBase
//
//  Created by Chris Cushman on 11/1/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddMemoButton.h"




@interface TopBar : UIView


@property id<AddMemoDelegate>delegate;


-(void)hideButton;

-(void)showButton;


@end
