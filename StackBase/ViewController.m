//
//  ViewController.m
//  StackBase
//
//  Created by Chris Cushman on 10/21/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "ViewController.h"
#import "ViewConstants.h"



@interface ViewController ()

@end




@implementation ViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self addTopBar];
    
    [self addMemos];
    
    
}


-(void)addTopBar{
    
    self.topBar = [[TopBar alloc] initWithFrame:CGRectMake(0, STATUS_BAR_HEIGHT, self.view.frame.size.width, TOP_BAR_HEIGHT)];
    
    self.topBar.delegate = self;
    
    [self.view addSubview:self.topBar];
    
}

-(void)addMemos{
    
    int offset = STATUS_BAR_HEIGHT + TOP_BAR_HEIGHT;
    
    self.memos = [[Memos alloc] initWithFrame:CGRectMake(0, offset, self.view.frame.size.width, self.view.frame.size.height - offset)];
    
    self.memos.delegate = self;
    
    [self.view addSubview:self.memos];
    
    [self.memos loadTable];
    
    
}


-(void)memosDidLoad{
    
    [self.topBar showButton];
    
}

-(void)addMemo:(NSString *)memo{
    
    [self.topBar hideButton];
    
    [self.memos addMemo:memo];
    
}


-(void)displayAddMemoView{
    
    AddMemoController *addMemo = [[AddMemoController alloc] init];
    
    addMemo.delegate = self;
    
    [addMemo addToView: self.view];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
