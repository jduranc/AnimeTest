//
//  SerieModel.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit

class SerieModel: NSObject
{
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////

	var serie		: Serie!
	var characters	: [Character]?
	var staff		: [Character]?
	
	var poster		: UIImage?
	var banner		: UIImage?
	

	
	init(serie: Serie!)
	{
		self.serie = serie
		super.init()
	}

	
	
	var scoreImage : UIImage!
	{
		
		if self.serie.score <= 10		//values on feeds are tooo low, allow show some other face that sad
		{
			return #imageLiteral(resourceName: "face_sad")
		}
		else if self.serie.score <= 30
		{
			return #imageLiteral(resourceName: "face_neutral")
		}
		else
		{
			return #imageLiteral(resourceName: "face_happy")
		}
	}
	
	
	public func set(characters: [Character]? = nil)
	{
		self.characters = characters
	}
	
	public func set(staff: [Character]? = nil)
	{
		self.staff = characters
	}
}
