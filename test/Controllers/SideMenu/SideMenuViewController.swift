//
//  ViewController.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/11/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import LGSideMenuController


protocol SideMenuDelegate: SeasonFilterDelegate, SearchDelegate {
}

class SideMenuViewController: UIViewController,
	SeasonFilterDelegate,							//filter delegate
	SearchDelegate									//search delegate
{

	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	@IBOutlet weak var vwFilter: UIView!
	@IBOutlet weak var vwSearch: UIView!
	
	
	public weak var delegate: SideMenuDelegate?
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		// Do any additional setup after loading the view, typically from a nib.
		self.title = "Browse"
	}
	

	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		
		if let control = segue.destination as? SideMenuSeasonViewController
		{
			control.delegate = self
		}
		else if let control = segue.destination as? SideMenuSearchViewController
		{
			control.delegate = self
		}
	}
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Events
	/////////////////////////////////////////////////////////////////////////////////////////////


	@IBAction func onClickClose(_ sender: Any)
	{
		self.hideLeftViewAnimated(sender)
	}
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - SeasonFilter Delegate
	/////////////////////////////////////////////////////////////////////////////////////////////
	func onFilter(season: Serie.Season)
	{
		if (self.delegate != nil)
		{
			self.delegate?.onFilter(season: season)
			self.hideLeftViewAnimated(nil)
		}
	}
	
	
	func onSearch(query: String)
	{
		if (self.delegate != nil)
		{
			self.delegate?.onSearch(query: query)
			self.hideLeftViewAnimated(nil)
		}
	}

	 
}

