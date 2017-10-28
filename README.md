<p align="center">
<img src = 'https://user-images.githubusercontent.com/11083444/31786774-ca28d358-b533-11e7-8d3a-8b9ecee55064.png'/>
</p>

[![Version](https://img.shields.io/cocoapods/v/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)
[![License](https://img.shields.io/cocoapods/l/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)
[![Platform](https://img.shields.io/cocoapods/p/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)


## An Objective-C Backend Solution 

Welcome to Stackbase, a MySQL-based backend framework currently built for Objective-C developers. By providing an easy-to-implement framework, Stackbase offers a solution for coders who are not confident in building their own databases or do not wish to spend excessive time away from frontend. As will be demonstrated, Stackbase allows users to set up, maintain and use their own MySQL tables by only using Objective-C methods.

## Benefits of Using StackBase

To be brief, Stackbase brings developers the following benefits:

- Simple methods that create, edit, delete, query from, upload to, and update intended MySQL tables

- Complex queries implemented in an easily digested manner

- Columns automatically resized to accomodate large input (numeric data capped at 12 integer-part digits and 9 decimal-part digits currently)

- Logic handled for the user: columns are optimized for 'WHERE' conditions, including fulltext searches and UNION/or, and indexes are automatically created to speed up applicable searches (explained later)

- A free backend playground: StackBase is in early development and currently free, making backend 100% free

## Limitations of Using StackBase

Conversely, since StackBase is in early development it is not currently scalable. Enjoy it as a free service, but do not use it commercially (yet). This is obviously a ***big*** limitation, and it is the immediate objective of StackBase to fix this and establish a billed tier.

## Requirements

- Xcode Version 8.0.0 or better

## Installation

- StackBase is available through CocoaPods. To install it, simply add the following line to your Podfile:
```ruby
pod 'StackBase'
```
- If you do not wish to use CocoaPods, you can download the framework [directly](https://github.com/cmancushman/StackBaseFramework/blob/master/StackBase.zip). Unzip the file and add the derived .framework file to your project.

- To use the example project, clone the repo or download it as a zip file. CocoaPods is not necessary.

## API Keys

Once you have properly installed StackBase, open up your main info.plist file. Add values for the following keys: Stackbase_API_KEY and StackBase_SECRET_KEY

<img src = 'https://user-images.githubusercontent.com/11083444/31787110-d64fec92-b534-11e7-8af2-e853bab0b0cc.png'/>

You can add the values to the property list manually, or paste source code below:
```
<key>StackBase_API_KEY</key>
<string>example_api_key</string>
<key>StackBase_SECRET_KEY</key>
<string>example_api_password_this_is_super_secret</string>
```
These keys will allow you to generate your own database. 

- If you do not specify keys, your client will use the public database, in which anybody can add, edit, and remove tables. 

- If you try to create a database and receive an access denied error, somebody with a different secret key may already be using your API key. However, given the embryonic state of this project two users picking the same API keys is highly unlikely. In the future, API keys will be generated to avoid this possibility. 

- You can create as many tables as you like in a database, as long as they have unique names.

## Creating A Table

After setting your API and secret keys, you are ready to create a table. In any .h file of your choosing import Stackbase.
```swift
@import Stackbase;
```
Now let's create a table. In the .m of wherever you have just imported StackBase run the following block:
```objective-c
__weak typeof(self) weakSelf = self;

[StackBaseClient createStackBaseTableWithName:@"TestTable" 
columns:@[] 
withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

    if(success){

        NSLog(@"TestTable: %@", table);

    }else{

        NSLog(@"Operation Unsuccessful: %@", responseMessage);

    }

}];
```
Before we proceed, take note of the objects returned by the completion block: ``` BOOL success, NSString *responseMessage, StackBaseTable *table``` StackBases uses different types of completion blocks, but they will always return at least one of five different objects:

- ``` BOOL success``` A boolean that indicates whether or not the method was successful. As a rule of thumb, always check this value before implementing any more logic.

- ``` NSString *responseMessage``` A string describing the outcome of the method. If the method is successful, responseMessage will return 'The operation was successful.' In the case of an error, ```responseMessage``` will provide a brief statement on whatever error occurred.

- ``` NSArray<NSDictionary *> *responseTable``` Returns rows that match a query. Each NSDictionary represents a row, and contains that row's key-object pairings. The NSArray is an array of these resulting rows. This object will be explained in more detail.

- ``` NSArray<NSString *> *tableNames``` This object is only found in the completion block of the method: ``` getNamesOfAllStackBaseTablesWithCompletionBlock:``` The array contains the names of all tables in the database corresponding to the value you have assigned to StackBase_API_KEY. 

- ```StackBaseTable *table``` The StackBaseTable instance returned when the client connects to the database. These instances of StackBaseTable are important, as you must run a connection method every time you declare a table instance. Simply assigning a StackBaseTable instance as such: ``` StackBaseTable *table = [[StackBaseTable alloc] init]; ``` will produce an empty table that cannot execute any methods. The StackBaseTable instances found in completion blocks are the only ones that are properly constructed and populated with data. 

Additionally, you may have noticed this unnecessary line of code:  ```__weak typeof(self) weakSelf = self; ``` The purpose of making this 'weakSelf' object is to avoid retain loops, which are a risk as this framework uses completion blocks returning data from asynchronous web requests. You will see how 'weakSelf' is used when we add a column to this table.

If you have properly followed the installation steps, after running the project you will see the following output in your logs:

<img src = 'https://user-images.githubusercontent.com/11083444/31864516-82a8f4ac-b788-11e7-8819-c6f6aae02a1d.png'>

This output is the description of your current table. The following descriptors were returned: 

- Table Name: The name of your table. Our table is named 'TestTable.'

- Number of Columns: The number of columns your table has. TestTable has 1 column.

- Column 1: Each column is iterated through and described whenever the table is logged. TestTable's only column, 'id,' is a signed numeric column (it accepts positive and negative numbers as values), and is also the primary key.

You'll notice that this table already contains a column: 'id,' which is created automatically for every table. It tracks post order of the table by storing an auto-incrementing integer starting at 1. The first row added to the table will have an 'id' of 1, the second 2, the third 3, etc..

## Envisioning our Table

While an SQL table's implementation is quite complicated (binary trees and fulltext indexes aren't fun), the idea of an SQL table is pretty easy to understand. All data is arranged in rows and columns, just like any other table. We can imagine, then, that TestTable looks something like this:

| id |  
| ------- |
|   | 

Doesn't really look like much of a table yet, does it? The table only has one column and zero rows.  Let's change that. 

## Adding Columns to a Table

After you have executed the method ```createStackBaseTableWithName:``` for the first time and created TestTable, further calls of the method will connect to the existing TestTable found in your database rather than overwriting it with a new one. While this means that you can run this method whenever you wish to connect to your tables, there is a quicker connection method for tables you already know exist on your database:
```objective-c
[StackBaseClient connectToStackBaseTableWithName:@"TestTable" 
withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

    if(success){

        NSLog(@"TestTable: %@", table);

    }else{

        NSLog(@"Operation Unsuccessful: %@", responseMessage);

    }

}];
```
We already have a numeric column (id), so we should give this table a text column. Before we can do that, we need to add a property to our code. Put the following to your .h file:
```objective-c
@property StackBaseTable *table;
```
Then, replace your connection/creation method with the following nested methods:
```objective-c
__weak typeof(self) weakSelf = self;

[StackBaseClient connectToStackBaseTableWithName:@"TestTable" 
withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

    if(success){

        weakSelf.table = table;

        StackBaseColumn *nameColumn = [StackBaseColumn textColumnWithName:@"Name"];

        [weakSelf.table addColumns:@[nameColumn] 
        completionBlock:^(BOOL success, NSString *responseMessage) {

            if(success){

                NSLog(@"Table: %@", weakSelf.table);

            }else{

                NSLog(@"Column Addition Unsuccessful: %@", responseMessage);
        
            }

        }];

    }else{

        NSLog(@"Connection Unsuccessful: %@", responseMessage);

    }

}];
```
Two points of interest from this snippet:

1. We are now using 'weakSelf' via assigning its ```weakSelf.table``` property to the instance of table returned by the completion block. What this does is allow successive completion blocks to call ```weakSelf.table``` without risking a retain cycle or causing the ```.table``` object to be null. 

2. StackBaseColumn can only be properly instantiated using one of three constructors: 
```objective-c
+(instancetype)textColumnWithName:(NSString *)name;
+(instancetype)numericColumnWithName:(NSString *)name shouldBeUnsigned:(BOOL)isUnsigned;
+(instancetype)dateTimeColumnWithName:(NSString *)name type:(StackBaseDateTimeType *)type;
```
Since we called ```textColumnWithName:``` the column we created will store values as strings. ```numericColumnWithName:``` stores numeric data, and ```dateTimeColumnWithName: type:``` will accept date-time data formatted by the given ```StackBaseDateTimeType``` value passed. 

After running this once, you should see the following result:

<img src = 'https://user-images.githubusercontent.com/11083444/31865143-de2a190e-b793-11e7-864a-44c79dbf4870.png'>

Let's add two more column, another text column called 'Memo' and a date-time column called 'Timestamp.'
```objective-c
__weak typeof(self) weakSelf = self;

[StackBaseClient connectToStackBaseTableWithName:@"TestTable" 
withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

    if(success){

        weakSelf.table = table;

        StackBaseColumn *memoColumn = [StackBaseColumn textColumnWithName:@"Memo"];

        StackBaseColumn *timeStampColumn = [StackBaseColumn dateTimeColumnWithName:@"Timestamp" type:StackBaseDateTimeTypeTIMESTAMP];

        [weakSelf.table addColumns:@[memoColumn, timeStampColumn] 
        completionBlock:^(BOOL success, NSString *responseMessage) {

            if(success){

                NSLog(@"Table: %@", weakSelf.table);

            }else{

                NSLog(@"Column Addition Unsuccessful: %@", responseMessage);

            }

        }];

    }else{

        NSLog(@"Connection Unsuccessful: %@", responseMessage);

    }

}];
```
<img src = 'https://user-images.githubusercontent.com/11083444/32007908-109017e8-b9d5-11e7-8e11-cc3895fdaff3.png'>

Now, we don't need to use all those methods just to create a table with four different columns. The following snippet is a single method that accomplishes the same result:
```objective-c
__weak typeof(self) weakSelf = self;

[StackBaseClient createStackBaseTableWithName:@"TestTable" 
columns:@[[StackBaseColumn textColumnWithName:@"Name"], [StackBaseColumn textColumnWithName:@"Memo"], [StackBaseColumn dateTimeColumnWithName:@"Timestamp" type:StackBaseDateTimeTypeTIMESTAMP]] 
withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

    if(success){

        weakSelf.table = table;

        NSLog(@"Table: %@", weakSelf.table);

    }else{

        NSLog(@"Operation Unsuccessful: %@", responseMessage);

    }

}];
```
Adding the columns has given our table breadth:

| id | Name | Memo | Timestamp |
| ------- | ------- | ------- | ------- |
|   |   |   |   |

Time to add depth.

## Adding Rows

Add the following inside of your connection method. 

```objective-c
[weakSelf.table addRows:@[@{@"Name" : @"Chris", @"Memo" : @"Checking in for the first time. Can you leave a memo Sean?"}, @{@"Name" : @"Sean"}, @{@"Name" : @"Chris", @"Memo" : @"You forgot to leave a memo, Sean."} ] completionBlock:^(BOOL success, NSString *responseMessage) {

    if(success){

        NSLog(@"Operation Successful");

        [weakSelf.table getFirst:3 rowsWithCompletionBlock:^(BOOL success, NSString *responseMessage, NSArray<NSDictionary *> *responseTable) {

            for(NSDictionary *row in responseTable){

                NSLog(@"row %ld: %@", ([responseTable indexOfObject:row] + 1), row);

            }

        }];

    }else{

        NSLog(@"Operation Unsuccessful: %@", responseMessage);

    }

}];
```
You should receive the following output:

<img src='https://user-images.githubusercontent.com/11083444/32016275-ae30a1ee-b9ed-11e7-861e-a89c49673cbb.png'>

There is a lot of new information in this snippet, so let us cover the important bits:

1. ```weakSelf.table addRows:``` adds rows to a StackBase table by passing an array of dictionaries. Each dictionary represents a row to be added. In this case, we added the following rows: 
```objective-c
@{@"Name" : @"Chris", @"Memo" : @"Checking in for the first time. Can you leave a memo Sean?"}
@{@"Name" : @"Sean"}
@{@"Name" : @"Chris", @"Memo" : @"You forgot to leave a memo, Sean."}
``` 
Each dictionary's keys and values represent the column names and the data to be assigned to them, respectively. In this case, we are only using the 'Name' and 'Memo' columns to create rows. This is because 'id' auto-increments, which means that the client does not decide its value. Sending data to this column consequently does nothing. Additionally, 'Timestamp' exhibits a similar behavior; it was declared as column type ```StackBaseDateTimeTypeTIMESTAMP``` and timestamps are automatically assigned to the precise time the row was posted, so they do not accept client-based data either. 

Note that for each row created, the columns being assigned do not have to be the same. In the second row, only the 'Name' column is fed data, while the other two given rows assign data to both 'Name' and 'Memo'

2. ```weakSelf.table getFirst:3 rowsWithCompletionBlock:``` retrieves the first three rows from your StackBase table. It is impractical to include all of a table's records when printing, as an SQL table can handle billions of rows. The StackBase 'getRow' methods exist to fetch rows that match certain conditions, in this case limiting return data to the first three rows (rows that have the smallest three 'id' values). More detailed conditions will be explained later, but their universal purpose is to obtain a smaller, organized portion of a table's data. Once filtered, our rows are returned as an array of dictionaries called 'responseTable,' following the same structure as rows being added. They can then be printed as so:
```objective-c
for(NSDictionary *row in responseTable){

    NSLog(@"row %ld: %@", ([responseTable indexOfObject:row] + 1), row);

}
```

## Altering Rows

Sean forgot to leave a memo, so let's fix the mistake.
```objective-c
[weakSelf.table updateRowsThatSatisfyTheCondition:[StackBaseCondition columnWithName:@"Name" isEqualTo:@"Sean"] 
withFieldsAndValues:@{@"Memo" : @"Hey Chris! This is my first memo. Am I doing this right?"} 
completionBlock:^(BOOL success, NSString *responseMessage) {

    if(success){

        [weakSelf.table getFirst:3 rowsWithCompletionBlock:^(BOOL success, NSString *responseMessage, NSArray<NSDictionary *> *responseTable) {

            for(NSDictionary *row in responseTable){

                NSLog(@"row %ld: %@", ([responseTable indexOfObject:row] + 1), row);

            }

        }];

    }else{

        NSLog(@"Update Unsuccessful: %@", responseMessage);

    }

}];
```
And as we can see below, Sean's memo has been added:

<img src='https://user-images.githubusercontent.com/11083444/32018884-894fd9be-b9f5-11e7-8581-ae492da269af.png'>

Once again, there is important information to cover. 

1. ```[StackBaseCondition columnWithName:@"Name" isEqualTo:@"Sean"]``` is an instance of StackBaseCondition. StackBaseCondition is a crucial class that creates a filter for rows to be retrieved, altered, or deleted. There are several variants of StackBaseCondition and these variants can be combined in unique ways. The use of StackBaseCondition allows for unions and intersections as well as fulltext searches. 

2. ```weakSelf.table updateRowsThatSatisfyTheCondition:``` changes the values of rows that match a passed StackBaseCondition. Rows are updated in the format of a single dicitonary; every row will be given those key-value bindings. In this case, we assigned all rows that matched our condition the following binding:
```objective-c
@{@"Memo" : @"Hey Chris! This is my first memo. Am I doing this right?"}
```
All rows that match the StackBaseCondition will have their 'Memo' field changed to 'Hey Chris! This is my first memo. Am I doing this right?' This intended result is manifested when we see row 2 change its memo field.

## Deleting Rows

Now that Sean has corrected his post, we can remove the third record in which Chris tells Sean that he forgot to leave a memo.
```objective-c
[weakSelf.table deleteRowsThatSatisfyTheCondition:[StackBaseCondition columnWithName:@"id" isEqualTo:@3] completionBlock:^(BOOL success, NSString *responseMessage) {

    if(success){

        [weakSelf.table getFirst:3 rowsWithCompletionBlock:^(BOOL success, NSString *responseMessage, NSArray<NSDictionary *> *responseTable) {

            for(NSDictionary *row in responseTable){

                NSLog(@"row %ld: %@", ([responseTable indexOfObject:row] + 1), row);

            }

        }];

    }else{

        NSLog(@"Update Unsuccessful: %@", responseMessage);

    }

}];
```
<img src = 'https://user-images.githubusercontent.com/11083444/32042379-7cc625e2-ba61-11e7-85bc-9862a5a96001.png'>

## Author

### Chris Cushman

**Education:** University of Richmond

**Email:** christopher.cushman@richmond.edu

## License

StackBase is available under the MIT license. See the [LICENSE file](https://github.com/cmancushman/StackBase/blob/master/LICENSE) for more info.
