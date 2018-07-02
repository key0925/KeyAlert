//
//  KeyAlertView.h
//  KeyAlert_objc
//
//  Created by KEY on 2018. 6. 14..
//  Copyright © 2018년 KEY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KeyAlertView : UIViewController
{
    NSMutableArray *buttons;
}
typedef void (^CallBackBlock)(NSUInteger, KeyAlertView *);
@property (nonatomic, strong) CallBackBlock callBackBlock;

@property (nonatomic, retain) NSString *message;
@property (nonatomic, retain) NSArray *buttonTitles;

@property (nonatomic, strong) UIView *vwContent;

//title
@property (nonatomic, strong) UIView *vwTop;
@property (nonatomic, strong) UILabel *lbTitle;
@property (nonatomic, strong) UIImageView *imgTitle;


@property (nonatomic, strong) UIScrollView *svwContent;
@property (nonatomic, strong) UILabel *lbContent;


@property (nonatomic, strong) UIView *vwBot;



@property (nonatomic, assign) struct MoveCenterPosision moveCenterPosision;
struct MoveCenterPosision {
    float x, y;
};

@property (nonatomic, assign) struct PopupSize popupSize;
struct PopupSize {
    float width, tHeight, mMinHeight, mMaxHeight, bHeight;
};

@property (nonatomic, assign) struct ContentLabelSpase contentLabelSpase;
struct ContentLabelSpase {
    float top, left, bottom, right;
};

@property (nonatomic, assign) struct ButtonSpase buttonSpase;
struct ButtonSpase {
    float btnTobtn, contentTobtn;
};

- (void)dismissViewController;

- (void)moveCenterPosision_x:(float)x
                           y:(float)y;

- (void)setPopupSize_width:(float)width
                   tHeight:(float)tHeight
                mMinHeight:(float)mMinHeight
                mMaxHeight:(float)mMaxHeight
                   bHeight:(float)bHeight;

- (void)setContentLabelSpase_top:(float)top
                            left:(float)left
                          bottom:(float)bottom
                           right:(float)right;

- (void)setButtonSpase_btnTobtn:(float)btnTobtn
                   contentTobtn:(float)contentTobtn;

- (void)resetStruct;

@end
