//
//  CharacterCollectionViewCell.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell
{
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////

	@IBOutlet weak var imPoster: UIImageView!
	@IBOutlet weak var lbTitle: UILabel!
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////

	override func awakeFromNib() {
		super.awakeFromNib()
		
		self.imPoster.layer.borderColor		= Theme.MainDarkColor.cgColor
		self.imPoster.layer.borderWidth		= 1
		self.imPoster.layer.cornerRadius	= self.imPoster.frame.size.height / 2
		self.imPoster.clipsToBounds			= true
	}
	
	
	func initWith(character: Character)
	{
		self.lbTitle.text	= character.firstName
		
		
		//load banner image
		if	let image	= character.imageUrl,
			let url		= URL(string: image)
		{
			self.imPoster.sd_setImage(with: url, completed: { (image, error, type, url) in
				self.imPoster.alpha = 0;
				UIView.animate(withDuration: 1, animations: {
					self.imPoster.alpha = 1
				})
			})
		}
		
	}
	
}
