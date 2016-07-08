//
//  HTFMViewController.m
//  FMProject
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "HTFMViewController.h"
#import "FMCommentTableViewController.h"
#import "FMConferenceTableViewController.h"
#import "FMCharacterViewController.h"
#import "HTFMViewControllerDelegate.h"
#import "UIFont+extension.h"

#define ORIGIN_OFFSET    171.0
#define ORIGIN_TOP_SPACE 139.0
#define FMVIEW_HEIGHT    240.0
#define TABVIEW_HEIGHT   35.0
#define NAV_HEIGHT       59.0
#define TOTAL_WIDTH      self.view.bounds.size.width
#define TOTAL_HEIGHT     self.view.bounds.size.height
#define REGULAR_FONT     @"PingFangSC-Regular"
#define LIGHT_FONT       @"PingFangSC-Light"

#define UIColorFromRGBWithAlpha(rgbValue,alphaValue) [UIColor colorWithRed:((float)((rgbValue &0xFF0000) >> 16))/255.0 green:((float)((rgbValue &0xFF00) >> 8))/255.0 blue:((float)(rgbValue &0xFF))/255.0 alpha:alphaValue]


@implementation CustomFMButton
//放大button 点击的热区
- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent*)event
{
    CGRect bounds = self.bounds;
    //若原热区小于44x44，则放大热区，否则保持原大小不变
    CGFloat widthDelta = MAX(44.0 - bounds.size.width, 0);
    CGFloat heightDelta = MAX(44.0 - bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthDelta, -0.5 * heightDelta);
    return CGRectContainsPoint(bounds, point);
}

@end

@interface HTFMViewController ()<UIPageViewControllerDataSource, UIPageViewControllerDelegate,HTFMViewControllerDelegate>
{
    UIPageViewController * pageVC;
    UIPageFlag currentIndex;
    CGFloat lastContentOffsetY;
    CGFloat lastFMViewTopConstraint;
}
@property (nonatomic,strong)NSMutableArray * vcArray;

@end

@implementation HTFMViewController

- (NSString *)unitConversion:(NSString *)dataStr newUnit:(NSInteger)newUnit{
    NSInteger oldData = [dataStr integerValue];
    NSInteger tempData = 0;
    for (int i = 0; i < 2; i ++) {//10进制,去除后两位
        tempData = oldData%10;//执行一次，tempData为个位，执行第二次，tempData为十位
        oldData = oldData/10;
        newUnit /=10;
    }
    if (tempData >= 5) {////此时tempData 为十位，四舍五入
        oldData = oldData + 1;
    }
    return [NSString stringWithFormat:@"%.2f",oldData/100.0];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[self unitConversion:@"123456" newUnit:10000]);
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    self.fmView.backgroundColor = [UIColor orangeColor];
    [self setTabViewUI];
    [self setPageViewUI];
}

- (void)setTabViewUI{
    self.tabView.layer.borderColor = UIColorFromRGBWithAlpha(0xa8a8a8,1.0).CGColor;
    self.tabView.layer.borderWidth = 0.5;
    
    [self.commentBtn setTitleColor:UIColorFromRGBWithAlpha(0xbf2c2a,1.0) forState:UIControlStateDisabled];
    [self.commentBtn setTitleColor:UIColorFromRGBWithAlpha(0xbf2c2a,1.0) forState:UIControlStateHighlighted];
    [self.commentBtn setTitleColor:UIColorFromRGBWithAlpha(0xa8a8a8,1.0) forState:UIControlStateNormal];
    [self.otherBtn setTitleColor:UIColorFromRGBWithAlpha(0xbf2c2a,1.0) forState:UIControlStateDisabled];
    [self.otherBtn setTitleColor:UIColorFromRGBWithAlpha(0xbf2c2a,1.0) forState:UIControlStateHighlighted];
    [self.otherBtn setTitleColor:UIColorFromRGBWithAlpha(0xa8a8a8,1.0) forState:UIControlStateNormal];
    self.commentBtn.titleLabel.font = [UIFont extentsionFontWithName:REGULAR_FONT size:14.0];
    self.otherBtn.titleLabel.font = [UIFont extentsionFontWithName:REGULAR_FONT size:14.0];
}

