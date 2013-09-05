//
//  ViewController.h
//  Mood
//
//  Created by ZhangQing on 13-2-23.
//  Copyright (c) 2013年 Mood. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "scrollTitleView.h"
#import "ASIHTTPRequest.h"
typedef enum MusicType{
    MusicType_JOY = 1,
    MusicType_BORED = 2,
    MusicType_ANGER = 3,
    MusicType_LOVE = 4,
    MusicType_SADNESS = 5,
    MusicType_FEAR = 6,
    MusicType_SUIJI = 7
}MusicType;
@interface ViewController : UIViewController<MPMediaPickerControllerDelegate,ASIHTTPRequestDelegate>
{
    scrollTitleView    *titleView ;
}
@property(nonatomic , strong) MPMoviePlayerController *musicPlayer;
@property(nonatomic , strong) UIButton *playButton;
@end
