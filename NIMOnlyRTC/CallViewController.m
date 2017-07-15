//
//  AVChatViewController.m
//  NIMOnlyRTC
//
//  Created by Nick Deng on 2017/6/28.
//  Copyright © 2017年 Nick Deng. All rights reserved.
//

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)


#import "CallViewController.h"
#import <NIMAVChat/NIMAVChat.h>

@interface CallViewController ()<NIMNetCallManagerDelegate>
@property (weak, nonatomic) IBOutlet UITextField *txfCallee;
@property (weak, nonatomic) IBOutlet UIButton *btnCall;
@property (weak, nonatomic) IBOutlet UILabel *labCallee;

@property (assign, nonatomic) UInt64 chatid;
@property (strong, nonatomic) UIButton *btnAccept;
@property (strong, nonatomic) UIButton *btnReject;

@property (nonatomic, strong) UIView *localView;
@property (nonatomic, strong) UIView *localViewPrew;

@property (nonatomic, strong) UIImageView *remoteView;

@end

@implementation CallViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NIMAVChatSDK sharedSDK].netCallManager addDelegate:self];
    
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    //[[NIMAVChatSDK sharedSDK].netCallManager removeDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)doCall:(id)sender {
    NSArray *callees = [NSArray arrayWithObjects:self.txfCallee.text, nil];
    
    NIMNetCallVideoCaptureParam *captureParam = [[NIMNetCallVideoCaptureParam alloc]init];
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    option.videoCaptureParam = captureParam;
    
    option.alwaysKeepCalling = YES;
    
    __weak typeof (& *self)wself = self;
    
    [[NIMAVChatSDK sharedSDK].netCallManager start:callees type:NIMNetCallMediaTypeVideo option:option completion:^(NSError * _Nullable error, UInt64 callID) {
        wself.chatid = callID;
        if (!error) {
            NSLog(@"拨打成功！");
            
            [self showCallingView];
        }
    }];
}

- (IBAction)textFieldDoneEditing:(id)sender {
    [self.txfCallee resignFirstResponder];
}

-(void)showCallingView{
    
    [self removedDialingView];
    
    self.btnReject = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 75/2, SCREEN_HEIGHT*4/5, 90, 40)];
    self.btnReject.backgroundColor = [UIColor redColor];
    [self.btnReject setTitle:@"挂断" forState:UIControlStateNormal];
    [self.view addSubview:self.btnReject];
    
    [self.btnReject addTarget:self action:@selector(doHangup:) forControlEvents:UIControlEventTouchUpInside];
    
    
}

-(void)showCalledView{
    
    [self removedDialingView];
    
    self.btnAccept = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 75/2, SCREEN_HEIGHT*3/5, 90, 40)];
    self.btnReject = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 75/2, SCREEN_HEIGHT*4/5, 90, 40)];
    [self.btnAccept setTitle:@"接听" forState:UIControlStateNormal];
    [self.btnReject setTitle:@"挂断" forState:UIControlStateNormal];
    
    self.btnReject.backgroundColor = [UIColor redColor];
    self.btnAccept.backgroundColor = [UIColor greenColor];
    
    [self.view addSubview:self.btnAccept];
    [self.view addSubview:self.btnReject];
    
    [self.btnAccept addTarget:self action:@selector(doAccept:) forControlEvents:UIControlEventTouchUpInside];
    [self.btnReject addTarget:self action:@selector(doHangup:) forControlEvents:UIControlEventTouchUpInside];

}

-(void)removedDialingView{
    
    [self.txfCallee setHidden:YES];
    [self.btnCall setHidden:YES];
    [self.labCallee setHidden:YES];
    
}

-(void)showDialingView{
    
    [self.txfCallee setHidden:NO];
    [self.btnCall setHidden:NO];
    [self.labCallee setHidden:NO];
    
}


-(void)showAVchatView{
    
    self.remoteView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.remoteView];
    
    self.localView = [[UIView alloc] initWithFrame:CGRectMake(15, CGRectGetHeight(self.view.frame) - 20 - 160, 120, 160)];
    self.localView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.localView];
    
    if (!self.localViewPrew) {
        self.localViewPrew = [NIMAVChatSDK sharedSDK].netCallManager.localPreview;
    }
    
    self.localViewPrew.frame = self.localView.bounds;
    [self.localView addSubview:self.localViewPrew];
    
    [self.view bringSubviewToFront:self.btnReject];
    
}





-(void)doAccept:(id)sender{
    __weak typeof(& *self)wself = self;
    
    [self.btnAccept removeFromSuperview];
    self.btnAccept = nil;
    NIMNetCallVideoCaptureParam *param = [[NIMNetCallVideoCaptureParam alloc] init];
    NIMNetCallOption *option = [[NIMNetCallOption alloc] init];
    option.videoCaptureParam = param;
    
    [[NIMAVChatSDK sharedSDK].netCallManager response:self.chatid accept:YES option:option completion:^(NSError * _Nullable error, UInt64 callID) {
        wself.chatid = callID;
        
        if (!error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [wself.btnAccept removeFromSuperview];
                [wself showAVchatView];
            });
            
        }
    }];
}

-(void)doHangup:(UInt64)callId{
    
    if (self.localView) {
        [self.localView removeFromSuperview];
        self.localView = nil;
    }
    
    if (self.remoteView) {
        [self.remoteView removeFromSuperview];
        self.remoteView = nil;
    }
    
    [self.btnAccept removeFromSuperview];
    
    [self.btnReject removeFromSuperview];
    self.btnAccept = nil;
    self.btnReject = nil;
    
    [self showDialingView];
    
    [[NIMAVChatSDK sharedSDK].netCallManager hangup:self.chatid];
}




#pragma mark - NIMNetCallManagerDelegate

-(void)onResponse:(UInt64)callID from:(NSString *)callee accepted:(BOOL)accepted{
    
    if (accepted) {
        [self showAVchatView];
    }
    
}

-(void)onRemoteImageReady:(CGImageRef)image{
    self.remoteView.image = [UIImage imageWithCGImage:image];
}

-(void)onLocalDisplayviewReady:(UIView *)displayView{
    if (self.localViewPrew) {
        [self.localViewPrew removeFromSuperview];
    }
    
    self.localViewPrew = displayView;
    displayView.frame = self.localView.bounds;
    [self.localView addSubview:displayView];
    
    
    NSLog(@"---------------走了-----------------");
}

-(void)onRemoteYUVReady:(NSData *)yuvData width:(NSUInteger)width height:(NSUInteger)height from:(NSString *)user{
    
}


-(void)onReceive:(UInt64)callID from:(NSString *)caller type:(NIMNetCallMediaType)type message:(NSString *)extendMessage{
    self.chatid = callID;
    
    [self showCalledView];
    
}

-(void)onCallEstablished:(UInt64)callID{
    
    NSLog(@"通话已经接通！");
//    self.localViewPrew = [NIMAVChatSDK sharedSDK].netCallManager.localPreview;
//    [self onLocalDisplayviewReady:self.localViewPrew];
    
}


-(void)onHangup:(UInt64)callID by:(NSString *)user{
    [self doHangup:callID];
}

@end
