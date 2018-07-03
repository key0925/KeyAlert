//
//  KeyAlert.h
//  KeyAlert_objc
//
//  Created by KEY on 2018. 6. 14..
//  Copyright © 2018년 KEY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KeyAlertView.h"

@interface KeyAlert : NSObject

@property (nonatomic, strong)KeyAlertView *alertView;

typedef void (^ToastCompleted)(void);

+ (void)alertShowWithMessage:(nullable NSString *)message
                      target:(nonnull UIViewController *)target
                buttonTitles:(nullable NSArray *)buttonTitles
                    callBack:(nullable CallBackBlock)callBack;

+ (void)moveCenterPosision_x:(float)x
                           y:(float)y;

+ (void)setPopupSize_width:(float)width
                   tHeight:(float)tHeight
                mMinHeight:(float)mMinHeight
                mMaxHeight:(float)mMaxHeight
                   bHeight:(float)bHeight;

+ (void)setContentLabelSpase_top:(float)top
                            left:(float)left
                          bottom:(float)bottom
                           right:(float)right;

+ (void)setButtonSpase_btnTobtn:(float)btnTobtn
                   contentTobtn:(float)contentTobtn;

+ (void)resetStruct;


+ (void)toastWithMessage:(nullable NSString *)message
               completed:(nullable ToastCompleted)completed;
@end
