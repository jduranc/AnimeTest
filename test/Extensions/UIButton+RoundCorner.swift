//
//  UIButton+RoundCorner.swift
//  test
//
//  Created by Luis Duran on 8/13/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit


extension UIButton
{
	public func roundCorner()
	{
		self.layer.cornerRadius = self.frame.size.height / 2
	}
}
