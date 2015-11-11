//
//  ViewController.swift
//  EBProgressView
//
//  Created by edwin bosire on 06/11/2015.
//  Copyright © 2015 Edwin Bosire. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
	
	@IBOutlet weak var progressLabel: UILabel!
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		let refresh = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action: "refresh")
		self.navigationController?.navigationItem.leftBarButtonItem = refresh;
		
		/** To set the progress bar, assuming change is your progress change
		
		var change = 10;
		let navigationBar = self.navigationController as! EBNavigationController
		
		if let navgationBarProgress = navigationBar.lineProgressView {
		
		navgationBarProgress.progress = progress + change
		}
		*/
		self.progressLabel.text = "\(0.0) %"
		simulateProgress()
	}
	
	func refresh () {
		NSLog("Refresh the data here")
	}
	func simulateProgress() {
		
		let delay: Double = 2.0
		let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( delay * Double(NSEC_PER_SEC)))
		dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
			
			let increment = Double(arc4random() % 5) / Double(10.0) + 0.1
			
			let navigationBar = self.navigationController as! EBNavigationController
			
			let progress = navigationBar.lineProgressView.progress + increment
			navigationBar.lineProgressView.progress = progress
			self.progressLabel.text = "\(progress*100) %"
			
			if (progress < 1){
				self.simulateProgress()
			}else {
				// Using a callback function here would be ideal
//				navigationBar.lineProgressView.stopAnimating()
				NSLog("Finished animating progress bar")
			}
			
		}
		
	}
}

