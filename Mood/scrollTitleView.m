//
//  scrollTitleView.m
//  Mood
//
//  Created by ZhangQing on 13-3-10.
//  Copyright (c) 2013年 Mood. All rights reserved.
//

#import "scrollTitleView.h"

@implementation scrollTitleView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
//        self.scrollview = [[UIScrollView alloc] initWithFrame:frame];
//        self.scrollview.backgroundColor = [UIColor clearColor];
//        self.scrollview.scrollEnabled = NO;
//        [self addSubview:self.scrollview];
        
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0.f, 0.f, 0.f, frame.size.height)];
        self.title.backgroundColor = [UIColor clearColor];
        self.title.textColor = [UIColor redColor];
        [self.title setFont:[UIFont systemFontOfSize:frame.size.height-2]];
        [self addSubview:self.title];
    }
    return self;
}

-(void)setmusicInfo:(NSString *)info
{
    musicInfo = info;
    self.title.text = musicInfo;
    [self setNeedsDisplay];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    //获得文字的宽

    CGSize strWidth = [self.title.text sizeWithFont:self.title.font];
    
    if (strWidth.width > 320.f) {
        self.title.frame = CGRectMake(320.f, 0.f, strWidth.width, self.title.frame.size.height);
        self.title.textAlignment = NSTextAlignmentLeft;
    }else
    {
        self.title.frame = CGRectMake(0.f, 0.f, 320.f, self.title.frame.size.height);
        self.title.textAlignment = NSTextAlignmentCenter;
    }
}
-(void)beginScroll
{
    CGSize strWidth = [self.title.text sizeWithFont:self.title.font];
    if (strWidth.width > 320.f) {
        //timer = [NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(move) userInfo:nil repeats:YES];
        timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(move) userInfo:nil repeats:YES];
        
    }else return;
    
}
-(void)resetFrame
{
     [self setNeedsDisplay];
}
-(void)move
{
    //CGSize strWidth = [self.title.text sizeWithFont:self.title.font];
    if (plus>self.title.frame.size.width + 320.f) {
        plus = 0;
        [self resetFrame];
        [self beginScroll];
    }else
    {
        self.title.frame = CGRectMake(320.f-plus, 0.f, self.title.frame.size.width, self.title.frame.size.height);
    }
    plus++;
}
@end
