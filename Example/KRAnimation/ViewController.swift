//
//  ViewController.swift
//  KRAnimation
//
//  Created by Joshua Park on 06/15/2016.
//  Copyright (c) 2016 Joshua Park. All rights reserved.
//

import UIKit
import KRAnimation

var START: NSDate!

class ViewController: UIViewController {
    
    @IBOutlet weak var viewBox: UIView!
    
    let beginFrame = CGRectMake(0.0, 0.0, 50, 50)
    let endFrame = CGRectMake(Screen.bounds.width - 100.0, 0.0, 100.0, 100.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animation(sender: AnyObject) {
        viewBox.after(2.0).animateX(Screen.bounds.width - 50.0, duration: 3, function: .Linear) {
            self.viewBox.after(1.5).chainX(0.0, duration: 3.0, function: .Linear) {
                self.viewBox.chainX(Screen.bounds.width - 50.0, duration: 3.0, function: .EaseOutCubic) {
                    self.viewBox.chainX(0.0, duration: 3, function: .EaseInCubic) {
                        self.viewBox.after(1.0).chainX(Screen.bounds.width / 2.0 - 25.0, duration: 3.0, function: .EaseOutCubic)
                    }
                }
            }
        }
    }

    @IBAction func defaultAnimation(sender: AnyObject) {
        START = NSDate()

        UIView.animateWithDuration(3.0, animations: {
            self.viewBox.frame = self.endFrame
            }, completion: { (_) in
                print("UIVIEW", NSDate().timeIntervalSinceDate(START))
                print(self.viewBox.frame)
                self.viewBox.frame = self.beginFrame
        })
    }
    
    @IBAction func stopAction(sender: AnyObject) {
        viewBox.layer.removeAllAnimations()
    }
}