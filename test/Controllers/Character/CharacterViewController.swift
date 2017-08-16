//
//  CharacterViewController.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/15/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit

class CharacterViewController: UIViewController,
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
		case count
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	var character	: Character!
	var server		= Server()
	var dialog		= Dialog()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		// Do any additional setup after loading the view.
		self.title = "Character"
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Configure Table
		self.vwTable.dataSource			= self
		self.vwTable.delegate			= self
		self.vwTable.rowHeight			= UITableViewAutomaticDimension
		self.vwTable.estimatedRowHeight = 150
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Initial update
		self.update()
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Update
	/////////////////////////////////////////////////////////////////////////////////////////////
	func update()
	{
		if	let auth = server.authorizationToken
		{
			
			self.server.getCharacter(characterId: self.character.id, authorization: auth, handler: { (character, error) in
				
				if (error != nil)
				{
					self.dialog.error(title: "Upps!!!", message: "Something was wrong, please try again later", autohide: true)
				}
				else
				{
					
					//TODO: check, large data model of character does not contains role value,
					//change small character model with large (full) data model
					self.character 		= character		
						
						
					//reload new content sections
					let indexes : IndexSet = [Sections.title.rawValue,
											  Sections.desc.rawValue]
					self.vwTable.reloadSections(indexes, with: .fade)
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
			if let customCell = self.vwTable.dequeueReusableCell(withIdentifier: "Title", for: indexPath) as? CharacterTableViewCell
			{
				customCell.initWith(character: self.character)
				cell = customCell
			}
		}
			
			/////////////////////////////////////////////////////////////////////////////////////////////
			// Description section
		else if(indexPath.section == Sections.desc.rawValue)
		{
			if let customCell = self.vwTable.dequeueReusableCell(withIdentifier: "HtmlText", for: indexPath) as? HtmlTextTableViewCell
			{
				customCell.initWith(text: character.info)
				cell = customCell
			}
			
		}
			
		
		
		
		if(cell == nil)
		{
			fatalError("[SerieDetailsViewController] unable to create tablecell")
		}
		
		return cell!
	}
	

}
