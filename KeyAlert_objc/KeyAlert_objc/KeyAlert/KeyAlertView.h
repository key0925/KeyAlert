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

@property (weak, nonatomic) IBOutlet UIView *vwContent;

//title
@property (weak, nonatomic) IBOutlet UIView *vwTop;
@property (weak, nonatomic) IBOutlet UILabel *lbTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgTitle;


@property (weak, nonatomic) IBOutlet UIScrollView *svwContent;
@property (weak, nonatomic) IBOutlet UILabel *lbContent;


@property (weak, nonatomic) IBOutlet UIView *vwBot;
@property (strong, nonatomic) IBOutlet UIView *vwArrCustomBtn;



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
