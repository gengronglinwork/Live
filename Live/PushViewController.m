//
//  PushViewController.m
//  Live
//
//  Created by 耿荣林 on 2018/6/11.
//

#import "PushViewController.h"
#import <LFLiveKit.h>
#import "LiveActionViewController.h"

@interface PushViewController ()<LFLiveSessionDelegate>
@end

@implementation PushViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self liveAction];
}

- (void)liveAction{
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    actionBtn.backgroundColor = [UIColor redColor];
    [actionBtn setTitle:@"开始直播" forState:UIControlStateNormal];
    [actionBtn addTarget:self action:@selector(live) forControlEvents:UIControlEventTouchUpInside];
    actionBtn.frame = CGRectMake(self.view.center.x - 50, 400, 100, 50);
    [self.view addSubview:actionBtn];
}

- (void)live{
    [self.navigationController pushViewController:[[LiveActionViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


@end
