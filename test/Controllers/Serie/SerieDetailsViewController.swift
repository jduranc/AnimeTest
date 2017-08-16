//
//  SerieDetailsViewController.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class SerieDetailsViewController: UIViewController,
	UITableViewDataSource, UITableViewDelegate								//tableview delegate
{

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	@IBOutlet weak var vwTable: UITableView!
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Consts
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	enum Sections: Int
	{
		case title
		case desc
		case score
		case characters
		case video
		case count
	}
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	var model		: SerieModel!
	
	var server		= Server()
	var dialog		= Dialog()
	
	

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.title = "Details"
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Configure Table
		self.vwTable.dataSource			= self
		self.vwTable.delegate			= self
		self.vwTable.rowHeight			= UITableViewAutomaticDimension
		self.vwTable.estimatedRowHeight = 200
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Initial update
		self.update()
    }

	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Navigation
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		// Get the new view controller using segue.destinationViewController.
		// Pass the selected object to the new view controller.
		
//		if(segue.identifier == "character")
//		{
			if	let dst		= segue.destination as? CharacterViewController,
				let cell	= sender as? CharacterCollectionViewCell,
				let data	= cell.character
			{
				dst.character	= data
			}
//		}
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Update
	/////////////////////////////////////////////////////////////////////////////////////////////
	func update()
	{
		if	let auth = server.authorizationToken
		{
			
			self.server.getAnime(serieId: self.model.serie.id, authorization: auth, handler: { (serie, error) in
				if (error != nil)
				{
					self.dialog.error(title: "Upps!!!", message: "Something was wrong, please try again later", autohide: true)
				}
				else
				{
					//update reference con full data
					self.model = SerieModel(serie: serie)
//					print("Serie: \(serie)")
					
					
					self.server.getCharacter(serieId: self.model.serie.id, authorization: auth, handler: { (characters, error) in
//						print("Characters: \(characters)")
						
						
						//store characters in model
						self.model.set(characters: characters)
						

						//reload new content sections
						let indexes : IndexSet = [Sections.score.rawValue,
												  Sections.desc.rawValue,
												  Sections.characters.rawValue,
												  Sections.video.rawValue]
						self.vwTable.reloadSections(indexes, with: .fade)
					})
				}
			})
		}
			
		//should not reach here since user should be logged at main menu
		else
		{
			print("Unable to login or access")
		}
	}

	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Tableview Datasource
	/////////////////////////////////////////////////////////////////////////////////////////////
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		 return Sections.count.rawValue
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
	{
		var cell : UITableViewCell? = nil
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Title section
		if (indexPath.section == Sections.title.rawValue)
		{
			if let customCell = self.vwTable.dequeueReusableCell(withIdentifier: "SerieDetailsTitle", for: indexPath) as? SerieDetailsTitleTableViewCell
			{
				customCell.initWith(model: self.model)
				cell = customCell
			}
		}
			
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Description section
		else if(indexPath.section == Sections.desc.rawValue)
		{
			if let customCell = self.vwTable.dequeueReusableCell(withIdentifier: "HtmlText", for: indexPath) as? HtmlTextTableViewCell
			{
				customCell.initWith(text: self.model.serie.desc)
				cell = customCell
			}
			
		}
			
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Score section
		else if(indexPath.section == Sections.score.rawValue)
		{
			
			if let customCell = self.vwTable.dequeueReusableCell(withIdentifier: "SerieDetailsScore", for: indexPath) as? SerieDetailsScoreTableViewCell
			{
				customCell.initWith(model: self.model)
				cell = customCell
			}
		}
			
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Characters section
		else if(indexPath.section == Sections.characters.rawValue)
		{
			
			if let customCell = self.vwTable.dequeueReusableCell(withIdentifier: "CharactersList", for: indexPath) as? CharactersTableViewCell
			{
				customCell.initWith(characters: self.model.characters)
				cell = customCell
			}
		}
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Video Section
		else if(indexPath.section == Sections.video.rawValue)
		{
			if let customCell = self.vwTable.dequeueReusableCell(withIdentifier: "Video", for: indexPath) as? VideoTableViewCell
			{
				customCell.initWith(videoId: self.model.serie.videoId)
				cell = customCell
			}
		}
	
	
	
		
		if(cell == nil)
		{
			fatalError("[SerieDetailsViewController] unable to create tablecell")
		}
		
		return cell!
	}
	
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
	{
		
//		//TODO: Apply hide on empty section?
//		if(indexPath.section == Sections.characters.rawValue)
//		{
//			//do not show characters if loaded and no info
//			if (self.model.characters != nil && self.model.characters?.count == 0)
//			{
//				return 0;
//			}
//			
//		}
//			
//		else if(indexPath.section == Sections.video.rawValue)
//		{
//			if	let videoId = self.model.serie.videoId,
//				let url		= URL(string: videoId)
//			{
//				
//			}
//			else
//			{
//				return 0;
//			}
//		}
		return UITableViewAutomaticDimension
	}

}
