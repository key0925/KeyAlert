//
//  ViewController.swift
//  KeyAlert_swift
//
//  Created by KEY on 2018. 7. 6..
//  Copyright © 2018년 KEY. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func btnPress(_ sender: Any) {
        KeyAlert.shared.alertShow(message: "test", target: self, buttonTitles: ["ok"]) { (index, alertView) in
            print("button press")
            alertView.dismiss(animated: false, completion: nil)
        }
    }
    
}

