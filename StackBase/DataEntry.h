//
//  MemoDataEntry.h
//  StackBase
//
//  Created by Chris Cushman on 11/3/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <UIKit/UIKit.h>




@protocol DataEntryDelegate


-(void)textWasAccepted:(NSString *)text;

-(void)dataEntryWasExited;


@end




@interface DataEntry : UITextView


@property id<DataEntryDelegate>dataEntryDelegate;


@end
