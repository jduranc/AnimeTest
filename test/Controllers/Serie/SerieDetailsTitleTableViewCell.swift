//
//  SerieDetailsTitleTableViewCell.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import SDWebImage


class SerieDetailsTitleTableViewCell: UITableViewCell {

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	@IBOutlet weak var imBackground: UIImageView!
	@IBOutlet weak var imPoster: UIImageView!
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var vwCard: UIView!
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	weak var model : SerieModel!

	

    override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
		self.imPoster.layer.borderWidth		= 1
		self.imPoster.layer.borderColor		= Theme.MainDarkColor.cgColor
		self.imPoster.layer.cornerRadius	= 5
		self.imPoster.clipsToBounds			= true
    }

	
	func initWith(model: SerieModel!)
	{
		self.model			= model
		self.lbTitle.text	= model.serie.title
		
		//fade only at first download
		if model.banner == nil
		{
			//load banner image
			if	let image	= model.serie.bannerUrl,
				let url		= URL(string: image)
			{
				self.imBackground.sd_setImage(with: url, completed: { (image, error, type, url) in
					
					model.banner = image
					
					self.imBackground.alpha = 0;
					UIView.animate(withDuration: 1.5, animations: {
						self.imBackground.alpha = 1
					})
				})
			}
		}
		else
		{
			self.imBackground.image = model.banner
		}
		
		
		//NOTICE: let fade on each display
		//load poster image
		if	let image	= model.serie.imageUrl,
			let url		= URL(string: image)
		{
			self.imPoster.sd_setImage(with: url, completed: { (image, error, type, url) in
				model.poster = image
				
				self.imPoster.alpha = 0;
				UIView.animate(withDuration: 1, animations: {
					self.imPoster.alpha = 1
				})
			})
		}
	}
	
	
}
