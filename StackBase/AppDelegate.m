//
//  AppDelegate.m
//  StackBase
//
//  Created by Chris Cushman on 10/21/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    __weak typeof(self) weakSelf = self;
    
    [StackBaseClient removeStackBaseTableWithName:@"TestTable" fromMySQLServerWithCompletionBlock:^(BOOL success, NSString *responseMessage) {
        
        [StackBaseClient createStackBaseTableWithName:@"TestTable" columns:@[[StackBaseColumn textColumnWithName:@"Name"], [StackBaseColumn textColumnWithName:@"Memo"], [StackBaseColumn dateTimeColumnWithName:@"Timestamp" type:StackBaseDateTimeTypeTIMESTAMP]] withCompletionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {
            
            weakSelf.table = table;
            
            [weakSelf.table deleteAllRowsWithCompletionBlock:^(BOOL success, NSString *responseMessage) {
                
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
                
            }];
            
        }];
        
    }];
    
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}




@end

