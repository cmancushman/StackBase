//
//  StackBaseColumnTypes.h
//  Park It
//
//  Created by Chris Cushman on 9/19/17.
//  Copyright © 2017 Ubord, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "StackBaseDateTimeType.h"




extern StackBaseDateTimeType *const StackBaseDateTimeTypeYEAR;//YYYY
extern StackBaseDateTimeType *const StackBaseDateTimeTypeDATE;//YYYY-MM-DD
extern StackBaseDateTimeType *const StackBaseDateTimeTypeTIME;//HH:MM:SS
extern StackBaseDateTimeType *const StackBaseDateTimeTypeDATETIME;//YYYY-MM-DD HH:MM:SS
extern StackBaseDateTimeType *const StackBaseDateTimeTypeTIMESTAMP;//YYYY-MM-DD HH:MM:SS




@interface StackBaseColumnTypes : NSString


@end
