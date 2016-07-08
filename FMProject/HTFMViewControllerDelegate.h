//
//  HTFMViewControllerDelegate.h
//  FMProject
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#ifndef HTFMViewControllerDelegate_h
#define HTFMViewControllerDelegate_h


#endif /* HTFMViewControllerDelegate_h */

typedef NS_ENUM(NSInteger, UIPageFlag) {
    UIPageFlagComment = 0,
    UIPageFlagConference,
    UIPageFlagCharacter
};

typedef NS_ENUM(NSInteger, UIScrollDirection) {
    UIScrollDirectionUp = 1,
    UIScrollDirectionDown
};

@protocol HTFMViewControllerDelegate <NSObject>

- (void)didBeiginScroll:(UIScrollView *)scroll direction:(UIScrollDirection)direction;
- (void)didAppearViewFromPage:(UIPageFlag)pageFlag;

@end