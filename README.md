<p align="center">
<img src = 'https://user-images.githubusercontent.com/11083444/31786774-ca28d358-b533-11e7-8d3a-8b9ecee55064.png'/>
</p>

[![Version](https://img.shields.io/cocoapods/v/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)
[![License](https://img.shields.io/cocoapods/l/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)
[![Platform](https://img.shields.io/cocoapods/p/StackBase.svg?style=flat)](http://cocoapods.org/pods/StackBase)

## STATUS: INCOMPLETE (Come Back in a Week)

## An Objective-C Backend Solution 

Welcome to Stackbase, a MySQL-based backend framework currently built for Objective-C developers. By providing an easy-to-implement framework, Stackbase offers a solution for coders who are not confident in building their own databases or do not wish to spend excessive time away from frontend. As will be demonstrated, Stackbase allows users to set up, maintain and use their own MySQL tables by only using Objective-C methods.

## Benefits

To be brief, Stackbase brings developers the following benefits:

- Simple methods that create, edit, delete, query from, upload to, and update intended MySQL tables

- Complex queries implemented in an easily digested manner

- Indexing done for the user. Columns are optimized for 'WHERE' conditions, including fulltext searches and UNION/or

- Currently free and easy to set up. As this is framework in early development, it is free to use, making backend 100% money and hassle free.

## Limitations

Conversely, since StackBase is in early development it is also not scaled. Enjoy it as a free service, but do not use it commercially (yet).

## Installation

- StackBase is available through CocoaPods. To install it, simply add the following line to your Podfile:

```ruby
pod 'StackBase'
```

- If you do not wish to use CocoaPods, you can download the framework [directly](https://github.com/cmancushman/StackBaseFramework/blob/master/StackBase.zip). Simply unzip the file and add the derived .framework file to your project.

- To use the example project, simply clone the repo or download it as a zip file. No pods are necessary.

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

- If you try to create a database and receive an access denied error, somebody with a differnet secret key may already be using your API key. However, given the embryonic state of this project two users picking the same API keys is highly unlikely. In the future, API keys will be generated to avoid this possibility. 

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
You may have noticed this unnecessary line of code:  ```objective-c __weak typeof(self) weakSelf = self; ``` The purpose of making this 'weakSelf' object is to avoid retain loops, which are a risk as this framework uses completion blocks returning data from asynchronous web requests. You will see how 'weakSelf' is used when we add a column.

After creating your first table, you no longer need to call the 'createStackBaseTableWithName:' method. The above method creates a table if one does not exist, and otherwise connects to a table that already exists. What this means is that after you run this method for the first time and create TestTable, the method will continue to work but it will not recreate TestTable each time; you will not lose your data by running this method on a pre-existing table. However, you must run a connection method every time you declare a table instance. Simply assigning a StackBaseTable instance as such: ```objective-c StackBaseTable *table = [[StackBaseTable alloc] init]; ``` will produce an empty table that cannot execute any methods. Fortunately, a quicker connection method than 'createStackBaseTable' exists:

```objective-c
[StackBaseClient connectToStackBaseTableWithName:@"TestTable" withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {

    if(success){

        NSLog(@"TestTable: %@", table);

    }else{

        NSLog(@"Operation Unsuccessful: %@", responseMessage);

}

}];
```

If you have properly followed the installation steps, after running the project you will see the following output in your logs:

<img src = 'https://user-images.githubusercontent.com/11083444/31864516-82a8f4ac-b788-11e7-8819-c6f6aae02a1d.png'>

This output is the description of your current table. The following descriptors were returned: 

- Table Name: The name of your table. Our table is named 'TestTable.'

- Number of Columns: The number of columns your table has. TestTable has 1 column.

- Column 1: Each column is iterated through and described whenever the table is logged. TestTable's only column, 'id,' is a signed numeric column (it accepts positive and negative numbers as values), and is also the primary key.

So what do we make of this?

## A Conceptual Break

If you are familiar with MySQL and SQL tables, then don't worry about reading this. The following is a brief explanation of how the table we just created works:

While a SQL table's implementation is quite complicated (binary trees and fulltext indexes aren't fun), the idea of a MySQL table is pretty easy to understand. All data is arranged in rows and columns, just like any other table. We can imagine, then, that TestTable looks something like this:

     id       | 
------------- | ---
              | 
              |
              | 
              | 
              | 

As you can see, the table only has one column, and zero rows. Doesn't really look like a table, does it? Let's fix that. Run the following command to give this table a new column:



## Requirements

- Xcode Version 8.0.0 or better

## Author

Chris, christopher.cushman@richmond.edu

## License

StackBase is available under the MIT license. See the LICENSE file for more info.
