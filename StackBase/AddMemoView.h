//
//  AddMemoView.h
//  StackBase
//
//  Created by Chris Cushman on 11/2/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "DataEntry.h"




@interface AddMemoView : UIView


@property id<DataEntryDelegate>dataDelegate;


-(void)remove;


@end
