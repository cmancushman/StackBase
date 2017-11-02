//
//  MemoDataEntry.m
//  StackBase
//
//  Created by Chris Cushman on 11/3/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import "DataEntry.h"




@interface DataEntry()


@property UILabel *placeHolderLabel;


@end




@implementation DataEntry


-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor whiteColor];
    
    [self becomeFirstResponder];
    
    self.returnKeyType = UIReturnKeyDone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
    
    return self;
    
}

-(void)layoutSubviews{
    
    self.layer.cornerRadius = self.frame.size.height/10;
    
}

- (void)drawRect:(CGRect)rect
{
    
        
        if (self.placeHolderLabel == nil ){
            
            self.placeHolderLabel = [[UILabel alloc] initWithFrame:CGRectMake(5,8,self.bounds.size.width - 16,0)];
            
            self.placeHolderLabel.lineBreakMode = NSLineBreakByWordWrapping;
            
            self.placeHolderLabel.numberOfLines = 0;
            
            self.placeHolderLabel.font = [UIFont systemFontOfSize:12];
            
            self.placeHolderLabel.backgroundColor = [UIColor clearColor];
            
            self.placeHolderLabel.textColor = [UIColor lightGrayColor];
            
            self.placeHolderLabel.alpha = 0;
            
            [self addSubview: self.placeHolderLabel];
            
        }
        
        self.placeHolderLabel.text = @"Leave a new memo...";
        
        [self. placeHolderLabel sizeToFit];
        
        [self sendSubviewToBack: self.placeHolderLabel];
    
    if([[self text] length] == 0) [self.placeHolderLabel setAlpha:1];
    
    [super drawRect:rect];
    
}


- (void)setText:(NSString *)text {
    
    NSLog(@"text is %@", text);
    
    [super setText:text];
    
    [self textChanged:nil];
    
}

- (void)textChanged:(NSNotification *)notification{
    
    if([self.text containsString:@"\n"]){
        
        [self resignFirstResponder];
        
        if(![self.text isEqualToString:@"\n"]){
                        
            [self.dataEntryDelegate textWasAccepted:[self.text stringByReplacingOccurrencesOfString:@"\n" withString:@""]];
            
        }else{
            
            [self.dataEntryDelegate dataEntryWasExited];
            
        }
        
        return;
        
    }
    
    [UIView animateWithDuration:0.25 animations:^{
        
        if([[self text] length] == 0){
            
            [self.placeHolderLabel setAlpha:1];
            
        }else{
            
            [self.placeHolderLabel setAlpha:0];
            
        }
        
    }];
    
}


@end
