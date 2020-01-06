//
//  RECButton.swift
//  RECButton
//
//  Created by cem.olcay on 06/01/2020.
//  Copyright © 2020 cemolcay. All rights reserved.
//

import UIKit

@IBDesignable public class RECButton: UIButton {
  @IBInspectable public var ringColor: UIColor = .white
  @IBInspectable public var dotColor: UIColor = .white
  @IBInspectable public var recordingDotColor: UIColor = .red
  @IBInspectable public var recordingRingColor: UIColor = .orange
  @IBInspectable public var dotPadding: CGFloat = 2
  @IBInspectable public var ringLineWidth: CGFloat = 1
  @IBInspectable public var recordingRingDashPattern: String?
  @IBInspectable public var recordingAnimationDuration: CGFloat = 0

  public var dotLayer = CAShapeLayer()
  public var ringLayer = CAShapeLayer()
  private var ringAnimationKey = "ringAnimation"

  @IBInspectable public var isRecording: Bool = false {
    didSet {
      recordingStateDidChange()
    }
  }

  // MARK: Initialize

  public override init(frame: CGRect) {
    super.init(frame: frame)
    commonInit()
  }

  public required init?(coder: NSCoder) {
    super.init(coder: coder)
    commonInit()
  }

  private func commonInit() {
    layer.addSublayer(ringLayer)
    layer.addSublayer(dotLayer)
  }

  // MARK: Lifecycle

  public override func layoutSubviews() {
    super.layoutSubviews()
    let centerPoint = CGPoint(x: frame.width / 2.0, y: frame.height / 2.0)

    let ringSize = min(frame.size.width, frame.size.height)
    ringLayer.frame.size = CGSize(width: ringSize, height: ringSize)
    ringLayer.position = centerPoint
    ringLayer.lineWidth = ringLineWidth
    ringLayer.fillColor = nil
    ringLayer.strokeColor = isRecording ? recordingRingColor.cgColor : ringColor.cgColor
    let ringPath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: ringLayer.frame.size))
    ringLayer.path = ringPath.cgPath

    let dotSize = ringSize - dotPadding - ringLineWidth
    dotLayer.frame.size = CGSize(width: dotSize, height: dotSize)
    dotLayer.position = centerPoint
    dotLayer.fillColor = isRecording ? recordingDotColor.cgColor : dotColor.cgColor
    let dotPath = UIBezierPath(ovalIn: CGRect(origin: .zero, size: dotLayer.frame.size))
    dotLayer.path = dotPath.cgPath
  }

  private func recordingStateDidChange() {
    ringLayer.removeAllAnimations()

    if isRecording {
      let anim = CABasicAnimation(keyPath: "lineDashPhase")
      anim.fromValue = 0.0
      anim.toValue = recordingAnimationDuration == 0 ? (ringLineWidth * 3.0) : recordingAnimationDuration
      anim.duration = 1.0
      anim.repeatCount = HUGE
      anim.isRemovedOnCompletion = false
      ringLayer.lineDashPattern = parseDashPattern() ?? [
        NSNumber(floatLiteral: Double(ringLineWidth)),
        NSNumber(floatLiteral: Double(ringLineWidth * 2.0)),
      ]
      ringLayer.lineCap = .round
      ringLayer.add(anim, forKey: ringAnimationKey)
    } else {
      ringLayer.lineDashPattern = nil
    }
  }

  private func parseDashPattern() -> [NSNumber]? {
    guard let recordingRingDashPattern = recordingRingDashPattern
      else { return nil }

    return recordingRingDashPattern
      .split(separator: ",")
      .map({ String($0).trimmingCharacters(in: .whitespacesAndNewlines) })
      .map({ NSNumber(value: Int($0) ?? 0) })
  }
}
