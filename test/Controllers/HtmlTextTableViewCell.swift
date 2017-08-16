//
//  ScrollTextTableViewCell.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class HtmlTextTableViewCell: UITableViewCell {

	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////
	@IBOutlet weak var lbText: UILabel!
	

	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	
	func initWith(text: String?)
	{
		if (text != nil)
		{
			do
			{
				if let content	= text?.data(using: .utf32)
				{
					
					//convert html to attributed string
					let htmlString	= try NSAttributedString(data: content,
					              	                         options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
					              	                         documentAttributes: nil)
					
					//add font format
					let attString	= NSMutableAttributedString(attributedString: htmlString)
					let range		= NSRange.init(location: 0, length: attString.length)
					let attributes	= [NSFontAttributeName: self.lbText.font as Any]
					
					attString.addAttributes(attributes, range: range)
					
					self.lbText.attributedText	= attString
				}
			}
			catch
			{
				self.lbText.text	= "Error on reading content"
			}
		}
		else
		{
			self.lbText.text		= ""
		}
	}

}
