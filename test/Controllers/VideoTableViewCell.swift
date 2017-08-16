//
//  VideoTableViewCell.swift
//  test
//
//  Created by Luis Duran on 8/13/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

	let VideoURL		= "https://www.youtube.com/embed/{video_id}"
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	@IBOutlet weak var vwVideo: UIWebView!
	@IBOutlet weak var lbMessage: UILabel!
	

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////

    override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
		self.vwVideo.layer.borderColor	= Theme.MainDarkColor.cgColor
		self.vwVideo.layer.borderWidth	= 1
		self.vwVideo.layer.cornerRadius = 5
		self.vwVideo.clipsToBounds		= true
    }


	func initWith(videoId: String!)
	{
		let base = VideoURL.replacingOccurrences(of: "video_id", with: "\(videoId)")
		
		if let url = URL(string: base)
		{
			self.lbMessage.isHidden = true
			self.vwVideo.isHidden	= false
			let request				= URLRequest(url: url)
			self.vwVideo.loadRequest(request)
		}
		else
		{
			self.vwVideo.isHidden	= true
			self.lbMessage.isHidden = false
		}
		
	}
}
