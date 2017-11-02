//
//  ViewController.h
//  StackBase
//
//  Created by Chris Cushman on 10/21/17.
//  Copyright © 2017 Chris Cushman. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Memos.h"
#import "TopBar.h"
#import "AddMemoController.h"






@interface ViewController : UIViewController <MemoDelegate, AddMemoDelegate, AddMemoControllerDelegate>


@property Memos *memos;

@property TopBar *topBar;


@end

