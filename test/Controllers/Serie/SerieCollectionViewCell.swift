//
//  SerieViewController.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import SDWebImage


class SerieCollectionViewCell: UICollectionViewCell {
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////

	@IBOutlet weak var imBackground: UIImageView!
	@IBOutlet weak var vwCard: UIView!
	@IBOutlet weak var lbTitle: UILabel!
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	weak var model : SerieModel?
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.layer.borderWidth	= 2
		self.layer.borderColor	= Theme.MainDarkColor.cgColor
		self.layer.cornerRadius = 5
		self.clipsToBounds		= true
	}
	
	
	public func initWith(model: SerieModel)
	{
		self.model = model
		
		self.lbTitle.text		= self.model?.serie.title
		
		
		
		if	let image	= model.serie.imageUrl,
			let url		= URL(string: image)
		{
			self.imBackground.sd_setImage(with: url, completed: { (image, error, type, url) in
				self.imBackground.alpha = 0;
				UIView.animate(withDuration: 1, animations: { 
					self.imBackground.alpha = 1
				})
			})
		}
		
		
		
	}

}
