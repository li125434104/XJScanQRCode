//
//  XJViewController.m
//  XJScanQRCode
//
//  Created by li125434104 on 04/30/2019.
//  Copyright (c) 2019 li125434104. All rights reserved.
//

#import "XJViewController.h"
#import "XJScanView.h"
#import "XJScanTools.h"

@interface XJViewController ()

@property (nonatomic, strong) XJScanView *scanView;
@property (nonatomic, strong) XJScanTools *scanTool;

@end

@implementation XJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //输出流视图
    UIView *preview  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:preview];
    
    self.scanView = [[XJScanView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:self.scanView];
    [self.scanView showFlashSwitch:YES];
    
    __weak typeof(self) weakSelf = self;
    
    self.scanTool = [[XJScanTools alloc] initWithPreview:preview andScanFrame:self.scanView.scanSweepAreaRect];
    [self.scanTool sessionStartRunning];
    self.scanTool.scanFinishedBlock = ^(NSString *scanString) {
        NSLog(@"扫描结果：%@",scanString);
        [weakSelf.scanView handlingResultsOfScan];
        [weakSelf.scanTool sessionStopRunning];
        
    };
    self.scanTool.monitorLightBlock = ^(float brightness) {
        NSLog(@"环境光感 ： %f",brightness);
        if (brightness < 0) {
            // 环境太暗，显示闪光灯开关按钮
            [weakSelf.scanView showFlashSwitch:YES];
        }else if(brightness > 0){
            // 环境亮度可以,且闪光灯处于关闭状态时，隐藏闪光灯开关
            if(!weakSelf.scanTool.flashOpen){
                [weakSelf.scanView showFlashSwitch:NO];
            }
        }
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
