//
//  ViewController.swift
//  KRAnimationKit
//
//  Created by Joshua Park on 06/15/2016.
//  Copyright (c) 2016 Joshua Park. All rights reserved.
//

import UIKit
import KRAnimationKit
import KRTimingFunction

class ViewController: UIViewController {
    
    @IBOutlet weak var viewBox: UIView!
    @IBOutlet weak var viewBox2: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func animation(sender: AnyObject) {
        let bottomY = Screen.bounds.height - 50.0
        
        KRAnimation.chain(
            viewBox.chainY(bottomY, duration: 1.0, function: .Linear),
            viewBox.chainY(0.0, duration: 1.0, function: .Linear),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInSine),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutSine),
            viewBox2.chainY(bottomY, duration: 1.0, function: .EaseInOutSine),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInQuad),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutQuad),
            viewBox2.chainY(58.0, duration: 1.0, function: .EaseInOutQuad),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInCubic),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutCubic),
            viewBox2.chainY(bottomY, duration: 1.0, function: .EaseInOutCubic),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInQuart),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutQuart),
            viewBox2.chainY(58.0, duration: 1.0, function: .EaseInOutQuart),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInQuint),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutQuint),
            viewBox2.chainY(bottomY, duration: 1.0, function: .EaseInOutQuint),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInExpo),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutExpo),
            viewBox2.chainY(58.0, duration: 1.0, function: .EaseInOutExpo),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInCirc),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutCirc),
            viewBox2.chainY(bottomY, duration: 1.0, function: .EaseInOutCirc),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInElastic),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutElastic),
            viewBox2.chainY(58.0, duration: 1.0, function: .EaseInOutElastic),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInBack),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutBack),
            viewBox2.chainY(bottomY, duration: 1.0, function: .EaseInOutBack),
            
            viewBox.chainY(bottomY, duration: 1.0, function: .EaseInBounce),
            viewBox.chainY(0.0, duration: 1.0, function: .EaseOutBounce),
            viewBox2.chainY(58.0, duration: 1.0, function: .EaseInOutBounce),
            
            reverses: false, repeatCount: 1
        ) {
            print("COMPLETION")
        }
    }

    @IBAction func defaultAnimation(sender: AnyObject) {
        viewBox.center = view.center
        viewBox2.center = view.center
        viewBox2.center.y += 108.0
        viewBox2.layer.transform = CATransform3DMakeRotation(CGFloat(45 * M_PI / 180.0), 0.0, 0.0, 1.0)
        
        let anim = CAKeyframeAnimation(keyPath: "transform")
        let duration = 1.0
        let totalFrames = 60 * duration
        let b = viewBox.layer.transform

        var values = [AnyObject]()
        let deg = CGFloat(360.0 * M_PI / 180.0)
        
        for i in 0 ... Int(totalFrames) {
            let rt = Double(i)/totalFrames
            var e = b
            let scale = CGFloat(TimingFunction.EaseOutCubic(rt: rt, b: 0.0, c: 1.0))
            let m11 = cos(deg * scale)
            let m12 = sin(deg * scale)
            let m21 = -sin(deg * scale)
            let m22 = cos(deg * scale)
            e.m11 = m11
            e.m12 = m12
            e.m21 = m21
            e.m22 = m22
            
            values.append(NSValue(CATransform3D: e))
        }
        
        anim.values = values
        anim.duration = duration
        anim.fillMode = kCAFillModeForwards
        anim.removedOnCompletion = false
        
        viewBox.layer.addAnimation(anim, forKey: nil)
    }
    
    @IBAction func multiAnimation(sender: AnyObject) {
        KRAnimation.chain(
            viewBox.chainX(Screen.bounds.width - 50.0, duration: 1.0, function: .EaseOutCubic) + viewBox.chainBackgroundColor(UIColor.blueColor(), duration: 1.0) + viewBox2.chainAlpha(0.5, duration: 1.0) + viewBox2.chainBackgroundColor(UIColor.cyanColor(), duration: 1.0),
            viewBox.after(0.5).chainY(Screen.bounds.height - 50.0, duration: 1.0, function: .EaseInCubic) + viewBox2.after(0.5).chainCenter(view.center, duration: 1.0),
            viewBox.chainX(0.0, duration: 1.0, function: .EaseInOutCubic) + viewBox.chainBackgroundColor(UIColor.redColor(), duration: 1.0),
            viewBox.chainY(0.0, duration: 1.0),
            viewBox.chainOrigin(CGPointMake(Screen.bounds.width - 50.0, Screen.bounds.height - 50.0), duration: 1.0, function: .EaseInCubic),
            viewBox.chainOrigin(CGPointZero, duration: 1.0, function: .EaseOutCubic),
            viewBox.chainCenter(view.center, duration: 1.0),
            viewBox.chainSize(CGSizeMake(200.0, 200.0), duration: 1.0),
            viewBox.chainSize(CGSizeMake(50.0, 50.0), duration: 1.0),
            viewBox.chainFrame(CGRectMake(Screen.bounds.width - 100.0, Screen.bounds.height - 100.0, 100.0, 100.0), duration: 1.0, function: .Linear),
            viewBox.chainFrame(CGRectMake(0.0, 0.0, 50.0, 50.0), duration: 1.0, function: .Linear) + viewBox2.chainOrigin(CGPointMake(0.0, 58.0), duration: 1.0) + viewBox2.chainBackgroundColor(UIColor.greenColor(), duration: 1.0),
            viewBox.chainScaleX(3.0, duration: 1.0, function: .EaseInCubic),
            viewBox.chainScaleX(1.0, duration: 1.0, function: .EaseOutCubic),
            viewBox.chainScaleY(3.0, duration: 1.0),
            viewBox.chainScaleY(1.0, duration: 1.0) + viewBox2.chainBackgroundColor(UIColor(hex: 0x007AFF, alpha: 1.0), duration: 1.0),
            viewBox.chainBackgroundColor(viewBox.backgroundColor!.isEqual(UIColor.redColor()) ? UIColor.blueColor().CGColor : UIColor.redColor().CGColor, duration: 1.0),
            viewBox.chainBorderWidth(4.0, duration: 1.0, function: .EaseInOutCubic),
            viewBox.chainCornerRadius(25.0, duration: 1.0, function: .EaseInOutCubic),
            viewBox.chainAlpha(0.5, duration: 1.0),
            viewBox.chainShadowOpacity(1.0, duration: 1.0),
            viewBox.chainShadowColor(UIColor.redColor(), duration: 1.0),
            viewBox.chainShadowRadius(5.0, duration: 1.0),
            
            reverses: true, repeatCount: Float.infinity
        ) {
            self.viewBox.layer.shadowOpacity = 0.0
            self.viewBox.layer.cornerRadius = 0.0
            self.viewBox.layer.borderWidth = 0.0
            self.viewBox.alpha = 1.0
            self.viewBox2.alpha = 1.0
            print("MULTI COMPLETION")
        }
    }
    
    @IBAction func stopAction(sender: AnyObject) {
        viewBox.layer.removeAllAnimations()
        viewBox2.layer.removeAllAnimations()
    }
    
}