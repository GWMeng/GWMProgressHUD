//
//  GWMProgressHUD.m
//  GWMProgressHUD
//
//  Created by gongweimeng on 2018/3/6.
//  Copyright © 2018年 GWM. All rights reserved.
//

#import "GWMProgressHUD.h"
@interface GWMProgressHUD ()
{
    UIImageView *backImage;
    UIImageView *centerImage;
    NSArray *imagesArray;
    UILabel *titleLabel;
    UILabel *detailLabel;
}
@property(nonatomic,weak)UIActivityIndicatorView * activityIndicator;
@property(nonatomic,strong)NSTimer *imgTimer;
@property(nonatomic,assign)int imgNumber;
@end


@implementation GWMProgressHUD
+(void)showHUDWithTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images toView:(UIView *)view
{
    GWMProgressHUD *hud=[[self alloc]initWithTitle:title detail:detail images:images view:view];
    [view addSubview:hud];
}
+(void)showSuccessWithTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images toView:(UIView *)view
{
    NSArray *arr=@[@"success"];
    GWMProgressHUD *hud=[[self alloc]initWithTitle:title detail:detail images:arr view:view];
    [view addSubview:hud];
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [GWMProgressHUD hidHUDForView:view];
    }];
}
+(void)showFailWithTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images toView:(UIView *)view
{
    NSArray *arr=@[@"error"];
    GWMProgressHUD *hud=[[self alloc]initWithTitle:title detail:detail images:arr view:view];
    [view addSubview:hud];
    NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:1.0 repeats:NO block:^(NSTimer * _Nonnull timer) {
        [GWMProgressHUD hidHUDForView:view];
    }];
}

