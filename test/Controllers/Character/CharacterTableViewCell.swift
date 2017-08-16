//
//  CharacterTableViewCell.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/15/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {

	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////

	@IBOutlet weak var imPoster: UIImageView!

	@IBOutlet weak var lbFirstName: UILabel!
	@IBOutlet weak var lbSecondName: UILabel!
	@IBOutlet weak var lbAltName: UILabel!
	
	@IBOutlet weak var lbRole: UILabel!
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////

    override func awakeFromNib() {
        super.awakeFromNib()
		
		
        // Initialization code
		self.imPoster.layer.borderWidth		= 1
		self.imPoster.layer.borderColor		= Theme.MainDarkColor.cgColor
		self.imPoster.layer.cornerRadius	= 5
		self.imPoster.clipsToBounds			= true
    }


	func initWith(character: Character?)
	{
		
		self.lbFirstName.text 	= character?.firstName 	?? "-"
		self.lbSecondName.text	= character?.secondName ?? "-"
		self.lbAltName.text		= character?.altName	?? "-"
		self.lbRole.text		= character?.role		?? "-"
		
		//load banner image
		if	let image	= character?.imageUrl,
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
