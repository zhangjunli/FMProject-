//
//  HTFMViewController.h
//  FMProject
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomFMButton : UIButton

@end

@interface HTFMViewController : UIViewController
@property (assign,nonatomic) BOOL isMoringPage;//yes:早报vc。no:内参vc

@property (weak, nonatomic) IBOutlet UIView *fmView;
@property (weak, nonatomic) IBOutlet UIView *tabView;
@property (weak, nonatomic) IBOutlet UILabel *redLine;
@property (weak, nonatomic) IBOutlet UIButton *commentBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *redLineLeftConstraint;

@property (retain, nonatomic) IBOutlet NSLayoutConstraint *fmViewTopConstraint;


- (IBAction)backClick:(UIButton *)sender;
- (IBAction)commentTabClick:(UIButton *)sender;
- (IBAction)otherTabClick:(UIButton *)sender;

@end
