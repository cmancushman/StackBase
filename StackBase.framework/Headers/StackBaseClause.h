//
//  StackBaseClause.h
//  Park It
//
//  Created by Chris Cushman on 10/10/17.
//  Copyright © 2017 Ubord, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface StackBaseClause : NSObject


/*!
 * @brief The formatted condition string for a StackBaseCondition instance
 */
-(NSString *)getConditionString;


/*!
 * @brief The array of values to be passed for a StackBaseCondition instance
 */
-(NSArray<NSString *> *)getValues;


/*!
 * @brief The array of columns being checked for a condition
 */
-(NSArray<NSString *> *)getColumns;


@end
