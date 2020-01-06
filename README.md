RECButton
===

An @IBInspectable record (REC) button for iOS.

* iOS 9.0+
* Swift 5.0+

Install
----

``` sh
pod RECButton
```

Usage
----

![alt tag](https://raw.githubusercontent.com/cemolcay/RECButton/master/sb.gif)

* RECButton is a UIButton subclass
* Create a RECButton instance either from storyboard or programmatically.
* Set the color and size properties for recording state and non-recording state.
* Those are also IBInspectable, settable directly from the storyboard.
* Set other inherited UIButton properties.

``` swift
@IBInspectable public var ringColor: UIColor = .white
@IBInspectable public var dotColor: UIColor = .white
@IBInspectable public var recordingDotColor: UIColor = .red
@IBInspectable public var recordingRingColor: UIColor = .orange
@IBInspectable public var dotPadding: CGFloat = 2
@IBInspectable public var ringLineWidth: CGFloat = 1
@IBInspectable public var recordingRingDashPattern: String?
@IBInspectable public var recordingAnimationDuration: CGFloat = 0
@IBInspectable public var isRecording: Bool = false
```

Recording
----

* Set `isRecording` bool value.

![alt tag](https://raw.githubusercontent.com/cemolcay/RECButton/master/rec.gif)