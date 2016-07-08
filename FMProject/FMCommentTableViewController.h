//
//  FMCommentTableViewController.h
//  FMProject
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTFMViewControllerDelegate;
@interface FMCommentTableViewController : UITableViewController
@property (nonatomic,assign)id<HTFMViewControllerDelegate> commentDelegate;
@property (nonatomic,assign)BOOL isShow;//vc是否展现
@end
