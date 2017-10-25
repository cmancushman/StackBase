<p align="center">
<img src = 'https://user-images.githubusercontent.com/11083444/31786774-ca28d358-b533-11e7-8d3a-8b9ecee55064.png'/>
</p>

[![Version](https://img.shields.io/cocoapods/v/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)
[![License](https://img.shields.io/cocoapods/l/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)
[![Platform](https://img.shields.io/cocoapods/p/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)

## STATUS: INCOMPLETE (Come Back in a Week)

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

## Installation

- StackBase is available through CocoaPods. To install it, simply add the following line to your Podfile:

```ruby
pod 'StackBase'
```

- If you do not wish to use CocoaPods, you can download the framework [directly](https://github.com/cmancushman/StackBaseFramework/blob/master/StackBase.zip). Simply unzip the file and add the derived .framework file to your project.

- To use the example project, clone the repo or download it as a zip file. No pods are necessary.

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

## Create A Table

After setting your API and secret keys, you are ready to create a table. In any .h file of your choosing import Stackbase.

```swift
@import Stackbase;
```

Now let's create a table. In the .m of wherever you have just imported StackBase run the following block:

```objective-c
__weak typeof(self) weakSelf = self;

[StackBaseClient createStackBaseTableWithName:@"TestTable" columns:@[] withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

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

## Add Columns to a Table

After you have executed the method ```createStackBaseTableWithName:``` for the first time and created TestTable, further calls of the method will connect to the existing TestTable found in your database rather than overwriting it with a new one. While this means that you can run this method whenever you wish to connect to your tables, there is a quicker connection method for tables you already know exist on your database:

```objective-c
[StackBaseClient connectToStackBaseTableWithName:@"TestTable" withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

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

[StackBaseClient connectToStackBaseTableWithName:@"TestTable" withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

    if(success){

        weakSelf.table = table;

        StackBaseColumn *nameColumn = [StackBaseColumn textColumnWithName:@"Name"];

        [weakSelf.table addColumns:@[nameColumn] completionBlock:^(BOOL success, NSString *responseMessage) {

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

- We are now using 'weakSelf' via assigning its ```weakSelf.table``` property to the instance of table returned by the completion block. What this does is allow successive completion blocks to call ```weakSelf.table``` without risking a retain cycle or causing the ```.table``` object to be null. 

- StackBaseColumn can only be properly instantiated using one of three constructors: 

```objective-c
+(instancetype)textColumnWithName:(NSString *)name;
+(instancetype)numericColumnWithName:(NSString *)name shouldBeUnsigned:(BOOL)isUnsigned;
+(instancetype)dateTimeColumnWithName:(NSString *)name type:(StackBaseDateTimeType *)type;
```

Since we called ```textColumnWithName:``` the column we created will store values as strings. ```numericColumnWithName:``` stores numeric data, and ```dateTimeColumnWithName: type:``` will accept date-time data formatted by the given ```StackBaseDateTimeType``` value passed. 

After running this once, you should see the following result:

<img src = 'https://user-images.githubusercontent.com/11083444/31865143-de2a190e-b793-11e7-864a-44c79dbf4870.png'>

Now our table looks like this:

| id | Name |
| ------- | ------- |
|   |   |

Let's add another column, this time a date-time type.

## Requirements

- Xcode Version 8.0.0 or better

## Author

Chris, christopher.cushman@richmond.edu

## License

StackBase is available under the MIT license. See the LICENSE file for more info.
