//
//  FMConferenceTableViewController.m
//  FMProject
//
//  Created by mac on 16/6/17.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "FMConferenceTableViewController.h"
#import "HTFMViewControllerDelegate.h"

#define COLOR_HEIGHT   136.0
#define INSERT_TOP     171.0
#define IDENTIFIER   @"conferenceCell"

@interface FMConferenceTableViewController (){
    
    CGFloat lastOffsetY;
    UIView * bgColorView;
}

@end

@implementation FMConferenceTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置背景颜色
    bgColorView = [[UIView alloc] initWithFrame:CGRectMake(0, -INSERT_TOP, self.view.bounds.size.width, COLOR_HEIGHT)];
    bgColorView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bgColorView];
    
    self.tableView.contentInset = UIEdgeInsetsMake(INSERT_TOP, 0, 0, 0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * conferenceCell = IDENTIFIER;
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:conferenceCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:conferenceCell];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"conference  indexPath.row = %ld",(long)indexPath.row];
    
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastOffsetY = scrollView.contentOffset.y;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (!scrollView.scrollsToTop) {
        return;
    }
    
    bgColorView.alpha = scrollView.contentOffset.y >= -INSERT_TOP ? 1.0 : 0.0;

    UIScrollDirection direction = UIScrollDirectionUp;
    if (lastOffsetY > scrollView.contentOffset.y) {
        direction = UIScrollDirectionDown;
    }
    if (self.conferenceDelegate && [self.conferenceDelegate respondsToSelector:@selector(didBeiginScroll:direction:)]) {
        [self.conferenceDelegate didBeiginScroll:scrollView direction:direction];
    }
    lastOffsetY = scrollView.contentOffset.y;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if (self.conferenceDelegate && [self.conferenceDelegate respondsToSelector:@selector(didAppearViewFromPage:)]) {
        [self.conferenceDelegate didAppearViewFromPage:UIPageFlagConference];
    }
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
