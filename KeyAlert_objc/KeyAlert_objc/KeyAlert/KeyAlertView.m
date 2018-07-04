//
//  KeyAlertView.m
//  KeyAlert_objc
//
//  Created by KEY on 2018. 6. 14..
//  Copyright © 2018년 KEY. All rights reserved.
//

#import "KeyAlertView.h"

#define default_title_string    [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleDisplayName"]
#define default_title_imageName @""

#define default_width           [UIScreen mainScreen].bounds.size.width - 60
#define default_top_height      40
#define default_mid_min_height  50
#define default_mid_max_height  [UIScreen mainScreen].bounds.size.height - 200
#define default_bot_height      48

#define default_content_space_top     8
#define default_content_space_left    8
#define default_content_space_bottom  8
#define default_content_space_right   8

#define default_btnTobtn_space       4
#define default_contentTobtn_space   8


@interface KeyAlertView ()

@end

@implementation KeyAlertView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //구조체 초기화
    [self resetStruct];
    
    //뷰 생성
    [self viewInitialized];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OrientationDidChange:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self setViewFrame];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)OrientationDidChange:(NSNotification *)noti {
    NSLog(@"OrientationDidChange");
    [self resetStruct];
    [self setViewFrame];
    if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation)){
        NSLog(@"Land");
    }else{
        NSLog(@"Port");
    }
}


#pragma mark - Setting View
- (void)resetStruct {
    
    [self moveCenterPosision_x:0
                             y:0];
    
    [self setPopupSize_width:default_width
                     tHeight:default_top_height
                  mMinHeight:default_mid_min_height
                  mMaxHeight:default_mid_max_height
                     bHeight:default_bot_height];
    
    [self setContentLabelSpase_top:default_content_space_top
                              left:default_content_space_left
                            bottom:default_content_space_bottom
                             right:default_content_space_right];
    
    [self setButtonSpase_btnTobtn:default_btnTobtn_space
                     contentTobtn:default_contentTobtn_space];
    
}
- (void)moveCenterPosision_x:(float)x
                           y:(float)y {
    
    _moveCenterPosision.x = x;
    _moveCenterPosision.y = y;
    
}

- (void)setPopupSize_width:(float)width
                   tHeight:(float)tHeight
                mMinHeight:(float)mMinHeight
                mMaxHeight:(float)mMaxHeight
                   bHeight:(float)bHeight {
    
    _popupSize.width        = width;
    _popupSize.tHeight      = tHeight;
    _popupSize.mMinHeight   = mMinHeight;
    _popupSize.mMaxHeight   = mMaxHeight;
    _popupSize.bHeight      = bHeight;
    
}

- (void)setContentLabelSpase_top:(float)top
                            left:(float)left
                          bottom:(float)bottom
                           right:(float)right {
    
    _contentLabelSpase.top      = top;
    _contentLabelSpase.left     = left;
    _contentLabelSpase.bottom   = bottom;
    _contentLabelSpase.right    = right;
    
}

- (void)setButtonSpase_btnTobtn:(float)btnTobtn
                   contentTobtn:(float)contentTobtn {
    
    _buttonSpase.btnTobtn     = btnTobtn;
    _buttonSpase.contentTobtn = contentTobtn;
    
}

- (void)viewInitialized {
    
    _vwContent.layer.cornerRadius = 10;
    
    buttons = [NSMutableArray new];
}

