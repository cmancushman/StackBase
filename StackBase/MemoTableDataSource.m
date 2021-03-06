//
//  MemoTableDataSource.m
//  StackBase
//
//  Created by Chris Cushman on 10/30/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "MemoTableDataSource.h"
#import "FrameCalculator.h"
#import "ViewConstants.h"


@interface MemoTableDataSource()


@property BOOL endOfDataReached;

@property NSMutableArray<NSDictionary *> *records;

@property NSMutableArray<NSString *> *memos;

@property UIFont *cellFont;


@end




@implementation MemoTableDataSource


-(instancetype)initWithTable:(UITableView *)table{
    
    self.memos = [NSMutableArray new]; self.records = [NSMutableArray new];
    
    self.memoTable = table;
    
    self.cellFont = [UIFont fontWithName:(NSString *)FONT_FAMILY size:FONT_HEIGHT];
    
    table.dataSource = self;
    
    table.delegate = self;
    
    return self;
    
}


-(void)initDataWithCompletionBlock:(CompletionBlock)compBlock{
    
    self.endOfDataReached = NO;
    
    [self connectTableToDataSourceWithCompletionBlock:^(BOOL success) {
        
        if(success){
            
            [self populateFirstFiftyRowsWithCompletionBlock:^(BOOL success) {
                
                compBlock(success);
                
            }];
            
        }else{
            
            compBlock(NO);
            
        }
        
    }];
    
}

-(void)connectTableToDataSourceWithCompletionBlock:(CompletionBlock)completion{
    
    __weak typeof(self) weakSelf = self;
    
    [StackBaseClient createStackBaseTableWithName:@"MemoTable" columns:@[[StackBaseColumn textColumnWithName:@"Memo"]] completionBlock:^(BOOL success, NSString *responseMessage, StackBaseTable *table) {
        
        if(success){
                        
            weakSelf.table = table;
            
        }
        
        completion(success);
        
    }];
    
}

-(void)populateFirstFiftyRowsWithCompletionBlock:(CompletionBlock)completion{
    
    __weak typeof(self) weakSelf = self;
    
    StackBaseCondition *condition = [StackBaseCondition condition: [StackBaseCondition columnWithName:@"id" isGreaterThan:@-1] isOrderedBy: @[@"id"] descending: YES];
    
    [weakSelf.table getFirst:50 rowsWhere:condition completionBlock:^(BOOL success, NSString *responseMessage, NSArray<NSDictionary *> *responseTable) {
        
        if(success){
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self setData: responseTable];
                
                completion(YES);
                
            });
            
        }else{
            
            completion(NO);
            
        }
        
    }];
    
}


-(void)addMemo:(NSString *)memo completionBlock:(CompletionBlock)compBlock{
    
    __weak typeof(self) weakSelf = self;

    [weakSelf.table addRows:@[@{@"Memo" : memo}] completionBlock:^(BOOL success, NSString *responseMessage) {
        
        compBlock(success);
        
    }];
    
    
}

-(void)setData:(NSArray<NSDictionary *> *)newData{
    
    self.memos = [NSMutableArray new]; self.records = [NSMutableArray new];
    
    for(NSDictionary *dictionary in newData){
        
        [self.records addObject: dictionary];
        
        NSString *memo = [dictionary objectForKey:@"Memo"];
        
        [self.memos addObject: memo];
        
    }
    
}

-(void)addNewData:(NSArray<NSDictionary *> *)newData{
    
    if(self.records == nil) self.records = [NSMutableArray new];
    
    if(self.memos == nil) self.memos = [NSMutableArray new];
    
    for(NSDictionary *dictionary in newData){
        
        [self.records addObject: dictionary];
        
        NSString *memo = [dictionary objectForKey:@"Memo"];
        
        [self.memos addObject:memo];
        
    }
    
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.memos count];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return [FrameCalculator frameOfDesiredText: self.memos[indexPath.row]  withFont: self.cellFont  andWidth: tableView.frame.size.width].size.height + 20;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *cellIdentifier = [NSString stringWithFormat:@"S%1ldR%1ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil){
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        
    }
    
    NSString *memo = self.memos[indexPath.row];
    
    [cell.textLabel setFont: self.cellFont];
    
    cell.textLabel.lineBreakMode = NSLineBreakByWordWrapping;
    
    cell.textLabel.numberOfLines = 0;
    
    [cell.textLabel setFrame: [FrameCalculator frameOfDesiredText: memo  withFont: self.cellFont  andWidth: tableView.frame.size.width]];
    
    [cell.textLabel setText: memo];
    
    return cell;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
        
    CGFloat currentOffset = scrollView.contentOffset.y;
    
    CGFloat maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height;
    
    if (maximumOffset - currentOffset <= scrollView.frame.size.height/4 && !self.endOfDataReached && self.memos.count > 0) {
        
        self.endOfDataReached = YES;
        
        NSNumber *lowestId = [[self.records lastObject] objectForKey:@"id"];
        
        [self.table getFirst:50 rowsWhere: [StackBaseCondition condition: [StackBaseCondition columnWithName:@"id" isLessThan:lowestId] isOrderedBy:@[@"id"] descending:YES]  completionBlock:^(BOOL success, NSString *responseMessage, NSArray<NSDictionary *> *responseTable) {
            
            if(responseTable.count == 0){
                
            }else{
                
                [self addNewData:responseTable];
                
                [self.memoTable reloadData];
                
                self.endOfDataReached = NO;

            }
            
        }];
        
    }
    
}


@end
