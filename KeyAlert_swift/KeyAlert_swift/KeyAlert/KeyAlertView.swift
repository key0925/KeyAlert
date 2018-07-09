//
//  KeyAlertView.swift
//  KeyAlert_swift
//
//  Created by KEY on 2018. 7. 6..
//  Copyright © 2018년 KEY. All rights reserved.
//

import UIKit

class KeyAlertView: UIViewController {

    public var message: String = ""
    public var buttonTitles: Array<String>?
    
    public var CallBackBlock: ((Int, UIViewController) -> Void)?
    
    
    @IBOutlet weak var vwContent: UIView!
    
    @IBOutlet weak var vwTop: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var imgTitle: UIImageView!
    
    @IBOutlet weak var svwContent: UIScrollView!
    @IBOutlet weak var lbContent: UILabel!
    
    @IBOutlet weak var vwBot: UIView!
    @IBOutlet var vwArrCustomBtn: UIView!
    
    
    
    let default_title_string: String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as! String
    let default_title_imageName: String = ""
    
    let default_width: CGFloat          = UIScreen.main.bounds.size.width - 60
    let default_top_height: CGFloat     = 40
    let default_mid_min_height: CGFloat = 50
    let default_mid_max_height: CGFloat = UIScreen.main.bounds.size.height - 200
    let default_bot_height: CGFloat     = 48
    
    let default_content_space_top: CGFloat    = 8
    let default_content_space_left: CGFloat   = 8
    let default_content_space_bottom: CGFloat = 8
    let default_content_space_right: CGFloat  = 8
    
    let default_btnTobtn_space: CGFloat = 4
    let default_contentTobtn_space: CGFloat = 8
    
    
    
    var buttons: Array<UIButton>?
    
    
    
    
    struct MoveCenterPosision {
        var x: CGFloat, y: CGFloat
    }
    var moveCenterPosision: MoveCenterPosision = MoveCenterPosision.init(x: 0, y: 0)
    
    struct PopupSize {
        var width: CGFloat, tHeight: CGFloat, mMinHeight: CGFloat, mMaxHeight: CGFloat, bHeight: CGFloat
    }
    var popupSize: PopupSize = PopupSize.init(width: 0,
                                              tHeight: 0,
                                              mMinHeight: 0,
                                              mMaxHeight: 0,
                                              bHeight: 0)
    
    struct ContentLabelSpase {
        var top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat
    }
    var contentLabelSpase: ContentLabelSpase = ContentLabelSpase.init(top: 0,
                                                                      left: 0,
                                                                      bottom: 0,
                                                                      right: 0)
    
    struct ButtonSpase {
        var btnTobtn: CGFloat, contentTobtn: CGFloat
    }
    var buttonSpase: ButtonSpase = ButtonSpase.init(btnTobtn: 0,
                                                    contentTobtn: 0)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.resetStruct()
        self.viewInitialized()
        
        NotificationCenter.default.addObserver(self, selector: #selector(OrientationDidChange(noti:)), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setViewFrame()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc func OrientationDidChange(noti:Notification) -> Void {
        self.resetStruct()
        self.setViewFrame()
    }
    
    func resetStruct() -> Void {
        self.moveCenterPosision(x: 0, y: 0)
        
        self.setPopupSize(width: default_width,
                          tHeight: default_top_height,
                          mMinHeight: default_mid_min_height,
                          mMaxHeight: default_mid_max_height,
                          bHeight: default_bot_height)
        
        self.setContentLabelSpase(top: default_content_space_top,
                                  left: default_content_space_left,
                                  bottom: default_content_space_bottom,
                                  right: default_content_space_right)
        
        self.setButtonSpase(btnTobtn: default_btnTobtn_space,
                            contentTobtn: default_contentTobtn_space)
    }
    
    func moveCenterPosision(x: CGFloat, y: CGFloat) -> Void {
        moveCenterPosision.x = x
        moveCenterPosision.y = y
    }
    
    func setPopupSize(width:CGFloat, tHeight:CGFloat, mMinHeight:CGFloat, mMaxHeight:CGFloat, bHeight:CGFloat) -> Void {
        popupSize.width      = width
        popupSize.tHeight    = tHeight
        popupSize.mMinHeight = mMinHeight
        popupSize.mMaxHeight = mMaxHeight
        popupSize.bHeight    = bHeight
    }
    
