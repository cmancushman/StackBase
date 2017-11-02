//
//  Memos.m
//  StackBase
//
//  Created by Chris Cushman on 11/1/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "Memos.h"
#import "SetupSpinner.h"
#import "FrameCalculator.h"


@interface Memos()


@property SetupSpinner *spinner;


@end

@implementation Memos

-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    self.memoTable = [[MemoTable alloc] initWithFrame: self.bounds];
    
    [self addSubview: self.memoTable];

    self.memoTableDataSource = [[MemoTableDataSource alloc] initWithTable: self.memoTable];
    
    self.memoTable.dataSource = self.memoTableDataSource;

    [self.memoTable reloadData];
    
    return self;
    
}

-(void)loadTable{
    
    self.spinner = [[SetupSpinner alloc] initWithSuperView:self.superview];
    
    [self.superview addSubview: self.spinner];
    
    [self loadData];
    
}

-(void)loadData{
    
    [self.memoTableDataSource initDataWithCompletionBlock:^(BOOL success) {
        
        [self.spinner clear];
        
        NSIndexSet *sections = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, [self.memoTable numberOfSections])];
        
        [self.memoTable reloadSections:sections withRowAnimation:UITableViewRowAnimationFade];
        
        [self.delegate memosDidLoad];
        
        [self.memoTable unhide];
        
    }];
    
}


-(void)addMemo:(NSString *)memo{
    
    __weak typeof(self) weakSelf = self;

    [weakSelf.memoTableDataSource addMemo:memo completionBlock:^(BOOL success) {
        
        if(success){
            
            [weakSelf loadData];
            
        }else{
            
            [self.delegate memosDidLoad];
            
        }
        
        
    }];
    
}





@end
