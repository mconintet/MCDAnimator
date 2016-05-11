# MCDAnimator

If you familiar with the animations in browser you must probably known some easing functions, also there are some js projects provide convenient APIs like [tween.js](https://github.com/tweenjs/tween.js/) etc.

This project uses easing functions from [Robert Penner's Easing Functions](http://robertpenner.com/easing/) and just wraps them to be an easy API.

## Usage

Method signature:

```swift
static func animate(from: Double, to: Double, duration: Double,
        tween: TweenFunction, setter: MCDAnimatorValueSetter) -> MCDAnimator
```

Example:

```swift
let animatorX = MCDAnimator.animate(Double(v.center.x), to: Double(x), duration: 1, tween: TweenBounceEaseOut)
{ (newValue) in
    var c = self.v.center
    c.x = CGFloat(newValue)
    self.v.center = c
}
animatorX.start()
```

## Screenshot

![](https://raw.githubusercontent.com/mconintet/MCDAnimator/master/screenshots/s.gif)