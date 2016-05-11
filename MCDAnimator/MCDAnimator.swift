//
//  MCDAnimator.swift
//  MCDAnimator
//
//  Created by mconintet on 5/11/16.
//  Copyright © 2016 mconintet. All rights reserved.
//

import Foundation
import QuartzCore

public enum MCDAnimatorState {
    case None
    case Animating
    case Paused
    case Stopped
}

public typealias MCDAnimatorValueSetter = (newValue: Double) -> Void

public class MCDAnimator {
    public private(set) var state: MCDAnimatorState = .None

    public private(set) var duration = 0.0
    public private(set) var startTime = 0.0
    public private(set) var pauseTime = 0.0
    public private(set) var elapsedTime = 0.0

    public var animatingCallback: ((MCDAnimator) -> Void)?
    public var pausedCallback: ((MCDAnimator) -> Void)?
    public var stoppedCallback: ((MCDAnimator) -> Void)?

    private var displayLink: CADisplayLink?

    init(duration: Double) {
        self.duration = duration
    }

    public func start() {
        if state == .None {
            displayLink = CADisplayLink(target: self, selector: #selector(MCDAnimator.loop))
            displayLink!.addToRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
            state = .Animating
            startTime = CACurrentMediaTime()
        }
    }

    @objc private func loop() {
        if state == .Paused {
            pauseTime = CACurrentMediaTime() - elapsedTime
            return
        }
        if flessthan(duration, elapsedTime) {
            elapsedTime = duration
        }
        if let c = animatingCallback {
            c(self)
        }
        if fequal(duration, elapsedTime) {
            stop()
        } else {
            elapsedTime = CACurrentMediaTime() - pauseTime - startTime
        }
    }

    public func pause() {
        if state == .Animating {
            state = .Paused
            if let c = pausedCallback {
                c(self)
            }
        }
    }

    public func resume() {
        if state == .Paused {
            state = .Animating
        }
    }

    public func stop() {
        guard let dl = displayLink else {
            return
        }
        dl.removeFromRunLoop(NSRunLoop.currentRunLoop(), forMode: NSRunLoopCommonModes)
        displayLink = nil
        state = .Stopped
        if let c = stoppedCallback {
            c(self)
        }
    }

    static func animate(from: Double, to: Double, duration: Double,
        tween: TweenFunction, setter: MCDAnimatorValueSetter) -> MCDAnimator
    {
        let animator = MCDAnimator(duration: duration)
        let arg = TweenArgument()
        arg.d = duration
        arg.b = from
        arg.c = to - from
        animator.animatingCallback = { (animator) in
            arg.t = animator.elapsedTime
            let v = tween(arg)
            setter(newValue: v)
        }
        return animator
    }
}
