//
//  PullViewController.m
//  Live
//
//  Created by 耿荣林 on 2018/6/11.
//

#import "PullViewController.h"
#import "MessageViewController.h"
#import <LFLiveKit.h>
#import "AFNetworking.h"
#import <IJKMediaFramework/IJKMediaFramework.h>

@interface PullViewController ()<LFLiveSessionDelegate>
@property (nonatomic,strong) IJKFFMoviePlayerController *player;
@end

@implementation PullViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addPlayerController];
}

- (void)addPlayerController{
    _player = [[IJKFFMoviePlayerController alloc]initWithContentURL:[NSURL URLWithString:@"rtmp://192.168.0.4:1935/rtmplive/home"] withOptions:nil];
    [_player prepareToPlay];
    _player.view.frame = self.view.bounds;
    [self.view insertSubview:_player.view atIndex:1];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // 界面消失，一定要记得停止播放
    [_player pause];
    [_player stop];
    [_player shutdown];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    [self.navigationController pushViewController:[[MessageViewController alloc]init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