- (void)setPageViewUI{
    pageVC = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    pageVC.view.frame = CGRectMake(0, (NAV_HEIGHT+TABVIEW_HEIGHT), TOTAL_WIDTH, (TOTAL_HEIGHT - (NAV_HEIGHT+TABVIEW_HEIGHT)));
    pageVC.delegate = self;
    pageVC.dataSource = self;
    [self addChildViewController:pageVC];
    [self.view addSubview:pageVC.view];
    [pageVC didMoveToParentViewController:self];
    [self.view insertSubview:pageVC.view belowSubview:self.fmView];
    
    FMCommentTableViewController * fmCommentVC = [[FMCommentTableViewController alloc] initWithStyle:UITableViewStylePlain];
    fmCommentVC.commentDelegate = self;
    
    if (self.isMoringPage) {
        FMCharacterViewController * fmCharacterVC = [[FMCharacterViewController alloc] init];
        fmCharacterVC.characterDelegate = self;
        self.vcArray = [NSMutableArray arrayWithObjects:fmCommentVC,fmCharacterVC, nil];
        [pageVC setViewControllers:@[fmCharacterVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }else{
        FMConferenceTableViewController * fmConferenceVC = [[FMConferenceTableViewController alloc] initWithStyle:UITableViewStylePlain];
        fmConferenceVC.conferenceDelegate = self;
        self.vcArray = [NSMutableArray arrayWithObjects:fmCommentVC,fmConferenceVC, nil];
        [pageVC setViewControllers:@[fmConferenceVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    }
    
    [pageVC setViewControllers:@[fmCommentVC] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
}

#pragma mark UIPageViewControllerDataSource, UIPageViewControllerDelegate
- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    return viewController == self.vcArray.firstObject ? nil : self.vcArray.firstObject;
}

- (nullable UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    return viewController == self.vcArray.firstObject ? self.vcArray.lastObject : nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClick:(UIButton *)sender {
}

- (IBAction)commentTabClick:(UIButton *)sender {
    currentIndex = UIPageFlagComment;
    [pageVC setViewControllers:[NSArray arrayWithObjects:self.vcArray.firstObject, nil] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    [self changeTabBtnState:sender];
}

- (IBAction)otherTabClick:(UIButton *)sender {
    currentIndex = UIPageFlagConference;
    [pageVC setViewControllers:[NSArray arrayWithObjects:self.vcArray.lastObject, nil] direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    [self changeTabBtnState:sender];
}

- (void)didBeiginScroll:(UIScrollView *)scroll direction:(UIScrollDirection)direction{
    //两个限制条件。
    if (self.fmViewTopConstraint.constant == -ORIGIN_OFFSET && direction == UIScrollDirectionUp) {
        lastFMViewTopConstraint = -ORIGIN_OFFSET;
        lastContentOffsetY = 0;
        return;
    }
    if (self.fmViewTopConstraint.constant == 0 && direction == UIScrollDirectionDown) {
        lastFMViewTopConstraint = 0;
        lastContentOffsetY = (scroll.contentOffset.y <= -ORIGIN_OFFSET) ? -ORIGIN_OFFSET : scroll.contentOffset.y;
        return;
    }
    
    //移动fmView
    self.fmViewTopConstraint.constant = lastFMViewTopConstraint - (scroll.contentOffset.y - lastContentOffsetY);
    self.fmViewTopConstraint.constant = self.fmViewTopConstraint.constant > 0 ? 0 : (self.fmViewTopConstraint.constant < -ORIGIN_OFFSET ? -ORIGIN_OFFSET : self.fmViewTopConstraint.constant);
    self.fmViewTopConstraint.priority = UILayoutPriorityDefaultHigh;
    //改变透明度
    CGFloat alpha = 1 + (self.fmViewTopConstraint.constant/ORIGIN_OFFSET);
    self.fmView.alpha = alpha;
    
    //调整另一个表的contentOffset
    FMCommentTableViewController * commentVC = self.vcArray.firstObject;
    FMConferenceTableViewController * conferenceVC = self.vcArray.lastObject;
    if (currentIndex == UIPageFlagComment) {
        conferenceVC.tableView.contentOffset =  (conferenceVC.tableView.contentOffset.y >= -ORIGIN_OFFSET && conferenceVC.tableView.contentOffset.y <= 0) ? CGPointMake(0, (fabs(self.fmViewTopConstraint.constant) - ORIGIN_OFFSET)) : conferenceVC.tableView.contentOffset;
    }else{
        commentVC.tableView.contentOffset =  (commentVC.tableView.contentOffset.y >= -ORIGIN_OFFSET && commentVC.tableView.contentOffset.y <= 0) ? CGPointMake(0, (fabs(self.fmViewTopConstraint.constant) - ORIGIN_OFFSET)) : commentVC.tableView.contentOffset;
    }
}

- (void)didAppearViewFromPage:(UIPageFlag)pageFlag{
    currentIndex = pageFlag;
    if (currentIndex == UIPageFlagComment) {
        [self changeTabBtnState:self.commentBtn];
    }else{
        [self changeTabBtnState:self.otherBtn];
    }
}

- (void)changeTabBtnState:(UIButton *)btn{
    FMCommentTableViewController * commentVC = self.vcArray.firstObject;
    FMConferenceTableViewController * conferenceVC = nil;
    FMCharacterViewController * characterVC = nil;
    if (self.isMoringPage) {
        characterVC = self.vcArray.lastObject;
    }else{
        conferenceVC = self.vcArray.lastObject;
    }

    if (currentIndex == UIPageFlagComment) {
        self.commentBtn.enabled = NO;
        self.otherBtn.enabled = YES;
        self.redLineLeftConstraint.constant = 0;
        lastContentOffsetY = commentVC.tableView.contentOffset.y;
    }else{
        self.commentBtn.enabled = YES;
        self.otherBtn.enabled = NO;
        self.redLineLeftConstraint.constant = btn.frame.size.width;
        lastContentOffsetY = conferenceVC.tableView.contentOffset.y;
    }
    lastFMViewTopConstraint = self.fmViewTopConstraint.constant;
    self.redLineLeftConstraint.priority = UILayoutPriorityDefaultHigh;
    
    commentVC.tableView.scrollsToTop = !self.commentBtn.enabled;
    conferenceVC.tableView.scrollsToTop = !self.otherBtn.enabled;
}

@end
