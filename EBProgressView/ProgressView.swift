//
//  progressView.swift
//  ProgressIndicator
//
//  Created by edwin bosire on 06/11/2015.
//  Copyright © 2015 Edwin Bosire. All rights reserved.
//

import UIKit

class ProgressView: UIView {
	
	var isAnimating: Bool = false
	
	let maskLayer : CALayer = {
		
		let mLayer = CALayer()
		mLayer.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: 568.0)
		mLayer.backgroundColor = UIColor.blackColor().CGColor
		return mLayer
	}()
	
	private var _progress: Double = 0.0
	var progress : Double
		{
		get {
			return _progress
		}
		
		set (newProgress){
			if (self._progress != newProgress){
				self._progress = min(1.0, fabs(newProgress))
				self.setNeedsLayout()
			}
		}
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		var maskFrame = maskLayer.frame
			maskFrame.size.width = CGRectGetWidth(self.bounds) * CGFloat(_progress)
			maskLayer.frame = maskFrame
	}
	
	override class func layerClass() -> AnyClass {
		return CAGradientLayer.self
	}
	
	required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		setup()
	}
	
	override  init(frame: CGRect) {
		super.init(frame: frame)
		
		setup()
	}
	
	func setup() {
		
		maskLayer.frame = CGRect(x: 0.0, y: 0.0, width: 0.0, height: frame.size.height)
		layer.mask = maskLayer
		
		let gradient: CAGradientLayer = layer as! CAGradientLayer
		
		gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
		gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
		
		let rainbow = gradientColors()
		gradient.colors = rainbow

		startAnimating()
	}
	
	func gradientColors() -> [CGColor] {
		var colours:[CGColor] = []
		
		for var hue:Double = 0; hue < 360; hue+=5 {
			let color = UIColor(hue: CGFloat(1.0 * (hue/360)), saturation: 1.0, brightness: 1.0, alpha: 1.0).CGColor
			colours.append(color)
		}
		
		return colours
	}

	func animateRainbow() {
		
		//Move the last color to the front while simulteneously shifting all other colors rights
		
		let gradient = layer as! CAGradientLayer
		var currentLayerColors = gradient.colors
		let trailingColor = currentLayerColors?.last
		
		currentLayerColors?.removeLast()
		currentLayerColors?.insert(trailingColor!, atIndex: 0)

		gradient.colors = currentLayerColors
		
		let animation: CABasicAnimation = CABasicAnimation(keyPath: "colors")
		animation.toValue = currentLayerColors
		animation.duration = 0.08
		animation.removedOnCompletion = true
		animation.fillMode = "forwards"
		animation.delegate = self
		
		gradient.addAnimation(animation, forKey: "animateRainbow")
	}
	
	
	override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
		
		if (isAnimating){
			animateRainbow()
		}
		
	}

	func stopAnimating() {
		
		if (isAnimating) {
			isAnimating = false
			UIView.animateWithDuration(0.9, animations: { () -> Void in
				self.alpha = 0.0
			})
		}
	}
	
	func startAnimating() {
		
		if (!isAnimating) {
			isAnimating = true
			
			UIView.animateWithDuration(0.3, animations: { () -> Void in
				self.alpha = 1.0
			})
			animateRainbow()
		}
	}
}
