//
//  StackBaseCondition.h
//  Park It
//
//  Created by Chris Cushman on 10/2/17.
//  Copyright © 2017 Ubord, Inc. All rights reserved.
//

#import "StackBaseClause.h"




@interface StackBaseCondition : StackBaseClause


/*!
 * @brief Condition that tests whether any of the conditions are met (an OR condition)
 * @parameter conditions an array of the conditions being tested
 * @return the union of all conditions passed in the array
 */
+(instancetype) oneOfTheseconditionsAreMet:(NSArray<StackBaseCondition *> *)conditions;


/*!
 * @brief Condition that tests whether both conditions are met
 * @parameter condition1 the first condition
 * @parameter condition2 the second condition
 * @return the intersection of these two conditions
 */
//+(instancetype) conditionIsMet:(StackBaseCondition *)condition1 andConditionIsMet:(StackBaseCondition *)condition2;



/*!
 * @brief Condition that tests whether multiple conditions are met
 * @parameter conditions an array of the conditions that will all be tested
 * @return an instance of StackbaseCondition that tests all of the conditions given simultaneously
 */
+(instancetype) conditionsAreMet:(NSArray<StackBaseCondition *> *)conditions;


/*!
 * @brief Condition that tests whether both conditions are met
 * @parameter condition1 the first condition
 * @parameter columnNames the columns to order the resulting rows by
 * @return a condition with resulting rows ordered by given columns
 */
+(instancetype) condition:(StackBaseCondition *)condition1 isOrderedBy:(NSArray<NSString *> *)columnNames;


/*!
 * @brief The column is equal to the given value
 * @parameter columnName the name of the column to be passed
 * @parameter value the value that this column is being matched against
 * @return the condition that this column is equal to the given value
 */
+(instancetype) columnWithName:(NSString *)columnName isEqualTo:(id)value;


/*!
 * @brief The column is not equal to the given value
 * @parameter columnName the name of the column to be passed
 * @parameter value the value that this column is being matched against
 * @return the condition that this column is not equal to the given value
 */
+(instancetype) columnWithName:(NSString *)columnName isNotEqualTo:(id)value;


/*!
 * @brief The column is greater than the given value
 * @parameter columnName the name of the column to be passed
 * @parameter value the value that this column is being matched against
 * @return the condition that this column is greater than the given value
 */
+(instancetype) columnWithName:(NSString *)columnName isGreaterThan:(NSNumber *)value;


/*!
 * @brief The column is less than the given value
 * @parameter columnName the name of the column to be passed
 * @parameter value the value that this column is being matched against
 * @return the condition that this column is less than the given value
 */
+(instancetype) columnWithName:(NSString *)columnName isLessThan:(NSNumber *)value;


/*!
 * @brief The column starts with the given value
 * @parameter columnName the name of the column to be passed
 * @parameter value the value that this column is being matched against
 * @return the condition that this column starts with the given value
 */
+(instancetype) columnWithName:(NSString *)columnName startsWith:(NSString *)value;


/*!
 * @brief The column is equal to any of the given values
 * @parameter columnName the name of the column to be passed
 * @parameter values the values that this column is being matched against
 * @return the condition that this column is equal to any of the given values
 */
+(instancetype) columnWithName:(NSString *)columnName matchesOneOfTheseValues:(NSArray *)values;


/*!
 * @brief The column is not equal to any of the given values
 * @parameter columnName the name of the column to be passed
 * @parameter values the values that this column is being matched against
 * @return the condition that this column is not equal to any of the given values
 */
+(instancetype) columnWithName:(NSString *)columnName doesNotMatchAnyOfTheseValues:(NSArray *)values;


+(instancetype) columnsWithNames:(NSArray<NSString *> *)columnNames matchPhrase:(NSString *)phrase;


+(instancetype) columnsWithNames:(NSArray<NSString *> *)columnNames matchPhrase:(NSString *)phrase butDoNotContainPhrases:(NSArray<NSString *> *)excludedPhrases;


/*!
 * @brief The names of columns this condition is ordered by
 */
-(NSArray<NSString *> *)getColumnsToOrderBy;


-(NSString *)getConditionType;


-(NSArray<StackBaseCondition *> *)getNestedConditions;


@end
