//
//  KeyAlert.swift
//  KeyAlert_swift
//
//  Created by KEY on 2018. 7. 6..
//  Copyright © 2018년 KEY. All rights reserved.
//

import UIKit

class KeyAlert {

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
    
    func moveCenterPosision(x:Float, y:Float) -> Void {
        <#function body#>
    }
}
