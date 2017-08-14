//
//  VideoTableViewCell.swift
//  test
//
//  Created by Luis Duran on 8/13/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit
import Lottie

class LOTView: UIView {


	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////

	var animation: LOTAnimationView?
	

	/////////////////////////////////////////////////////////////////////////////////////////////
	// Create defaults contructors for IB
	override public init(frame: CGRect)
	{
		super.init(frame: frame)
		self.setup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		self.setup()
	}
	
	
	func setup()
	{
		// clear animation background
		self.backgroundColor = .clear
	}
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// Load animation file and attach to current view
	func load(file: String)
	{
		let animationView	= LOTAnimationView(name: file)
		self.animation		= animationView
		
		animationView.translatesAutoresizingMaskIntoConstraints = false
		self.addSubview(animationView)
		
		animationView.contentMode	= .scaleAspectFit
		animationView.loopAnimation = true
		animationView.play()
		
		
		let views		= ["myView" : animationView]
		let vertical	= NSLayoutConstraint.constraints(withVisualFormat: "V:|[myView]|", options: .alignAllTop, metrics: nil, views: views)
		NSLayoutConstraint.activate(vertical)
		self.addConstraints(vertical)
		
		let horizontal	= NSLayoutConstraint.constraints(withVisualFormat: "H:|[myView]|", options: .alignAllTop, metrics: nil, views: views)
		NSLayoutConstraint.activate(horizontal)
		self.addConstraints(horizontal)
	}

}
