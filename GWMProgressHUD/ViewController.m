//
//  ViewController.m
//  GWMProgressHUD
//
//  Created by gongweimeng on 2018/3/6.
//  Copyright © 2018年 GWM. All rights reserved.
//

#import "ViewController.h"
#import "GWMProgressHUD.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addButtons];
    
}
//添加一些按钮
-(void)addButtons
{
    NSArray *btnArray=@[@"只有图片的loading",@"带文本的loading",@"2行文本的loading",@"可自动隐藏成功提示",@"可自动隐藏的失败提示",@"默认显示菊花"];
    for (int n=0; n<btnArray.count; n++) {
        UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(30, 60+n*(40+10), self.view.frame.size.width-30*2, 40)];
        btn.layer.cornerRadius=3.0;
        btn.layer.masksToBounds=YES;
        btn.layer.borderColor=[[UIColor blueColor] CGColor];
        btn.layer.borderWidth=1.0;
        btn.tag=n;
        [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [btn setTitle:btnArray[n] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(showHUD:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

-(void)showHUD:(UIButton *)sender
{
    //这里是构造一个图片数组，使用时可以替换成自己的图片，同一个项目中不同的界面如果有不同的loading动画，只要把图片数组换一下就可以满足多样性的需求了
    NSMutableArray *images=[[NSMutableArray alloc]init];
    for (int n=0; n<16; n++) {
        [images addObject:[NSString stringWithFormat:@"%d.jpg",n]];
    }
    if (sender.tag==0) {
        //这里调用显示HUD
        [GWMProgressHUD showHUDWithTitle:nil detail:nil images:images toView:self.view];
        //这里用定时器隐藏，实际使用时可以在需要的时候用[GWMProgressHUD hidHUDForView:self.view]隐藏掉
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hidHUD) userInfo:nil repeats:NO];
    }else if (sender.tag==1){
        //优先使用title，无title不detail
        [GWMProgressHUD showHUDWithTitle:@"Loading" detail:nil images:images toView:self.view];
        //这里用定时器隐藏，实际使用时可以在需要的时候用[GWMProgressHUD hidHUDForView:self.view]隐藏掉
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hidHUD) userInfo:nil repeats:NO];
    }else if (sender.tag==2){
        //优先使用title，无title不detail
        [GWMProgressHUD showHUDWithTitle:@"Loading" detail:@"Loading for you" images:images toView:self.view];
        //这里用定时器隐藏，实际使用时可以在需要的时候用[GWMProgressHUD hidHUDForView:self.view]隐藏掉
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hidHUD) userInfo:nil repeats:NO];
    }else if (sender.tag==3){
        //这里也可以添加文本
        [GWMProgressHUD showSuccessWithTitle:nil detail:nil images:nil toView:self.view];
    }else if (sender.tag==4){
        //这里也可以添加文本
        [GWMProgressHUD showFailWithTitle:@"网络错误" detail:nil images:nil toView:self.view];
    }else{
        //images传nil，会默认显示一个旋转的菊花
        [GWMProgressHUD showHUDWithTitle:@"Loading" detail:nil images:nil toView:self.view];
        //这里用定时器隐藏，实际使用时可以在需要的时候用[GWMProgressHUD hidHUDForView:self.view]隐藏掉
        NSTimer *timer=[NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(hidHUD) userInfo:nil repeats:NO];
    }
}
-(void)hidHUD
{
    [GWMProgressHUD hidHUDForView:self.view];
}

@end
