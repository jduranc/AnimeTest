//
//  UIColor+Hex.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/11/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

extension UIColor 
{
	class func fromHex(rgb:UInt32)->UIColor
	{
		let red 	= CGFloat((rgb & 0xFF0000) >> 16)	/ 256.0
		let green 	= CGFloat((rgb & 0x00FF00) >> 8)	/ 256.0
		let blue 	= CGFloat( rgb & 0x0000FF)			/ 256.0
		
		return UIColor(red:red, green:green, blue:blue, alpha:1.0)
	}
	
	class func fromHex(argb:UInt32)->UIColor
	{
		let alpha 	= CGFloat((argb & 0xFF0000) >> 24)	/ 256.0
		let red 	= CGFloat((argb & 0xFF0000) >> 16)	/ 256.0
		let green 	= CGFloat((argb & 0x00FF00) >> 8)	/ 256.0
		let blue 	= CGFloat( argb	& 0x0000FF)			/ 256.0
		
		return UIColor(red:red, green:green, blue:blue, alpha:alpha)
	}
}