+(void)hidHUDForView:(UIView *)view
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            GWMProgressHUD *hud = (GWMProgressHUD *)subview;
            if (hud.activityIndicator) {
                [hud.activityIndicator stopAnimating];
            }
            if (hud.imgTimer) {
                [hud.imgTimer invalidate];
                hud.imgNumber=0;
            }
            [hud removeFromSuperview];
            hud=nil;
        }
    }
}
-(UIView *)initWithTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images view:(UIView *)view
{
    return [self initWithFrame:view.frame title:title detail:detail images:images];
}
-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title detail:(NSString *)detail images:(NSArray *)images
{
    self = [super initWithFrame:frame];
    if(self)
    {
//        self.backgroundColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self setUpSubviewsTitle:title detail:detail images:images];
    }
    return self;
}
-(void)setUpSubviewsTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images
{
    imagesArray=images;
    backImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    if (title) {
        CGFloat widthT=[title sizeWithFont:[UIFont systemFontOfSize:13]].width;
        if (detail) {
            CGFloat widthD=[detail sizeWithFont:[UIFont systemFontOfSize:11]].width;
            if (widthD>widthT) {
                if (widthD>=80) {
                    if (widthD>=self.frame.size.width-40) {
                        widthD=self.frame.size.width-40;
                    }
                    backImage.frame=CGRectMake(0, 0, widthD+20, 100);
                }
            }else{
                if (widthT>=80) {
                    if (widthT>=self.frame.size.width-40) {
                        widthT=self.frame.size.width-40;
                    }
                    backImage.frame=CGRectMake(0, 0, widthT+20, 100);
                }
            }
        }else{
            if (widthT>=80) {
                if (widthT>=self.frame.size.width-40) {
                    widthT=self.frame.size.width-40;
                }
                backImage.frame=CGRectMake(0, 0, widthT+20, 100);
            }
        }
    }
    backImage.layer.cornerRadius=3.0;
    backImage.layer.masksToBounds=YES;
    [self addSubview:backImage];
    backImage.center=self.center;
    
    if (!images) {
        backImage.backgroundColor=[UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
        UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhiteLarge)];
        activityIndicator.frame= CGRectMake(backImage.frame.size.width/2-40/2, 10, 40, 40);
        [backImage addSubview:activityIndicator];
        activityIndicator.color = [UIColor whiteColor];
        activityIndicator.backgroundColor = [UIColor clearColor];
        activityIndicator.hidesWhenStopped = NO;
        self.activityIndicator=activityIndicator;
        if (!title) {
            activityIndicator.frame= CGRectMake(backImage.frame.size.width/2-40/2, 30, 40, 40);
        }else{
            titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(activityIndicator.frame), backImage.frame.size.width-20, 20)];
            if (!detail) {
                titleLabel.frame=CGRectMake(10, CGRectGetMaxY(activityIndicator.frame), backImage.frame.size.width-20, 40);
            }
            titleLabel.font=[UIFont systemFontOfSize:13];
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.textColor=[UIColor whiteColor];
            titleLabel.text=title;
            [backImage addSubview:titleLabel];
            if (detail) {
                detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame), backImage.frame.size.width-20, 20)];
                detailLabel.font=[UIFont systemFontOfSize:11];
                detailLabel.textAlignment=NSTextAlignmentCenter;
                detailLabel.textColor=[UIColor whiteColor];
                detailLabel.text=detail;
                [backImage addSubview:detailLabel];
            }
        }
        [activityIndicator startAnimating];
    }else{
        self.backgroundColor=[UIColor colorWithRed:211/225.0 green:211/225.0 blue:211/225.0 alpha:0.4];
        backImage.backgroundColor=[UIColor clearColor];
        centerImage=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, backImage.frame.size.width, 60)];
        centerImage.image=[UIImage imageNamed:images[0]];
        centerImage.contentMode=UIViewContentModeScaleAspectFit;
        [backImage addSubview:centerImage];
        if (!title) {
            centerImage.frame= CGRectMake(0, 0, backImage.frame.size.width, backImage.frame.size.height);
            if (images.count==1) {
                centerImage.frame=CGRectMake(backImage.frame.size.width/2-40/2, backImage.frame.size.height/2-40/2, 40, 40);
            }
        }else{
            titleLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(centerImage.frame), backImage.frame.size.width-20, 20)];
            if (!detail) {
                titleLabel.frame=CGRectMake(10, CGRectGetMaxY(centerImage.frame), backImage.frame.size.width-20, 40);
            }
            titleLabel.font=[UIFont systemFontOfSize:13];
            titleLabel.textAlignment=NSTextAlignmentCenter;
            titleLabel.textColor=[UIColor grayColor];
            titleLabel.text=title;
            [backImage addSubview:titleLabel];
            if (detail) {
                detailLabel=[[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame), backImage.frame.size.width-20, 20)];
                detailLabel.font=[UIFont systemFontOfSize:11];
                detailLabel.textAlignment=NSTextAlignmentCenter;
                detailLabel.textColor=[UIColor grayColor];
                detailLabel.text=detail;
                [backImage addSubview:detailLabel];
            }
            if (images.count==1) {
                centerImage.frame=CGRectMake(backImage.frame.size.width/2-40/2, 10, 40, 40);
            }
        }
        if (self.imgTimer) {
            [self.imgTimer invalidate];
            self.imgTimer=nil;
        }
        self.imgNumber=0;
        if (images.count>1) {
            self.imgTimer=[NSTimer scheduledTimerWithTimeInterval:0.15 target:self selector:@selector(changeImg) userInfo:nil repeats:YES];
        }else{
            titleLabel.textColor=[UIColor whiteColor];
            detailLabel.textColor=[UIColor whiteColor];
            self.backgroundColor=[UIColor clearColor];
            backImage.backgroundColor=[UIColor colorWithRed:200/250.0 green:200/250.0 blue:200/250.0 alpha:1.0];
        }
        
    }
}
-(void)changeImg
{
    self.imgNumber=self.imgNumber+1;
    if (self.imgNumber>imagesArray.count-1) {
        self.imgNumber=0;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        centerImage.image=[UIImage imageNamed:imagesArray[self.imgNumber]];
    });
}
@end
