//
//  StackBaseCompletionBlocks.h
//  Park It
//
//  Created by Chris Cushman on 9/18/17.
//  Copyright © 2017 Ubord, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface StackBaseCompletionBlocks : NSObject


/*!
 * @brief Completion block used for running queries on the table
 */
typedef void(^StackBaseQueryCompletion)(BOOL success, NSString *responseMessage, NSArray<NSDictionary *> *responseTable);


/*!
 * @brief Completion block used for altering the table
 */
typedef void(^StackBaseEditCompletion)(BOOL success, NSString *responseMessage);


@end
