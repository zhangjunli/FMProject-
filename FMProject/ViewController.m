//
//  ViewController.m
//  FMProject
//
//  Created by mac on 16/6/16.
//  Copyright © 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import "HTFMViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    HTFMViewController * htFMVC = [[HTFMViewController alloc] init];
    self.navigationController.navigationBar.hidden = YES;
    [self.navigationController pushViewController:htFMVC animated:YES];
}
@end
