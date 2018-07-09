//
//  KeyAlert.m
//  KeyAlert_objc
//
//  Created by KEY on 2018. 6. 14..
//  Copyright © 2018년 KEY. All rights reserved.
//  commit test

#import "KeyAlert.h"

#define default_Max_MsgLabel_width          [UIScreen mainScreen].bounds.size.width - 60
#define default_Max_MsgLabel_height         30
#define default_MsgLabel_Horizontal_Space   20
#define default_MsgLabel_vertical_Space     5

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
                buttonTitles:(nonnull NSArray *)buttonTitles
                    callBack:(nullable CallBackBlock)callBack {
    
    [self shared].alertView.message       = message;
    [self shared].alertView.buttonTitles  = buttonTitles;
    [self shared].alertView.callBackBlock = callBack;
    
    [self shared].alertView.modalPresentationStyle = UIModalPresentationOverCurrentContext;
    [target presentViewController:[self shared].alertView animated:NO completion:nil];
    
}

+ (void)toastWithMessage:(nullable NSString *)message
               completed:(nullable ToastCompleted)completed {
    
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    
    UILabel *lbMsg = [[UILabel alloc] init];
    
    lbMsg.lineBreakMode = NSLineBreakByWordWrapping;
    lbMsg.numberOfLines = 0;
    lbMsg.font = [UIFont systemFontOfSize:13];
    lbMsg.textColor = [UIColor whiteColor];
    
    CGSize maxSize = CGSizeMake(default_Max_MsgLabel_width, default_Max_MsgLabel_height);
    CGRect expectedLabelRect = [message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:lbMsg.font } context:nil];
    expectedLabelRect.origin.x = default_MsgLabel_Horizontal_Space;
    expectedLabelRect.origin.y = default_MsgLabel_vertical_Space;
    lbMsg.frame = expectedLabelRect;
    lbMsg.text = message;
    
    float lbMsg_Width = lbMsg.frame.size.width;
    
    float toastPosisionX = ([UIScreen mainScreen].bounds.size.width - (lbMsg_Width + default_MsgLabel_Horizontal_Space * 2))/2;
    
    float toastPosisionY = [UIScreen mainScreen].bounds.size.height - 80;
    
    
    
    UIView *toast = [[UIView alloc] initWithFrame:CGRectMake(toastPosisionX,
                                                             [UIScreen mainScreen].bounds.size.height,
                                                             lbMsg_Width + default_MsgLabel_Horizontal_Space * 2,
                                                             lbMsg.frame.size.height + default_MsgLabel_vertical_Space * 2)];

    toast.backgroundColor = [UIColor grayColor];
    toast.layer.cornerRadius = 10;
    
    [toast addSubview:lbMsg];
    [window addSubview:toast];
    
    [UIView animateWithDuration:0.3 animations:^{
        toast.frame = CGRectMake(toast.frame.origin.x,
                                 toastPosisionY,
                                 lbMsg_Width + 40,
                                 toast.frame.size.height);
        toast.alpha = 1;
    } completion:^(BOOL finished){
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.3 animations:^{
                toast.frame = CGRectMake(toast.frame.origin.x,
                                         [UIScreen mainScreen].bounds.size.height,
                                         lbMsg_Width + 40,
                                         toast.frame.size.height);
                toast.alpha = 0;
            } completion:^(BOOL finished){
                [toast removeFromSuperview];
                if(completed)completed();
            }];
        });
    }];
    
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
