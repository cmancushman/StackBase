//
//  AWSTable.h
//  Park It
//
//  Created by Chris Cushman on 8/20/17.
//  Copyright © 2017 Ubord, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackBaseColumn.h"
#import "StackBaseCondition.h"
#import "StackBaseCompletionBlocks.h"




@interface StackBaseTable : NSObject


/*!
 * @brief Create a table with specified name
 * @discussion Although this is the preferred init method of a MySQLTable, the user should use use StackBase methods such as 'createMySQLTableWithName: columns: andPrimaryKey:' or 'connectToMySQLTableWithName:' and use the returned MySQLTable instance. This method will return an instance of MySQLTable, but its columns will not be populated until it is connected to a database.
 * @param name the name of the table you wish to create
 */
-(instancetype)initWithName:(NSString *)name andUrl: (NSString *)clientURL;

/*!
 * @brief Connects your table to a pre-existing MySQL table in your backend and populates its columns and settings using that table's information
 */
-(void)connectToServerWithCompletionBlock:(StackBaseQueryCompletion)compBlock;


/*!
 * @brief Returns the name of a StackBaseTable instance
 * @return the name of your table
 */
-(NSString *)getTableName;

/*!
 * @brief Returns the URL of the database in which this table is stored
 * @return the URL of your app/server
 */
-(NSString *)getClientURL;

/*!
 * @brief Returns the names of the columns designated as primary keys of your table
 * @return names of primary key columns
 */
-(NSArray<NSString *> *)getPrimaryKeyNames;


/*!
 * @brief Returns all of your table's columns
 * @return an array of all your columns
 */
-(NSArray<StackBaseColumn *> *)allColumns;

/*!
 * @brief Returns all of your table's columns' names
 * @return an array of all your columns' names
 */
-(NSArray<NSString *> *)allColumnNames;

/*!
 * @brief Returns all of your table's columns that are of the type MySQLPartitionTypeDATE
 * @return an array of your date-type columns
 */
-(NSArray<StackBaseColumn *> *)dateTypeColumns;

/*!
 * @brief Returns all of your table's columns' names that are of the type MySQLPartitionTypeDATE
 * @return an array of your date-type columns' names
 */
-(NSArray<NSString *> *)dateTypeColumnNames;

/*!
 * @brief Returns all of your table's columns that are of the type MySQLPartitionTypeTEXT
 * @return an array of your text-type columns
 */
-(NSArray<StackBaseColumn *> *)textTypeColumns;

/*!
 * @brief Returns all of your table's columns' names that are of the type MySQLPartitionTypeTEXT
 * @return an array of your text-type columns' names
 */
-(NSArray<NSString *> *)textTypeColumnNames;

/*!
 * @brief Returns all of your table's columns that are of the type MySQLPartitionTypeNUMERIC
 * @return an array of your numeric-type columns
 */
-(NSArray<StackBaseColumn *> *)numericTypeColumns;

/*!
 * @brief Returns all of your table's columns' names that are of the type MySQLPartitionTypeNUMERIC
 * @return an array of your numeric-type columns' names
 */
-(NSArray<NSString *> *)numericTypeColumnNames;

/*!
 * @brief Returns this table's column with the given name
 * @param name the name of the column
 */
-(BOOL)columnExistsWithName:(NSString *)name;


/*!
 * @brief Clears all search optimizations applied to columns in this table. Use this method if only if you are seeing recommendations to do so in your logs. 
 */
-(void)clearIndexesWithCompletionBlock: (StackBaseEditCompletion)compBlock;


/*!
 * @brief Adds more columns to this table
 * @param columns the columns to be added
 */
-(void)addColumns:(NSArray<StackBaseColumn *> *)columns completionBlock:(StackBaseEditCompletion) compBlock;

/*!
 * @brief Remove columns from this table
 * @param columns the columns to be removed
 */
-(void)removeColumns:(NSArray<StackBaseColumn *> *)columns completionBlock:(StackBaseEditCompletion) compBlock;

/*!
 * @brief Remove columns from this table
 * @param columnNames the names of the columns to be removed
 */
-(void)removeColumnsWithNames:(NSArray<NSString *> *)columnNames completionBlock:(StackBaseEditCompletion) compBlock;


/*!
 * @brief Insert a row into your table
 * @param rows the array of dictionaries that will be read as a new row for the table. For example, the dictionary @[{"firstname" : "john", "lastname" : "smith"}] passed into this method would add a row with the field "firstname" set to "john" and the field "lastname" set to smith. If the columns "firstname" or "lastname" do not exist, the insert will be unsuccessful.
 */
-(void)addRows:(NSArray<NSDictionary *> *)rows completionBlock:(StackBaseEditCompletion) compBlock;

/*!
 * @brief Update the rows in your table that match a certain condition with new values
 * @param fieldsAndValues the dictionary that will assign new values to the rows satisfying this method's StackBaseCondition parameter. For example, the dictionary {"firstname" : "john", "lastname" : "smith"} passed into this method would set the field "firstname" to "john" and the field "lastname" to smith for all the rows that satisifed the condition. If the columns "firstname" or "lastname" do not exist, the update will be unsuccessful.
 * @param condition a condition that must be met in order for a row to be updated
 */
-(void)updateRowsThatSatisfyTheCondition:(StackBaseCondition *)condition withFieldsAndValues:(NSDictionary *)fieldsAndValues completionBlock:(StackBaseEditCompletion) compBlock;

/*!
 * @brief Removes the records in your table that match the given condition parameter
 * @param condition a paremeter that must be met in order for a row to be removed
 */
-(void)deleteRowsThatSatisfyTheCondition:(StackBaseCondition *)condition withCompletionBlock:(StackBaseEditCompletion) compBlock;

/*!
 * @brief Removes all records from your table
 */
-(void)deleteAllRowsWithCompletionBlock:(StackBaseEditCompletion) compBlock;


/*!
 * @brief Fetches the first n rows in this table
 * @param numberOfRows the number of rows to be returned
 */
-(void)getFirst:(NSInteger )numberOfRows rowsWithCompletionBlock:(StackBaseQueryCompletion) compBlock;

/*!
 * @brief Fetches the first n rows that satisfy a condition
 * @param numberOfRows the number of rows to be returned
 * @param condition a condition that must be met in order for a row to be returned
 */
-(void)getFirst:(NSInteger )numberOfRows rowsWhere:(StackBaseCondition *)condition completionBlock:(StackBaseQueryCompletion) compBlock;

/*!
 * @brief Fetches the first n rows starting at row x for columns with specified names
 * @param numberOfRows the number of rows to be returned
 * @param startingRow the index of the first row to be returned. If startingRow is set to 5 and numberofResults is set to 3, then rows 6, 7, and 8 will be returned.
 */
-(void)getFirst:(NSInteger )numberOfRows rowsStartingAtRow:(NSInteger)startingRow completionBlock:(StackBaseQueryCompletion) compBlock;

/*!
 * @brief Fetches the first n rows starting at row x for columns with specified names
 * @param numberOfRows the number of rows to be returned
 * @param startingRow the index of the first row to be returned. If startingRow is set to 5 and numberofResults is set to 3, then rows 6, 7, and 8 will be returned.
 * @param condition a condition that must be met in order for a row to be returned
 */
-(void)getFirst:(NSInteger )numberOfRows rowsWhere:(StackBaseCondition *)condition startingAtRow:(NSInteger)startingRow completionBlock:(StackBaseQueryCompletion) compBlock;


@end
