//
//  Theme.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/11/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit

class Theme: NSObject {

	
	static let MainColor 				= UIColor.fromHex(rgb:0x04A8FF)
	static let MainColorContrast		= UIColor.fromHex(rgb:0xFFFFFF)
	
	static let MainDarkColor			= UIColor.fromHex(rgb:0x555555)
	static let MainDarkColorContrast	= UIColor.fromHex(rgb:0xFFFFFF)
	
	
	
	public static func apply()
	{
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - NavigationBar
		let navigationBarAppearace					= UINavigationBar.appearance()
		navigationBarAppearace.barTintColor			= MainColor
		navigationBarAppearace.tintColor			= MainColorContrast
		navigationBarAppearace.titleTextAttributes	= [NSForegroundColorAttributeName:MainColorContrast]
		
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - TabBar
		let tabbarAppearace					= UITabBar.appearance()
		tabbarAppearace.tintColor			= MainColor
		tabbarAppearace.barTintColor		= MainColorContrast
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Button
		let buttonAppearance				= UIButton.appearance()
		buttonAppearance.backgroundColor	= MainDarkColor
		buttonAppearance.tintColor			= MainDarkColorContrast
		
		
		//button in navigation bar
		let buttonNavAppearance				= UIButton.appearance(whenContainedInInstancesOf: [UINavigationBar.self])
		buttonNavAppearance.backgroundColor	= UIColor.clear
		buttonNavAppearance.tintColor		= MainColorContrast
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Segment
		let segmentAppearance				= UISegmentedControl.appearance()
		segmentAppearance.backgroundColor	= MainDarkColorContrast
		segmentAppearance.tintColor			= MainDarkColor
	}
	
	
	
	
}
