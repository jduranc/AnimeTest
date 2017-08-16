//
//  BaseViewController.swift
//  test
//
//  Created by Luis Duran on 8/13/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import SwiftMessages


class Dialog: NSObject
{

	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////

	func wait(title: String, message: String)
	{
		self.show(title: title, message: message, icon: nil, autohide: false, type: .wait, id: nil)
	}
	
	
	func error(title: String, message: String, autohide: Bool)
	{
		self.show(title: title, message: message, icon: nil, autohide: true, type: .error, id: nil)
	}

	
	func show(title: String, message: String, icon: UIImage?, autohide: Bool, type: DialogType, id: String?)
	{
		//cloase any pending dialog.
		SwiftMessages.hide()

		
		var view: MessageView
		
		//if type wait, load a custom view
		if(type == .wait)
		{
			do {
				view = try SwiftMessages.viewFromNib(named: "WaitView")
			}
			catch let error
			{
				print("Unable to load nib: WaitView: %@", error)
				return
			}
		}
		else
		{
			view = MessageView.viewFromNib(layout: .MessageView)
		}
		
		view.configure(type)
		view.configureContent(title: title, body: message, iconImage: icon, iconText: nil, buttonImage: nil, buttonTitle: nil, buttonTapHandler: nil)
		
		
		var config = SwiftMessages.Config()
		
		config.presentationStyle	= .bottom
		config.presentationContext	= .window(windowLevel: UIWindowLevelStatusBar)
		config.duration				= autohide ? .automatic : .forever
		config.dimMode				= .gray(interactive: autohide)
		config.interactiveHide		= autohide
		config.duration				= autohide ? .automatic : .forever
		
		config.preferredStatusBarStyle = .lightContent
		
		// Specify one or more event listeners to respond to show and hide events.
		config.eventListeners.append() { event in
			if case .didHide = event	{ self.onDialogDidHide(id: view.id)	}
			//			if case .willHide = event	{ self.onMessageWillHide()	}
		}
		
		
		SwiftMessages.show(config: config, view: view)
	}
	
	
	
	func hide()
	{
		SwiftMessages.hide()
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Events
	/////////////////////////////////////////////////////////////////////////////////////////////

	func onDialogDidHide(id: String?)
	{
//		print("onMessageDidHide - id: ", id as Any)
	}
}
