//
//  MemoTableDataSource.h
//  StackBase
//
//  Created by Chris Cushman on 10/30/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@import StackBase;




@interface MemoTableDataSource : NSObject <UITableViewDataSource, UITableViewDelegate>

@property StackBaseTable *table;

typedef void(^CompletionBlock)(BOOL success);


-(instancetype)initWithTable:(UITableView *)table;


-(void)addMemo:(NSString *)memo completionBlock:(CompletionBlock)compBlock;

-(void)addNewData:(NSArray<NSDictionary *> *)newData;


-(void)initDataWithCompletionBlock:(CompletionBlock)compBlock;


@end
