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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func btnTestPress(_ sender: Any) {
        CallBackBlock!(0,self)
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
}
