//
//  LiveViewController.m
//  Live
//
//  Created by 耿荣林 on 2018/6/11.
//

#import "LiveViewController.h"
#import "PullViewController.h"
#import "PushViewController.h"

@interface LiveViewController ()

@end

@implementation LiveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    PushViewController *pushVC = [[PushViewController alloc]init];
    pushVC.title = @"直播";
    UINavigationController *PushNA = [[UINavigationController alloc]initWithRootViewController:pushVC];
    
    PullViewController *pullVC = [[PullViewController alloc]init];
    pullVC.title = @"看直播";
    UINavigationController *PullNA = [[UINavigationController alloc]initWithRootViewController:pullVC];
    self.viewControllers = @[PushNA,PullNA];
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
