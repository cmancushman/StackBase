//
//  AWSTableColumn.h
//  
//
//  Created by Chris Cushman on 8/18/17.
//
//

#import <Foundation/Foundation.h>
#import "StackBaseColumnTypes.h"




@interface StackBaseColumn : NSObject


/*!
 * @brief Instantiates a numeric column with a data type (StackBaseNumericTypeINT, StackBaseNumericTypeDOUBLE, etc..) and name (firstname, email, age, etc..)
 * @param name The name of the column (firstname, email, age)
 * @param isUnsigned determines whether or not this column is signed or unsigned (for numeric values only)
 */
+(instancetype)numericColumnWithName:(NSString *)name shouldBeUnsigned:(BOOL)isUnsigned;

/*!
 * @brief Instantiates a text column with a data type (StackBaseTextTypeVARCHAR, StackBaseTextTypeTEXT, etc..) and name (firstname, email, age, etc..)
 * @param name The name of the column (firstname, email, age)
 */
+(instancetype)textColumnWithName:(NSString *)name;

/*!
 * @brief Instantiates a date-time column with a data type (StackBaseDateTimeTypeTIME, StackBaseDateTimeTypeDATE, etc..) and name (firstname, email, age, etc..)
 * @param type The type of data this column contains. Use the constants provided in this package (example: AWSDataTypeYEAR)
 * @param name The name of the column (firstname, email, age)
 */
+(instancetype)dateTimeColumnWithName:(NSString *)name type:(StackBaseDateTimeType *)type;


/*!
 * @brief The name of the column
 * @return the name of the column
 */
-(NSString *) getColumnName;

/*!
 * @brief The datatype of the column (int, varchar, timestamp, etc..)
 * @return the datatype of the column
 */
-(NSString *const) getDataType;

/*!
 * @brief Determines whether or not this column is signed or unsigned (for numeric values only)
 * @return YES if the column is unsigned or else NO
 */
-(BOOL) isUnsigned;


@end
