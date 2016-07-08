//
//  FMCharacterViewController.m
//  FMProject
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FMCharacterViewController.h"
#import "HTFMViewControllerDelegate.h"

@interface FMCharacterViewController ()<UIScrollViewDelegate,UIWebViewDelegate>{
    
    CGFloat beginOffsetY;
}

@end

@implementation FMCharacterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    UIWebView * web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 171, self.view.bounds.size.width, 200)];
    web.delegate = self;
    web.scrollView.delegate = self;
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [web loadRequest:request];
    web.backgroundColor = [UIColor orangeColor];
    NSLog(@"web.scrollView = %@",web.scrollView);
    [self.view addSubview:web];

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    beginOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"scrollView.contentOffset = %f",scrollView.contentOffset.y);

    UIScrollDirection direction = UIScrollDirectionUp;
    if (beginOffsetY > scrollView.contentOffset.y) {
        direction = UIScrollDirectionDown;
    }
    if (self.characterDelegate && [self.characterDelegate respondsToSelector:@selector(didBeiginScroll:direction:)]) {
        [self.characterDelegate didBeiginScroll:scrollView direction:direction];
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.characterDelegate && [self.characterDelegate respondsToSelector:@selector(didAppearViewFromPage:)]) {
        [self.characterDelegate didAppearViewFromPage:UIPageFlagCharacter];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
