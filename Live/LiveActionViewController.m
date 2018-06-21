//
//  LiveActionViewController.m
//  Live
//
//  Created by 耿荣林 on 2018/6/13.
//

#import "LiveActionViewController.h"
#import <LFLiveKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LiveActionViewController ()<LFLiveSessionDelegate>
@property (nonatomic,strong) LFLiveSession *session;
@end

@implementation LiveActionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self beatutyfaceBtn];
    //录制端
    [self requestAccessForVidoe];
    [self requestAudio];
    [self startLive];
}

- (void)beatutyfaceBtn{
    UIButton *actionBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    actionBtn.backgroundColor = [UIColor redColor];
    [actionBtn setTitle:@"开始直播" forState:UIControlStateNormal];
    [actionBtn addTarget:self action:@selector(openBeatyface:) forControlEvents:UIControlEventTouchUpInside];
    actionBtn.frame = CGRectMake(self.view.center.x - 50, 400, 100, 50);
    [self.view addSubview:actionBtn];
}

- (LFLiveSession*)session {
    if (!_session) {
        _session = [[LFLiveSession alloc] initWithAudioConfiguration:[LFLiveAudioConfiguration defaultConfiguration] videoConfiguration:[LFLiveVideoConfiguration defaultConfiguration]];
        _session.preView = self.view;
        _session.showDebugInfo = YES;
        _session.delegate = self;
    }
    return _session;
}

//获取系统的摄像头权限,获取视屏资源:
- (void)requestAccessForVidoe{
    __weak typeof (self) weakSelf = self;
    //判断授权状态
    AVAuthorizationStatus statues = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (statues) {
        case AVAuthorizationStatusNotDetermined:{
            //发起授权请求
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //进行会话
                        [weakSelf.session setRunning:YES];
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            //已授权继续
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.session setRunning:YES];
            });
            break;
        }
        default:
            break;
    }
}

//获取音频权限与资源:
- (void)requestAudio
{
    __weak typeof (self) weakSelf = self;
    AVAuthorizationStatus status = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeAudio];
    switch (status) {
        case AVAuthorizationStatusNotDetermined:{
            //发起授权请求
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeAudio completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        //进行会话
                        [weakSelf.session setRunning:YES];
                    });
                }
            }];
            break;
        }
        case AVAuthorizationStatusAuthorized:{
            //授权继续
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.session setRunning:YES];
            });
        }
        default:
            break;
    }
    
}

//LFLivekit监听delegate方法:
- (void)liveSession:(LFLiveSession *)session errorCode:(LFLiveSocketErrorCode)errorCode
{
    //弹出警告
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Warning" message:@"链接错误,请检查IP地址" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"sure" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alert addAction:sure];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)startLive {
    LFLiveStreamInfo *streamInfo = [LFLiveStreamInfo new];
    streamInfo.url = @"rtmp://192.168.0.4:1935/rtmplive/home";
    [self.session startLive:streamInfo];
}

- (void)openBeatyface:(UIButton *)btn{
    _session.beautyFace = YES;
}

- (void)stopLive {
    [self.session stopLive];
}

//MARK: - CallBack:
- (void)liveSession:(nullable LFLiveSession *)session liveStateDidChange: (LFLiveState)state{
    
}

- (void)liveSession:(nullable LFLiveSession *)session debugInfo:(nullable LFLiveDebug*)debugInfo{
    
}

- (void)viewDidDisappear:(BOOL)animated{
    [self stopLive];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
