//
//  TweenFunctions.swift
//  MCDAnimator
//
//  Created by mconintet on 5/11/16.
//  Copyright © 2016 mconintet. All rights reserved.
//

import Foundation

@inline(__always)
func fequal(a: Double, _ b: Double) -> Bool
{
    return fabs(a - b) < DBL_EPSILON
}

@inline(__always)
func fequalzero(a: Double) -> Bool
{
    return fabs(a) < DBL_EPSILON
}

@inline(__always)
func flessthan(a: Double, _ b: Double) -> Bool
{
    return fabs(a) < fabs(b) + DBL_EPSILON
}

@inline(__always)
func max(a: Double, _ b: Double) -> Double
{
    return flessthan(a, b) ? b : a
}

public class TweenArgument {
    public var t = 0.0
    public var b = 0.0
    public var c = 0.0
    public var d = 0.0
    public var a = 0.0
    public var p = 0.0
    public var s = 0.0
}

public typealias TweenFunction = ((TweenArgument) -> Double)

// MARK: Linear
public let TweenLinear: TweenFunction = { (arg: TweenArgument) in
    return arg.c * arg.t / arg.d + arg.b
}

// MARK: Quadratic
public let TweenQuadEaseIn: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d
    return arg.c * t * t + arg.b
}

public let TweenQuadEaseOut: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d
    return -arg.c * t * (t - 2) + arg.b
}

public let TweenQuadEaseInOut: TweenFunction = { (arg: TweenArgument) in
    var t = arg.t / arg.d / 2
    if flessthan(t, 1.0) {
        return arg.c / 2 * t * t + arg.b
    }
    t -= 1
    return -arg.c / 2 * (t * (t - 2) - 1) + arg.b
}

// MARK: Cubic
public let TweenCubicEaseIn: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d
    return arg.c * t * t * t + arg.b
}

public let TweenCubicEaseOut: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d - 1
    return arg.c * (t * t * t + 1) + arg.b
}

public let TweenCubicEaseInOut: TweenFunction = { (arg: TweenArgument) in
    var t = arg.t / arg.d / 2
    if flessthan(t, 1) {
        return arg.c / 2 * t * t * t + arg.b
    }
    t -= 2
    return arg.c / 2 * (t * t * t + 2) + arg.b
}

// MARK: Quartic
public let TweenQuartEaseIn: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d
    return arg.c * t * t * t * t + arg.b
}

public let TweenQuartEaseOut: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d - 1
    return -arg.c * (t * t * t * t - 1) + arg.b
}

public let TweenQuartEaseInOut: TweenFunction = { (arg: TweenArgument) in
    var t = arg.t / arg.d / 2
    if flessthan(t, 1) {
        return arg.c / 2 * t * t * t * t + arg.b
    }
    t -= 2
    return -arg.c / 2 * (t * t * t * t - 2) + arg.b
}

// MARK: Quintic
public let TweenQuintEaseIn: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d
    return arg.c * t * t * t * t * t + arg.b
}

public let TweenQuintEaseOut: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d - 1
    return arg.c * (t * t * t * t * t + 1) + arg.b
}

public let TweenQuintEaseInOut: TweenFunction = { (arg: TweenArgument) in
    var t = arg.t / arg.d / 2
    if flessthan(t, 1) {
        return arg.c / 2 * t * t * t * t * t + arg.b
    }
    t -= 2
    return arg.c / 2 * (t * t * t * t * t + 2) + arg.b
}

// MARK: Sinusoidal
public let TweenSineEaseIn: TweenFunction = { (arg: TweenArgument) in
    return -arg.c * cos(arg.t / arg.d * (M_PI / 2)) + arg.c + arg.b
}

public let TweenSineEaseOut: TweenFunction = { (arg: TweenArgument) in
    return arg.c * sin(arg.t / arg.d * (M_PI / 2)) + arg.b
}

public let TweenSineEaseInOut: TweenFunction = { (arg: TweenArgument) in
    return -arg.c / 2 * (cos(M_PI * arg.t / arg.d) - 1) + arg.b
}

// MARK: Exponential
public let TweenExpoEaseIn: TweenFunction = { (arg: TweenArgument) in
    return fequalzero(arg.t) ? arg.b : arg.c * pow(2, 10 * (arg.t / arg.d - 1)) + arg.b
}

public let TweenExpoEaseOut: TweenFunction = { (arg: TweenArgument) in
    return fequal(arg.t, arg.d) ?arg.b + arg.c: arg.c * (-pow(2, -10 * arg.t / arg.d) + 1) + arg.b
}

public let TweenExpoEaseInOut: TweenFunction = { (arg: TweenArgument) in
    if fequalzero(arg.t) {
        return arg.b
    }
    if fequal(arg.t, arg.d) {
        return arg.b + arg.c
    }
    var t = arg.t / arg.d / 2
    if flessthan(t, 1) {
        return arg.c / 2 * pow(2, 10 * (arg.t - 1)) + arg.b
    }
    t -= 1
    return arg.c / 2 * (-pow(2, -10 * arg.t) + 2) + arg.b
}

// MARK: Circular
public let TweenCircEaseIn: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d
    return -arg.c * (sqrt(max(1 - t * t, 0)) - 1) + arg.b
}

public let TweenCircEaseOut: TweenFunction = { (arg: TweenArgument) in
    let t = arg.t / arg.d - 1
    return arg.c * sqrt(max(1 - t * t, 0)) + arg.b
}

