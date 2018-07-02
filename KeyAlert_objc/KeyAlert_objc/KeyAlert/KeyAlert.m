//
//  KeyAlert.m
//  KeyAlert_objc
//
//  Created by KEY on 2018. 6. 14..
//  Copyright © 2018년 KEY. All rights reserved.
//  commit test

#import "KeyAlert.h"

@implementation KeyAlert
@synthesize alertView;

+ (KeyAlert *)shared {
    static KeyAlert *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{    //라이프 사이클간 일회 실행
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

- (instancetype)init {
    if (self = [super init]) {
        alertView = [[KeyAlertView alloc] initWithNibName:@"KeyAlertView" bundle:nil];
    }
    return self;
}


+ (void)alertShowWithMessage:(nullable NSString *)message
                      target:(nonnull UIViewController *)target
                buttonTitles:(nullable NSArray *)buttonTitles
                    callBack:(nullable CallBackBlock)callBack {
    
    [self shared].alertView.message       = message;
    [self shared].alertView.buttonTitles  = buttonTitles;
    [self shared].alertView.callBackBlock = callBack;
    
    [self shared].alertView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [target presentViewController:[self shared].alertView animated:NO completion:nil];
    
}

+ (void)moveCenterPosision_x:(float)x
                           y:(float)y {
    
    [[self shared].alertView moveCenterPosision_x:x y:y];
    
}


+ (void)setPopupSize_width:(float)width
                   tHeight:(float)tHeight
                mMinHeight:(float)mMinHeight
                mMaxHeight:(float)mMaxHeight
                   bHeight:(float)bHeight {
    
    [[self shared].alertView setPopupSize_width:width
                                        tHeight:tHeight
                                     mMinHeight:mMinHeight
                                     mMaxHeight:mMaxHeight
                                        bHeight:bHeight];
    
}

+ (void)setContentLabelSpase_top:(float)top
                            left:(float)left
                          bottom:(float)bottom
                           right:(float)right {
    
    [[self shared].alertView setContentLabelSpase_top:top
                                                 left:left
                                               bottom:bottom
                                                right:right];
    
}

+ (void)setButtonSpase_btnTobtn:(float)btnTobtn
                   contentTobtn:(float)contentTobtn {
    
    [[self shared].alertView setButtonSpase_btnTobtn:btnTobtn
                                        contentTobtn:contentTobtn];
    
}

+ (void)resetStruct {
    [[self shared].alertView resetStruct];
}
@end
