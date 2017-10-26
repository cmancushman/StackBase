//
//  AWSBackendClient.h
//  Park It
//
//  Created by Chris Cushman on 8/17/17.
//  Copyright © 2017 Ubord, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StackBaseTable.h"




/*!
 * @brief Completion block used for creating and retrieving tables in the MySQL database
 */
typedef void(^StackBaseTableCompletion)(BOOL success, NSString *responseMessage, StackBaseTable *table);

/*!
 * @brief Completion block used for retrieving names of tables in the MySQL database
 */
typedef void(^StackBaseTableNameCompletion)(BOOL success, NSString *responseMessage, NSArray<NSString *> *tableNames);


@interface StackBaseClient : NSObject < NSURLSessionDelegate>



/*!
 * @brief Returns the URL StackBase is connected to
 * @return the URL of your app/server
 */
+(NSString *)clientURL;


/*!
 * @brief Creates a new table in your MySQL database with specified name, columns, and primary key
 * @discussion In MySQL, a table contains rows and columns. Columns define what a row must contain, and each column may have specific properties. For instance, the column 'id' might only accept INTS, while 'firstname' might only take VARCHARs (Strings). Every row is an instance of all  the columns. For example, a table with columns 'id', 'firstname', 'lastname', and 'email' may have many rows, and a row may look like: '3', 'John', 'Doe', 'john.doe@gmail.com'. This method is used to create one such table in the MySQL Database. If a table already exists with the name you are trying to use, the method will execute, but you will receive an error message, and the completion block will give you the table that already existed in the MySQL database, not the one you attempted to create. If you want to create a new table with the same name, first remove the table from the MySQL database using the method 'removeTableWithName:', and then create your table.
 * @param name the name of the table you wish to create
 * @param columns the columns you have specified for this table
 */
+(void)createStackBaseTableWithName:(NSString *)name columns:(NSArray<StackBaseColumn *> *)columns completionBlock:(StackBaseTableCompletion) compBlock;

/*!
 * @brief Connects to a table that already exists in your MySQL database 
 * @discussion The preferred method of connecting to your MySQL database within the StackBase framework. This method will retrieve all necessary info from the table in your MySQL database that you have requested and construct an instance of MySQLTable from this data. The instance is returned in the completion block.
 * @param name the name of the table you wish to create
 */
+(void)connectToStackBaseTableWithName:(NSString *)name completionBlock:(StackBaseTableCompletion) compBlock;

/*!
 * @brief Removes a table from
 * @discussion This method removes the requested table from your MySQL database. Any instances of MySQLTable that you have already constructed from the removed table will still exist, but they will be unusable until you reassign them to another table with 'connectToMySQLTableWithName:' or 'createMySQLTableWithName: columns: andPrimaryKey:'.
 * @param name the name of the table you wish to remove from your database
 */
+(void)removeStackBaseTableWithName:(NSString *)name completionBlock:(StackBaseEditCompletion) compBlock;


/*!
 * @brief Get names of all active tables
 
 */
+(void)getNamesOfAllStackBaseTablesWithCompletionBlock:(StackBaseTableNameCompletion) compBlock;


@end
