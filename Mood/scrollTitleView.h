//
//  scrollTitleView.h
//  Mood
//
//  Created by ZhangQing on 13-3-10.
//  Copyright (c) 2013年 Mood. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface scrollTitleView : UIView
{
    NSString *musicInfo;
    NSTimer *timer;
    int plus;
}
@property (nonatomic , strong) UIScrollView *scrollview;
@property (nonatomic , strong) UILabel *title;


-(void)setmusicInfo:(NSString *)info;
-(void)beginScroll;

-(void)resetFrame;
@end
