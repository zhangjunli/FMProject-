//
//  FMCharacterViewController.h
//  FMProject
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HTFMViewControllerDelegate;

@interface FMCharacterViewController : UIViewController
@property (nonatomic,assign)id<HTFMViewControllerDelegate> characterDelegate;
@end
