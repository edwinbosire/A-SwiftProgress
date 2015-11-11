//
//  NavigationController.swift
//  EBProgressView
//
//  Created by edwin bosire on 06/11/2015.
//  Copyright © 2015 Edwin Bosire. All rights reserved.
//

import UIKit

class EBNavigationController: UINavigationController {

	let lineProgressViewHeight: CGFloat = 2.0

	var lineProgressView: ProgressView = {
		
		let _lineProgressView = ProgressView(frame: CGRect(x: 0.0, y:0, width: 320, height: 2.0))
		_lineProgressView.translatesAutoresizingMaskIntoConstraints = false
		return _lineProgressView
	}()
	
	
	private var _lineProgress: Double = 0.0
	var lineProgress : Double
		{
		get {
			return _lineProgress
		}
		
		set (newProgress){
			if (self._lineProgress != newProgress){
				self._lineProgress = min(1.0, fabs(newProgress))
				
				self.lineProgressView.progress = self._lineProgress
				
			}
		}
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		navigationBar.addSubview(self.lineProgressView)
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		let views = ["progressview" : self.lineProgressView,"navBar" : self.navigationBar]
		
		let widthConstraints = NSLayoutConstraint.constraintsWithVisualFormat("H:|[progressview]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
		navigationBar.addConstraints(widthConstraints)
		
		let verticleConstraints = NSLayoutConstraint.constraintsWithVisualFormat("V:[progressview(2)]|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: views)
		navigationBar.addConstraints(verticleConstraints)
	}
	
	override func viewDidLayoutSubviews() {
		super.viewDidLayoutSubviews()
		
		
	}
}