public let TweenCircEaseInOut: TweenFunction = { (arg: TweenArgument) in
    var t = arg.t / arg.d / 2
    if flessthan(t, 1) {
        return -arg.c / 2 * (sqrt(max(1 - t * t, 0)) - 1) + arg.b
    }
    t -= 2
    return arg.c / 2 * (sqrt(max(1 - t * t, 0)) + 1) + arg.b
}

// MARK: Elastic
public let TweenElasticEaseIn: TweenFunction = { (arg: TweenArgument) in
    if fequalzero(arg.t) {
        return arg.b
    }
    var t = arg.t / arg.d
    if fequal(t, 1) {
        return arg.b + arg.c
    }
    var p = arg.p
    var a = arg.a
    if fequalzero(p) {
        p = arg.d * 0.3
    }
    var s = 0.0
    if fequalzero(a) || flessthan(a, fabs(arg.c)) {
        a = arg.c
        s = p / 4
    }
    else {
        s = p / (2 * M_PI) * asin(arg.c / a)
    }
    t -= 1
    return -(a * pow(2, 10 * t) * sin((t * arg.d - s) * (2 * M_PI) / p)) + arg.b
}

public let TweenElasticEaseOut: TweenFunction = { (arg: TweenArgument) in
    if fequalzero(arg.t) {
        return arg.b
    }
    let t = arg.t / arg.d
    if fequal(t, 1) {
        return arg.b + arg.c
    }
    var p = arg.p
    var a = arg.a
    if fequalzero(p) {
        p = arg.d * 0.3
    }
    var s = 0.0
    if fequalzero(a) || flessthan(a, fabs(arg.c)) {
        a = arg.c
        s = p / 4
    }
    else {
        s = p / (2 * M_PI) * asin(arg.c / a)
    }
    return (a * pow(2, -10 * t) * sin((t * arg.d - s) * (2 * M_PI) / p) + arg.c + arg.b)
}

public let TweenElasticEaseInOut: TweenFunction = { (arg: TweenArgument) in
    if fequalzero(arg.t) {
        return arg.b
    }
    var t = arg.t / arg.d / 2
    if fequal(t, 2) {
        return arg.b + arg.c
    }
    var p = arg.p
    var a = arg.a
    if fequalzero(p) {
        p = arg.d * (0.3 * 1.5)
    }
    var s = 0.0
    if fequalzero(a) || flessthan(a, fabs(arg.c)) {
        a = arg.c
        s = p / 4
    }
    else {
        s = p / (2 * M_PI) * asin(arg.c / a)
    }
    if flessthan(t, 1) {
        t -= 1
        return -0.5 * (a * pow(2, 10 * t) * sin((t * arg.d - s) * (2 * M_PI) / p)) + arg.b
    }
    t -= 1
    return a * pow(2, -10 * t) * sin((t * arg.d - s) * (2 * M_PI) / p) * 0.5 + arg.c + arg.b
}

// MARK: Back
public func TweenBackEaseIn(t: Double, _ b: Double, _ c: Double, _ d: Double, _ s: Double) -> Double
{
    var s = s
    if fequalzero(s) {
        s = 1.70158
    }
    let t = t / d
    return c * t * t * ((s + 1) * t - s) + b
}

public let TweenBackEaseOut: TweenFunction = { (arg: TweenArgument) in
    var s = arg.s
    if fequalzero(s) {
        s = 1.70158
    }
    let t = arg.t / arg.d - 1
    return arg.c * (t * t * ((s + 1) * t + s) + 1) + arg.b
}

public let TweenBackEaseInOut: TweenFunction = { (arg: TweenArgument) in
    var s = arg.s
    if fequalzero(s) {
        s = 1.70158
    }
    var t = arg.t / arg.d / 2
    if flessthan(t, 1) {
        s *= 1.525
        return arg.c / 2 * (t * t * ((s + 1) * t - s)) + arg.b
    }
    t -= 2
    s *= 1.525
    return arg.c / 2 * (t * t * ((s + 1) * t + s) + 2) + arg.b
}

// MARK: Bounce
public let TweenBounceEaseIn: TweenFunction = { (arg: TweenArgument) in
    let a = TweenArgument()
    a.t = arg.d - arg.t
    a.b = 0
    return arg.c - TweenBounceEaseOut(a) + arg.b
}

public let TweenBounceEaseOut: TweenFunction = { (arg: TweenArgument) in
    var t = arg.t / arg.d
    if flessthan(t, 1 / 2.75) {
        return arg.c * (7.5625 * t * t) + arg.b
    }
    else if flessthan(t, 2 / 2.75) {
        t -= 1.5 / 2.75
        return arg.c * (7.5625 * t * t + 0.75) + arg.b
    }
    else if flessthan(t, 2.5 / 2.75) {
        t -= 2.25 / 2.75
        return arg.c * (7.5625 * t * t + 0.9375) + arg.b
    }
    else {
        t -= 2.625 / 2.75
        return arg.c * (7.5625 * t * t + 0.984375) + arg.b
    }
}

public let TweenBounceEaseInOut: TweenFunction = { (arg: TweenArgument) in
    if flessthan(arg.t, arg.d / 2) {
        let a = TweenArgument()
        a.t = arg.t * 2
        a.b = 0
        return TweenBounceEaseIn(a) * 0.5 + arg.b
    }
    let a = TweenArgument()
    a.t = arg.t * 2 - arg.d
    a.b = 0
    return TweenBounceEaseOut(a) * 0.5 + arg.c * 0.5 + arg.b
}
