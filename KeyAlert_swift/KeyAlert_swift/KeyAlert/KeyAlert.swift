//
//  KeyAlert.swift
//  KeyAlert_swift
//
//  Created by KEY on 2018. 7. 6..
//  Copyright © 2018년 KEY. All rights reserved.
//

import UIKit

class KeyAlert {
    
    let default_Max_MsgLabel_width: CGFloat = UIScreen.main.bounds.size.width - 60
    let default_Max_MsgLabel_height: CGFloat = 30
    let default_MsgLabel_Horizontal_Space: CGFloat = 20
    let default_MsgLabel_vertical_Space: CGFloat = 5

    static let shared = KeyAlert()
    var alertView: KeyAlertView?
    
    init() {
        alertView = KeyAlertView(nibName: "KeyAlertView", bundle: nil)
    }
    
    func alertShow(message: String, target: UIViewController, buttonTitles:Array<String>, callBack: @escaping (Int, UIViewController) -> Swift.Void) -> Void {
        alertView?.message = message
        alertView?.buttonTitles = buttonTitles
        alertView?.CallBackBlock = callBack
        target.present(alertView!, animated: false, completion: nil)
    }
    
    func resetStruct() -> Void {
        alertView?.resetStruct()
    }
    
    func moveCenterPosision(x:CGFloat, y:CGFloat) -> Void {
        alertView?.moveCenterPosision(x: x, y: y)
    }
    
    func setPopupSize(width:CGFloat, tHeight:CGFloat, mMinHeight:CGFloat, mMaxHeight:CGFloat, bHeight:CGFloat) -> Void {
        alertView?.setPopupSize(width: width, tHeight: tHeight, mMinHeight: mMinHeight, mMaxHeight: mMaxHeight, bHeight: bHeight)
    }
    
    func setContentLabelSpase(top: CGFloat, left: CGFloat, bottom: CGFloat, right: CGFloat) -> Void {
        alertView?.setContentLabelSpase(top: top, left: left, bottom: bottom, right: right)
    }
    
    func setButtonSpase(btnTobtn: CGFloat, contentTobtn: CGFloat) -> Void {
        alertView?.setButtonSpase(btnTobtn: btnTobtn, contentTobtn: contentTobtn)
    }
    
    func toast(message: String, completed: @escaping () -> Swift.Void) -> Void {
        let window: UIWindow = UIApplication.shared.keyWindow!
        
        let lbMsg: UILabel = UILabel.init()
        
        lbMsg.lineBreakMode = .byWordWrapping
        lbMsg.numberOfLines = 0
        lbMsg.font = UIFont.systemFont(ofSize: 13)
        lbMsg.textColor = UIColor.white
        
        let maxSize: CGSize = CGSize(width: default_Max_MsgLabel_width,
                                     height: default_Max_MsgLabel_height)
        var expectedLabelRect = message.boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: lbMsg.font], context: nil)
        expectedLabelRect.origin.x = default_MsgLabel_Horizontal_Space
        expectedLabelRect.origin.y = default_MsgLabel_vertical_Space
        lbMsg.frame = expectedLabelRect
        lbMsg.text = message
        
        let lbMsg_Width = lbMsg.frame.size.width
        let toastPosisionX = (UIScreen.main.bounds.size.width - (lbMsg_Width + default_MsgLabel_Horizontal_Space * 2)) / 2
        let toastPosisionY = UIScreen.main.bounds.size.height - 80
        
        let toast: UIView = UIView(frame: CGRect(x: toastPosisionX,
                                                 y: UIScreen.main.bounds.size.height,
                                                 width: lbMsg_Width + default_MsgLabel_Horizontal_Space * 2,
                                                 height: lbMsg.frame.size.height + default_MsgLabel_vertical_Space * 2))
        toast.backgroundColor = UIColor.gray
        toast.layer.cornerRadius = 10
        
        toast.addSubview(lbMsg)
        window.addSubview(toast)
        
        UIView.animate(withDuration: 0.3, animations: {
            toast.frame = CGRect(x: toast.frame.origin.x,
                                 y: toastPosisionY,
                                 width: lbMsg_Width + 40,
                                 height: toast.frame.size.height)
            toast.alpha = 1
        }) { (finished) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    toast.frame = CGRect(x: toast.frame.origin.x,
                                         y: UIScreen.main.bounds.size.height,
                                         width: lbMsg_Width + 40,
                                         height: toast.frame.size.height)
                }, completion: { (finished) in
                    toast.removeFromSuperview()
                    completed()
                })
            })
        }
        
        
    }
}
