//
//  AddMemoController.h
//  StackBase
//
//  Created by Chris Cushman on 11/2/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AddMemoView.h"




@protocol AddMemoControllerDelegate <NSObject>


-(void)addMemo:(NSString *)memo;


@end


@interface AddMemoController : NSObject <DataEntryDelegate>


@property id<AddMemoControllerDelegate>delegate;


-(void)addToView:(UIView *)view;


@end
