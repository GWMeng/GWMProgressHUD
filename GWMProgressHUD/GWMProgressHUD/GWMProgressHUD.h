//
//  GWMProgressHUD.h
//  GWMProgressHUD
//
//  Created by gongweimeng on 2018/3/6.
//  Copyright © 2018年 GWM. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GWMProgressHUD : UIView
+(void)showHUDWithTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images toView:(UIView *)view;
+(void)showSuccessWithTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images toView:(UIView *)view;
+(void)showFailWithTitle:(NSString *)title detail:(NSString *)detail images:(NSArray *)images toView:(UIView *)view;
+ (void)hidHUDForView:(UIView *)view;
@end
