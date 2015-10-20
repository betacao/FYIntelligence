//
//  FYProgressHUD.m
//  FYIntelligence
//
//  Created by changxicao on 15/10/20.
//  Copyright © 2015年 changxicao. All rights reserved.
//

#import "FYProgressHUD.h"
#import "MBProgressHUD.h"

@implementation FYProgressHUD

+ (void)showLoadingWithMessage:(NSString *)message{

    BOOL hasShow = NO;
    UIView *superView = [AppDelegate currentAppdelegate].window;

    for (UIView *subView in superView.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]) {
            hasShow = YES;
        }
    }

    if (!hasShow) {
        if ([NSThread currentThread].isMainThread) {
            UIViewController *controller = [AppDelegate currentAppdelegate].window.rootViewController;
            if ([controller isKindOfClass:[UINavigationController class]]) {
                UINavigationController *nav = (UINavigationController *)[AppDelegate currentAppdelegate].window.rootViewController;
                UIViewController *topController = [nav.viewControllers lastObject];
                controller = topController;
            }
            MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:controller.view];
            HUD.yOffset = -50;
            [controller.view addSubview:HUD];
            HUD.mode = MBProgressHUDModeIndeterminate;
            HUD.labelText = message;
            [HUD show:YES];
        } else{
            [self performSelectorOnMainThread:@selector(showHudWithMessage:) withObject:message waitUntilDone:YES];
        }
    }
}

- (void)showHudWithMessage:(NSString *)message
{
    if ([[AppDelegate currentAppdelegate].window.rootViewController isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)[AppDelegate currentAppdelegate].window.rootViewController;
        UIViewController *topView = [nav.viewControllers lastObject];
        MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:topView.view];
        HUD.yOffset = -50;
        [topView.view addSubview:HUD];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = message;
        [HUD show:YES];
    }
}

+ (void)showMessageWithText:(NSString *)text
{
    UIView *view = [AppDelegate currentAppdelegate].window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.yOffset = -50;

    [view bringSubviewToFront:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.2];
}

+ (void)showMessageWithLongText:(NSString *)text
{
    UIView *view = [AppDelegate currentAppdelegate].window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.yOffset = -50;

    [view bringSubviewToFront:hud];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = text;
    [hud adjustFontToWidth];
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.2];
}

+ (void)hideHud
{
    if ([NSThread currentThread].isMainThread) {
        [self hidesHud];
    } else{
        [self performSelectorOnMainThread:@selector(hidesHud) withObject:nil waitUntilDone:NO];
    }
}

+ (void)hidesHud
{
    UIViewController *controller = [AppDelegate currentAppdelegate].window.rootViewController;
    if ([controller isKindOfClass:[UINavigationController class]]){
        UINavigationController *nav = (UINavigationController *)[AppDelegate currentAppdelegate].window.rootViewController;
        UIViewController *topController = [nav.viewControllers lastObject];
        controller = topController;
    }
    for (UIView *subView in controller.view.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]){
            [subView removeFromSuperview];
        }
    }
}


@end