    func setContentLabelSpase(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Void {
        contentLabelSpase.top    = top
        contentLabelSpase.left   = left
        contentLabelSpase.bottom = bottom
        contentLabelSpase.right  = right
    }
    
    func setButtonSpase(btnTobtn: CGFloat, contentTobtn: CGFloat) -> Void {
        buttonSpase.btnTobtn     = btnTobtn
        buttonSpase.contentTobtn = contentTobtn
    }
    
    func viewInitialized() -> Void {
        
        vwContent.layer.cornerRadius = 10;
        
    }
    func setViewFrame() -> Void {
        //top
        vwTop.frame = CGRect(x: 0,
                             y: 0,
                             width: popupSize.width,
                             height: popupSize.tHeight)
        
        lbTitle.frame = vwTop.bounds
        lbTitle.text = default_title_string
        imgTitle.frame = vwTop.bounds
        imgTitle.image = UIImage(named: default_title_imageName)
        
        
        //mid
        
        let maxSize: CGSize = CGSize(width: popupSize.width - (contentLabelSpase.left + contentLabelSpase.right),
                                     height: popupSize.mMaxHeight)
        var expectedLabelRect = message.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: lbContent.font], context: nil)
        expectedLabelRect.origin.x = contentLabelSpase.left
        expectedLabelRect.origin.y = contentLabelSpase.top
        expectedLabelRect.size.width = popupSize.width - (contentLabelSpase.left + contentLabelSpase.right)
        lbContent.frame = expectedLabelRect
        lbContent.text = message
        
        if lbContent.frame.size.height < popupSize.mMaxHeight {
            svwContent.frame = CGRect(x: 0,
                                      y: popupSize.tHeight,
                                      width: popupSize.width,
                                      height: lbContent.frame.size.height + (contentLabelSpase.top + contentLabelSpase.bottom))
            svwContent.isScrollEnabled = false
            svwContent.contentSize = CGSize(width: svwContent.frame.size.width,
                                            height: svwContent.frame.size.height)
        }
        else {
            svwContent.frame = CGRect(x: 0,
                                      y: popupSize.tHeight,
                                      width: popupSize.width,
                                      height: popupSize.mMaxHeight)
            svwContent.isScrollEnabled = true
            svwContent.contentSize = CGSize(width: svwContent.frame.size.width,
                                            height: lbContent.frame.size.height + (contentLabelSpase.top + contentLabelSpase.bottom))
        }
        
        
        //bottom
        var btnCnt: CGFloat = CGFloat((buttonTitles?.count)!)    //버튼 갯수
        if btnCnt == 0 {
            btnCnt = 1
        }
        
        let realBtnH: CGFloat = popupSize.bHeight - buttonSpase.contentTobtn //실제 버튼 높이
        var realBtnW: CGFloat = 0 //실제 버튼 넓이
        
        if btnCnt < 3 {
            realBtnW = (popupSize.width - (buttonSpase.contentTobtn * 2 + buttonSpase.btnTobtn * (btnCnt - 1))) / btnCnt
            vwBot.frame = CGRect(x: 0,
                                 y: popupSize.tHeight + svwContent.frame.size.height,
                                 width: popupSize.width,
                                 height: popupSize.bHeight)
        }
        else {
            realBtnW = popupSize.width - (buttonSpase.contentTobtn * 2)
            vwBot.frame = CGRect(x: 0,
                                 y: popupSize.tHeight + svwContent.frame.size.height,
                                 width: popupSize.width,
                                 height: (realBtnH + buttonSpase.btnTobtn) * (btnCnt - 1) + popupSize.bHeight)
        }

        var cnt: CGFloat = 0

        for btnTitle in buttonTitles! {
            var btn: UIButton? = self.view.viewWithTag(Int(cnt + 100)) as? UIButton
            if btn == nil {
                btn = vwArrCustomBtn.viewWithTag(Int(cnt + 100)) as? UIButton
                btn?.tag = Int(cnt + 100)
                btn?.layer.cornerRadius = 5
                btn?.addTarget(self, action:#selector(btnPress(btn:)), for: .touchUpInside)
                vwBot.addSubview(btn!)
            }
            btn?.setTitle(btnTitle, for: .normal)

            if btnCnt < 3 {
                btn?.frame = CGRect(x: buttonSpase.contentTobtn + (realBtnW + buttonSpase.btnTobtn) * cnt,
                                    y: 0,
                                    width: realBtnW,
                                    height: realBtnH)
            }else{
                btn?.frame = CGRect(x:buttonSpase.contentTobtn,
                                    y: (realBtnH + buttonSpase.btnTobtn) * cnt,
                                    width: realBtnW,
                                    height: realBtnH)
            }
            buttons?.insert(btn!, at: Int(cnt))
            cnt = cnt + 1;
        }


        vwContent.frame = CGRect(x: (UIScreen.main.bounds.size.width - popupSize.width)/2 + moveCenterPosision.x,
                                 y: (UIScreen.main.bounds.size.height - (popupSize.tHeight + svwContent.frame.size.height + vwBot.frame.size.height))/2 + moveCenterPosision.y,
                                 width: popupSize.width,
                                 height: popupSize.tHeight + svwContent.frame.size.height + vwBot.frame.size.height)
    }

    @objc func btnPress (btn: UIButton) -> Void {
        if CallBackBlock != nil {
            CallBackBlock!(btn.tag, self)
        }else {
            self.dismissViewController()
        }
    }
    
    func dismissViewController() -> Void {
        for btn in buttons! {
            btn.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        buttons?.removeAll()
        self.dismiss(animated: false, completion: nil)
    }

}
