//
//  Memos.h
//  StackBase
//
//  Created by Chris Cushman on 11/1/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MemoTable.h"
#import "MemoTableDataSource.h"




@protocol MemoDelegate <NSObject>


-(void)memosDidLoad;


@end




@interface Memos : UIView


@property id<MemoDelegate>delegate;

@property MemoTable *memoTable;

@property MemoTableDataSource *memoTableDataSource;


-(void)loadTable;

-(void)addMemo:(NSString *)memo;


@end
