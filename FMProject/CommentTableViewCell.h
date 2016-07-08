//
//  CommentTableViewCell.h
//  FMProject
//
//  Created by mac on 16/6/20.
//  Copyright © 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *avatarImg;
@property (weak, nonatomic) IBOutlet UIButton *nameBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIButton *praiseBtn;
@property (weak, nonatomic) IBOutlet UIView *quoteView;
@property (weak, nonatomic) IBOutlet UILabel *cotentLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *nameBtnWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *praiseBtnWidthConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *quoteViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *foldBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentLabelBottomConstraint;


@end
