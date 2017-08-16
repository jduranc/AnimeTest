//
//  LoadingViewController.swift
//  test
//
//  Created by Luis Duran on 8/13/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import LGSideMenuController


class LoadingViewController: UIViewController {

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////
	@IBOutlet weak var vwAnimation: LOTView!

	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	var dialog	= Dialog()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// Do any additional setup after loading the view.
		
		//setup loading animation
		self.vwAnimation.load(file: "loading")
		
		
		//init login
		let server	= Server()
		
		
		//do login
		server.doLogin { (accessToken, error) in
			
			
			//if logged request data
			if (server.authorizationToken != nil)
			{
				self.goMain()
			}
			else
			{
				self.dialog.error(title: "Error", message: "Unable to login, please try again.", autohide: false)
			}
		}
    }

	
	private func goMain()
	{
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Configure Side Menu
		let storyboard	= UIStoryboard(name: "Main", bundle: nil)
		
		let main		= storyboard.instantiateViewController(withIdentifier: "SerieViewController") as! SerieViewController
		let mainNav		= UINavigationController(rootViewController: main)
		
		let menu		= storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
		let menuNav		= UINavigationController(rootViewController: menu)
		
		menu.delegate	= main
		
		
		let sideMenuController		= LGSideMenuController(rootViewController: mainNav,
		                      		                       leftViewController: menuNav,
		                      		                       rightViewController: nil)
		
		sideMenuController.leftViewWidth				= 320.0
		sideMenuController.leftViewPresentationStyle	= .slideAbove
//		sideMenuController.leftViewAlwaysVisibleOptions = [.onPadLandscape]
		
		self.present(sideMenuController, animated: true, completion: nil)

	}
	

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
