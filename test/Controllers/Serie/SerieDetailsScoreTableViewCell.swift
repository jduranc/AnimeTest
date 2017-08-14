//
//  SerieDetailsScoreTableViewCell.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit

class SerieDetailsScoreTableViewCell: UITableViewCell {

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////

	
	@IBOutlet weak var lbPopularity: UILabel!
	@IBOutlet weak var imScore: UIImageView!
	@IBOutlet weak var vwSeparator: UIView!
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////

    override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
		self.vwSeparator.backgroundColor = Theme.MainColor
    }

	

	public func initWith(model: SerieModel!)
	{
		self.lbPopularity.text	= "\(model.serie.popularity)"
		self.imScore.image		= model.scoreImage
	}
}