- (void)setViewFrame {
    
    //top
    _vwTop.frame =  CGRectMake(0,
                               0,
                               _popupSize.width,
                               _popupSize.tHeight);
    
    
    _lbTitle.frame = _vwTop.bounds;
    _lbTitle.text = default_title_string;
    
    _imgTitle.frame = _vwTop.bounds;
    _imgTitle.image = [UIImage imageNamed:default_title_imageName];
    
    //mid
    
    CGSize maxSize = CGSizeMake(_popupSize.width - (_contentLabelSpase.left + _contentLabelSpase.right), _popupSize.mMaxHeight);
    CGRect expectedLabelRect = [_message boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName:_lbContent.font } context:nil];
    expectedLabelRect.origin.x = _contentLabelSpase.left;
    expectedLabelRect.origin.y = _contentLabelSpase.top;
    _lbContent.frame = expectedLabelRect;
    _lbContent.text = _message;
    [_lbContent sizeToFit];
    
    if(_lbContent.frame.size.height < _popupSize.mMaxHeight) {
        _svwContent.frame = CGRectMake(0,
                                       _popupSize.tHeight,
                                       _popupSize.width,
                                       _lbContent.frame.size.height + (_contentLabelSpase.top + _contentLabelSpase.bottom));
        _svwContent.scrollEnabled = NO;
        _svwContent.contentSize = CGSizeMake(_svwContent.frame.size.width,
                                             _svwContent.frame.size.height);
    }
    else{
        _svwContent.frame = CGRectMake(0,
                                       _popupSize.tHeight,
                                       _popupSize.width,
                                       _popupSize.mMaxHeight);
        _svwContent.scrollEnabled = YES;
        _svwContent.contentSize = CGSizeMake(_svwContent.frame.size.width,
                                             _lbContent.frame.size.height + (_contentLabelSpase.top + _contentLabelSpase.bottom));
    }
    
    
    //bottom
    
    NSUInteger btnCnt = _buttonTitles.count; //버튼 갯수
    float realBtnH = _popupSize.bHeight - _buttonSpase.contentTobtn; //실제 버튼 높이
    float realBtnW = 0; //실제 버튼 넓이
    
    if(btnCnt < 3) {
        realBtnW = (_popupSize.width - (_buttonSpase.contentTobtn * 2 + _buttonSpase.btnTobtn * (btnCnt - 1))) / btnCnt;
        _vwBot.frame = CGRectMake(0,
                                  _popupSize.tHeight + _svwContent.frame.size.height,
                                  _popupSize.width,
                                  _popupSize.bHeight);
    }else{
        realBtnW = _popupSize.width - (_buttonSpase.contentTobtn * 2);
        _vwBot.frame = CGRectMake(0,
                                  _popupSize.tHeight + _svwContent.frame.size.height,
                                  _popupSize.width,
                                  (realBtnH + _buttonSpase.btnTobtn) * (btnCnt - 1) + _popupSize.bHeight);
    }
    
    
    int cnt = 0;
    
    for(NSString * btnTitle in _buttonTitles){
        
        UIButton *btn = (UIButton *)[self.view viewWithTag:cnt + 100];
        if(btn == nil){
            btn = (UIButton *)[_vwArrCustomBtn viewWithTag:cnt + 100];
            
            btn.tag = cnt + 100;
            btn.layer.cornerRadius = 5;
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            
            [_vwBot addSubview:btn];
        }
        [btn setTitle:btnTitle forState:UIControlStateNormal];
        
        if(btnCnt < 3) {
            btn.frame = CGRectMake(_buttonSpase.contentTobtn + (realBtnW + _buttonSpase.btnTobtn) * cnt,
                                   0,
                                   realBtnW,
                                   realBtnH);
        }else{
            btn.frame = CGRectMake(_buttonSpase.contentTobtn,
                                   (realBtnH + _buttonSpase.btnTobtn) * cnt,
                                   realBtnW,
                                   realBtnH);
        }
        cnt++;
        [buttons addObject:btn];
    }
    
    _vwContent.frame = CGRectMake(([UIScreen mainScreen].bounds.size.width - _popupSize.width)/2 + _moveCenterPosision.x,
                                  ([UIScreen mainScreen].bounds.size.height - (_popupSize.tHeight + _svwContent.frame.size.height + _vwBot.frame.size.height))/2 + _moveCenterPosision.y,
                                  _popupSize.width,
                                  _popupSize.tHeight + _svwContent.frame.size.height + _vwBot.frame.size.height);
}

- (void)btnPress:(UIButton *)btn {
    if(_callBackBlock == nil){
        [self dismissViewControllerAnimated:NO completion:nil];
    }else{
        _callBackBlock(btn.tag - 100, self);
    }
}

- (void)dismissViewController {
    for (UIButton *btn in buttons){
        btn.frame = CGRectZero;
    }
    [buttons removeAllObjects];
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
