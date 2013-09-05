//
//  ViewController.m
//  Mood
//
//  Created by ZhangQing on 13-2-23.
//  Copyright (c) 2013年 Mood. All rights reserved.
//

#import "ViewController.h"

#import "JSONKit.h"
#define playBtnTag 1
#define stopBtnTag 2

#define typeBtnWidth 75.f
#define typeBtnHeight 75.f

#define typeBtnLeft 20.f
//下排y坐标
#define typeBtnMiddle 180.f

@interface ViewController ()

@end

@implementation ViewController
-(MPMoviePlayerController *)musicPlayer
{
    if (!_musicPlayer) {
        _musicPlayer = [[MPMoviePlayerController alloc] init];
        _musicPlayer.movieSourceType = MPMovieControlModeHidden;
        
    }
    return _musicPlayer;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    //self.view.backgroundColor = [UIColor blackColor];
    


    
    UIImageView *background = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background.jpg"]];
    [background setFrame:CGRectMake(0, 0, 320.f, 460.f)];
    [self.view addSubview:background];
    
    //joy
    UIButton *joyBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    joyBtn.tag = MusicType_JOY;
    [joyBtn setFrame:CGRectMake(320/2-typeBtnWidth/2, 30, typeBtnWidth, typeBtnHeight)];
    [joyBtn addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    [joyBtn setBackgroundImage:[UIImage imageNamed:@"joy"] forState:UIControlStateNormal];
	[joyBtn setBackgroundImage:[UIImage imageNamed:@"joy_press"] forState:UIControlStateHighlighted];
    [self.view addSubview:joyBtn];
    
    //bored
    UIButton *boredBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    boredBtn.tag = MusicType_BORED;
    [boredBtn setFrame:CGRectMake(20, 30+typeBtnHeight*2/3, typeBtnWidth, typeBtnHeight)];
    [boredBtn setBackgroundImage:[UIImage imageNamed:@"bored"] forState:UIControlStateNormal];
	[boredBtn setBackgroundImage:[UIImage imageNamed:@"bored_press"] forState:UIControlStateHighlighted];
    [boredBtn addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:boredBtn];
    
    //anger
    UIButton *angerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    angerBtn.tag = MusicType_ANGER;
    [angerBtn setFrame:CGRectMake(20, typeBtnMiddle, typeBtnWidth, typeBtnHeight)];
    [angerBtn setBackgroundImage:[UIImage imageNamed:@"anger"] forState:UIControlStateNormal];
	[angerBtn setBackgroundImage:[UIImage imageNamed:@"anger_press"] forState:UIControlStateHighlighted];
    [angerBtn addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:angerBtn];
    
    //fear
    UIButton *fearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    fearBtn.tag = MusicType_FEAR;
    [fearBtn setFrame:CGRectMake(320/2-65/2, typeBtnMiddle+typeBtnHeight*2/3, typeBtnWidth, typeBtnHeight)];
    [fearBtn setBackgroundImage:[UIImage imageNamed:@"fear"] forState:UIControlStateNormal];
	[fearBtn setBackgroundImage:[UIImage imageNamed:@"fear_press"] forState:UIControlStateHighlighted];
   [fearBtn addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
   [self.view addSubview:fearBtn];
    
    //sadness
    UIButton *sadnessBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    sadnessBtn.tag = MusicType_SADNESS;
    [sadnessBtn setFrame:CGRectMake(300-typeBtnWidth, 30+typeBtnHeight*2/3, typeBtnWidth, typeBtnHeight)];
    [sadnessBtn setBackgroundImage:[UIImage imageNamed:@"sadness"] forState:UIControlStateNormal];
	[sadnessBtn setBackgroundImage:[UIImage imageNamed:@"sadness_press"] forState:UIControlStateHighlighted];
    [sadnessBtn addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sadnessBtn];
    
    //love
    UIButton *loveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    loveBtn.tag = MusicType_LOVE;
    [loveBtn setFrame:CGRectMake(300-typeBtnWidth, typeBtnMiddle, typeBtnWidth, typeBtnHeight)];
    [loveBtn setBackgroundImage:[UIImage imageNamed:@"love"] forState:UIControlStateNormal];
	[loveBtn setBackgroundImage:[UIImage imageNamed:@"love_press"] forState:UIControlStateHighlighted];
    [self.view addSubview:loveBtn];
    [loveBtn addTarget:self action:@selector(playMusic:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view, typically from a nib.
    
    //play btn
    self.playButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.playButton setFrame:CGRectMake(320/2-50/2, 360, 50, 50)];
    [self.playButton addTarget:self action:@selector(randomPlay:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.playButton];
    [self changePlayBtnStatus:NO];

    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextBtn setFrame:CGRectMake(240, 360, 50.f, 50.f)];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"next"] forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageNamed:@"next_press"] forState:UIControlStateHighlighted];
    [nextBtn addTarget:self action:@selector(nextMusic:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    
    titleView = [[scrollTitleView alloc]  initWithFrame:CGRectMake(0, 0, 320, 24)];
    [self.view addSubview:titleView];
    
//    NSURL *url = [NSURL URLWithString:@"http://192.168.0.113:8080/Mood/services/MoodService"];
//    //http://192.168.0.113:8080/Mood/services/MoodService?wsdl
//    //NSURL *url = [NSURL URLWithString:@"http://192.168.0.113:8080/Mood/services/MoodService?wsdl"];
//    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
//    [request setDelegate:self];
//    [request startAsynchronous];
    [self getRequest];
    
}
-(void)getRequest
{
    NSURL *url = [NSURL URLWithString:@"http://192.168.0.113:8080/Mood/services/MoodService"];
    //请求发送到的路径
    ASIHTTPRequest *theRequest =  [ASIHTTPRequest requestWithURL:url];
   // NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
    [theRequest addRequestHeader:@"Content-Type" value:@"text/xml; charset=utf-8"];
    [theRequest addRequestHeader: @"SOAPAction" value:@"http://192.168.0.113:8080/Mood/services/MoodService?wsdl"];
    //[theRequest addRequestHeader:@"Content-Length" value:msgLength];
    [theRequest setRequestMethod:@"POST"];
    //[theRequest appendPostData: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    [theRequest setDefaultResponseEncoding:NSUTF8StringEncoding];
    [theRequest setDelegate:self];
    [theRequest startSynchronous];

}
- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
    NSString *responseString = [request responseString];
    
    // Use when fetching binary data
    NSData *responseData = [request responseData];
    NSString *jsonValue=[[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    jsonValue = [jsonValue stringByReplacingOccurrencesOfString:@"\\" withString:@"-|-"];
    
    NSDictionary *jsonDic=[jsonValue  objectFromJSONString];
    
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
}
//播放暂停。
-(void)randomPlay:(UIButton *)sender
{
    if (sender.tag == stopBtnTag) {
        [self changePlayBtnStatus:NO];
        [self.musicPlayer pause];
    }else
    {
        [self changePlayBtnStatus:YES];
        [self.musicPlayer play];
    }

}
//按类别播放
-(void)playMusic:(UIButton *)sender
{
    [titleView setmusicInfo:@"温柔－---------------－ 五月天－----/"];
    [titleView  beginScroll];
    
    [self changePlayBtnStatus:YES];
    [self.musicPlayer setContentURL:[NSURL URLWithString:@"http://y1.eoews.com/assets/ringtones/2012/5/18/34049/oiuxsvnbtxks7a0tg6xpdo66exdhi8h0bplp7twp.mp3"]];
    [self.musicPlayer play];
    
    switch (sender.tag) {
        case MusicType_ANGER:
        {
        }
            break;
        case MusicType_BORED:
        {
        }
            break;
        case MusicType_FEAR:
        {
        }
            break;
        case MusicType_JOY:
        {
        }
            break;
        case MusicType_LOVE:
        {
        }
            break;
        case MusicType_SADNESS:
        {
        }
            break;
        case MusicType_SUIJI:
        {
            
        }
            break;
        default:
        {
            
        }
            break;
    }
    
}
//下一首
-(void)nextMusic:(UIButton *)sender
{
    
}
//改变按钮状态
-(void)changePlayBtnStatus:(BOOL)isPause
{
    if (isPause) {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop"] forState:UIControlStateNormal];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"stop_press"] forState:UIControlStateHighlighted];
        self.playButton.tag = stopBtnTag;
    }else
    {
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        [self.playButton setBackgroundImage:[UIImage imageNamed:@"play_press"] forState:UIControlStateHighlighted];
        self.playButton.tag = playBtnTag;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark mpmoviePlayerDelegate
- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection
{
    NSLog(@"aaa");
}
- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker
{
    NSLog(@"bbb");
}
@end
