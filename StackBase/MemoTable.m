//
//  MemoTable.m
//  StackBase
//
//  Created by Chris Cushman on 10/30/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "MemoTable.h"



#define UIColorFromRGB(rgbValue) \
[UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >>  8))/255.0 \
blue:((float)((rgbValue & 0x0000FF) >>  0))/255.0 \
alpha:1.0]

@implementation MemoTable


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    self.transform = CGAffineTransformMakeTranslation(0, frame.size.height);
    
    self.estimatedRowHeight = 100;
        
    [self setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    self.tableFooterView = [[UIView alloc] init];
    
    self.separatorColor = UIColorFromRGB(0xdddddd);
        
    return self;
    
}


-(void)unhide{
    
    [UIView animateWithDuration:1.0 animations:^{
       
        self.transform = CGAffineTransformIdentity;
        
    }];
    
}


@end
