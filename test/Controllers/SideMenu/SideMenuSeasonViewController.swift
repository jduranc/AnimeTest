//
//  SideMenuSeasonViewController.swift
//  test
//
//  Created by Luis Duran on 8/13/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit


protocol SeasonFilterDelegate: class
{
	func onFilter(season: Serie.Season)
}


class SideMenuSeasonViewController: UIViewController {

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////
	@IBOutlet weak var sgSeason: UISegmentedControl!
	@IBOutlet weak var btApply: UIButton!
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	public weak var delegate: SeasonFilterDelegate?
	
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.btApply.roundCorner()
    }

	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Events
	/////////////////////////////////////////////////////////////////////////////////////////////

	@IBAction func onClickApply(_ sender: Any)
	{
		let idx	= self.sgSeason.selectedSegmentIndex
		
		// Notice that segment title must match with season enum values
		if	let delegate	= self.delegate,
			let title		= self.sgSeason.titleForSegment(at: idx),
			let selected	= Serie.Season(rawValue: title.lowercased())
		{
			delegate.onFilter(season: selected)
		}
		
	}

}
