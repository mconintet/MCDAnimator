//
//  ViewController.swift
//  MCDAnimatorDemo
//
//  Created by hsiaosiyuan on 5/11/16.
//  Copyright © 2016 mconintet. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let v = UIView()
    let btnRun = UIButton()
    let btnReset = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(v)
        v.backgroundColor = UIColor.purpleColor()
        v.translatesAutoresizingMaskIntoConstraints = false
        v.widthAnchor.constraintEqualToConstant(50).active = true
        v.heightAnchor.constraintEqualToConstant(50).active = true
        v.leftAnchor.constraintEqualToAnchor(view.leftAnchor)
        v.topAnchor.constraintEqualToAnchor(topLayoutGuide.topAnchor)

        view.addSubview(btnRun)
        btnRun.setTitle("Run", forState: .Normal)
        btnRun.setTitleColor(UIColor.blueColor(), forState: .Normal)
        btnRun.translatesAutoresizingMaskIntoConstraints = false
        btnRun.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -20).active = true
        btnRun.rightAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: -20).active = true
        btnRun.addTarget(self, action: #selector(ViewController.doAnimate), forControlEvents: .TouchUpInside)

        view.addSubview(btnReset)
        btnReset.setTitle("Reset", forState: .Normal)
        btnReset.setTitleColor(UIColor.blueColor(), forState: .Normal)
        btnReset.translatesAutoresizingMaskIntoConstraints = false
        btnReset.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -20).active = true
        btnReset.leftAnchor.constraintEqualToAnchor(view.centerXAnchor, constant: 20).active = true
        btnReset.addTarget(self, action: #selector(ViewController.reset), forControlEvents: .TouchUpInside)
    }

    func doAnimate() {
        let x = view.bounds.size.width / 2
        let animatorX = MCDAnimator.animate(Double(v.center.x), to: Double(x), duration: 1, tween: TweenBounceEaseOut)
        { (newValue) in
            var c = self.v.center
            c.x = CGFloat(newValue)
            self.v.center = c
        }

        let y = view.bounds.size.height / 2
        let animatorY = MCDAnimator.animate(Double(v.center.y), to: Double(y), duration: 1, tween: TweenBounceEaseOut)
        { (newValue) in
            var c = self.v.center
            c.y = CGFloat(newValue)
            self.v.center = c
        }

        animatorX.stoppedCallback = { (animator) in
            print(self.v)
            print(self.v.center)
        }

        animatorX.start()
        animatorY.start()
    }

    func reset() {
        let x = v.frame.size.width / 2
        let animatorX = MCDAnimator.animate(Double(v.center.x), to: Double(x), duration: 1, tween: TweenBounceEaseOut)
        { (newValue) in
            var c = self.v.center
            c.x = CGFloat(newValue)
            self.v.center = c
        }

        let y = v.frame.size.height / 2
        let animatorY = MCDAnimator.animate(Double(v.center.y), to: Double(y), duration: 1, tween: TweenBounceEaseOut)
        { (newValue) in
            var c = self.v.center
            c.y = CGFloat(newValue)
            self.v.center = c
        }

        animatorX.stoppedCallback = { (animator) in
            print(self.v)
            print(self.v.center)
        }

        animatorX.start()
        animatorY.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

