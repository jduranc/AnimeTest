//
//  Dialog.swift
//  test
//
//  Created by Luis Duran on 8/13/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit
import SwiftMessages




/////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Custom types for dialogs
/////////////////////////////////////////////////////////////////////////////////////////////

/// The theme enum specifies the built-in theme options
public enum DialogType {
	case info
	case success
	case warning
	case error
	case wait
}



/////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Custom class for message views
/////////////////////////////////////////////////////////////////////////////////////////////

class MessageWaitView: MessageView
{
	@IBOutlet weak var vwAnimation: LOTView!
	
	override func awakeFromNib() {
		super.awakeFromNib()
		self.vwAnimation.load(file: "loading")
		self.vwAnimation.animation?.contentMode = .scaleAspectFill
	}
}



///////////////////////////////////////////////////////////////////////////////////////////////
// MARK: - Custom Configuraitons for views
/////////////////////////////////////////////////////////////////////////////////////////////

extension MessageView {
	


	public func configure(_ theme: DialogType)
	{
		var iconImage: UIImage? = nil
		
		
		switch theme {
		case .info:
			let backgroundColor = Theme.MainDarkColor
			let foregroundColor = Theme.MainDarkColorContrast
			iconImage			= UIImage(named:"errorIcon")
			configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)
		case .success:
			let backgroundColor = UIColor(red: 97.0/255.0, green: 161.0/255.0, blue: 23.0/255.0, alpha: 1.0)
			let foregroundColor = UIColor.white
			configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)
		case .warning:
			let backgroundColor = UIColor(red: 238.0/255.0, green: 189.0/255.0, blue: 34.0/255.0, alpha: 1.0)
			let foregroundColor = UIColor.white
			configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)
		case .error:
			let backgroundColor = UIColor(red: 249.0/255.0, green: 66.0/255.0, blue: 47.0/255.0, alpha: 1.0)
			let foregroundColor = UIColor.white
			configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)
		case .wait:
			let backgroundColor = Theme.MainDarkColor
			let foregroundColor = Theme.MainDarkColorContrast
			configureTheme(backgroundColor: backgroundColor, foregroundColor: foregroundColor, iconImage: iconImage)
		}
	}
	

	public func configureTheme(backgroundColor: UIColor, foregroundColor: UIColor, iconImage: UIImage? = nil, iconText: String? = nil) {
		iconImageView?.image		= iconImage
		iconLabel?.text				= iconText
		iconImageView?.tintColor	= foregroundColor
		
		
		let backgroundView				= self.backgroundView ?? self
		backgroundView.backgroundColor	= backgroundColor
		
		iconLabel?.textColor	= foregroundColor
		titleLabel?.textColor	= foregroundColor
		bodyLabel?.textColor	= foregroundColor
		
		button?.backgroundColor		= foregroundColor
		button?.tintColor			= backgroundColor
		button?.contentEdgeInsets	= UIEdgeInsetsMake(7.0, 7.0, 7.0, 7.0)
		button?.layer.cornerRadius	= 5.0
		
		iconImageView?.isHidden		= iconImageView?.image == nil
		iconLabel?.isHidden			= iconLabel?.text == nil
	}
}
