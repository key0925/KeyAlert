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
    
    _vwContent = [[UIView alloc] init];
    _vwContent.layer.cornerRadius = 10;
    _vwContent.clipsToBounds = YES;
    _vwContent.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_vwContent];
    
    _vwTop = [[UIView alloc] init];
    _vwTop.backgroundColor = [UIColor lightGrayColor];
    [_vwContent addSubview:_vwTop];
    
    _lbTitle = [[UILabel alloc] init];
    _lbTitle.textAlignment = NSTextAlignmentCenter;
    [_vwTop addSubview:_lbTitle];
    
    _imgTitle = [[UIImageView alloc] init];
    [_vwTop addSubview:_imgTitle];
    
    _lbContent = [[UILabel alloc] initWithFrame:CGRectMake(_contentLabelSpase.left,
                                                           _contentLabelSpase.top,
                                                           _popupSize.width - (_contentLabelSpase.left + _contentLabelSpase.right),
                                                           1)];
    _lbContent.lineBreakMode = NSLineBreakByWordWrapping;
    _lbContent.numberOfLines = 0;
    _lbContent.textAlignment = NSTextAlignmentCenter;
    
    _svwContent = [[UIScrollView alloc] init];
    _svwContent.backgroundColor = [UIColor whiteColor];
    _svwContent.showsVerticalScrollIndicator = NO;
    _svwContent.showsHorizontalScrollIndicator = NO;
    
    [_vwContent addSubview:_svwContent];
    [_svwContent addSubview:_lbContent];
    
    _vwBot = [[UIView alloc] init];
    [_vwContent addSubview:_vwBot];
    
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
    _lbContent.text = _message;
    [_lbContent sizeToFit];
    _lbContent.frame = CGRectMake(_contentLabelSpase.left,
                                  _contentLabelSpase.top,
                                  _popupSize.width - (_contentLabelSpase.left + _contentLabelSpase.right),
                                  _lbContent.frame.size.height);
    
    
    if(_lbContent.frame.size.height < _popupSize.mMaxHeight) {
        _svwContent.frame = CGRectMake(0,
                                       _popupSize.tHeight,
                                       _popupSize.width,
                                       _lbContent.frame.size.height + (_contentLabelSpase.top + _contentLabelSpase.bottom));
        _svwContent.scrollEnabled = NO;
        _svwContent.contentSize = CGSizeMake(_svwContent.frame.size.width,
                                             _svwContent.frame.size.height);
    }else{
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
            btn = [UIButton buttonWithType:UIButtonTypeCustom];
            btn.tag = cnt + 100;
            btn.layer.cornerRadius = 5;
            [btn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            btn.tintColor = [UIColor whiteColor];
            btn.backgroundColor = [UIColor colorWithRed:0.00 green:0.44 blue:1.00 alpha:1.0];
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
        [_vwBot addSubview:btn];
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
        [btn removeFromSuperview];
    }
    [buttons removeAllObjects];
    [self dismissViewControllerAnimated:NO completion:nil];
}
@end
