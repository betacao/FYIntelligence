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
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:superView animated:YES];
            hud.yOffset = -50;
            [superView bringSubviewToFront:hud];
            hud.mode = MBProgressHUDModeIndeterminate;
            hud.labelText = message;
            [hud adjustFontToWidth];
            hud.removeFromSuperViewOnHide = YES;
            [hud hide:YES afterDelay:12.0f];
        } else{
            [self performSelectorOnMainThread:@selector(showHudWithMessage:) withObject:message waitUntilDone:YES];
        }
    }
}


+ (void)showHudWithMessage:(NSString *)message
{
    UIView *view = [AppDelegate currentAppdelegate].window;
    MBProgressHUD  *HUD = [[MBProgressHUD alloc] initWithView:view];
    HUD.yOffset = -50;
    [view addSubview:HUD];
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.labelText = message;
    [HUD show:YES];
}

+ (void)showMessageWithText:(NSString *)text
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIView *view = [AppDelegate currentAppdelegate].window;
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
        hud.yOffset = -50;

        [view bringSubviewToFront:hud];
        hud.mode = MBProgressHUDModeText;
        hud.labelText = text;
        hud.removeFromSuperViewOnHide = YES;
        [hud hide:YES afterDelay:1.2];
    });
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
    UIView *superView = [AppDelegate currentAppdelegate].window;
    for (UIView *subView in superView.subviews) {
        if ([subView isKindOfClass:[MBProgressHUD class]]){
            [subView removeFromSuperview];
        }
    }
}


@end
