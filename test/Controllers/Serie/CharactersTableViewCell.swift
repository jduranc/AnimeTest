//
//  CharactersTableViewCell.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit

class CharactersTableViewCell: UITableViewCell,
	UICollectionViewDataSource						//collection delegates
{

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////
	@IBOutlet weak var lbTitle: UILabel!
	@IBOutlet weak var vwCollection: UICollectionView!

	@IBOutlet weak var lbNoCharacters: UILabel!
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	var data : [Character]?
	

    override func awakeFromNib() {
        super.awakeFromNib()
		
        // Initialization code
		self.vwCollection.dataSource	= self
		self.vwCollection.tintColor		= Theme.MainColor
    }
	
	
	func initWith(characters: [Character]?)
	{
		self.data = characters
		self.vwCollection.reloadData()
		
		//show label error when data loaded but no characters
		lbNoCharacters.isHidden = !(characters != nil && characters?.count == 0)
	}
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - UICollection delegates
	/////////////////////////////////////////////////////////////////////////////////////////////
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
	{
		return self.data?.count ?? 0
	}
	
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
	{
		if	let item = self.data?[indexPath.row],
			let cell = self.vwCollection.dequeueReusableCell(withReuseIdentifier: "Character", for: indexPath) as? CharacterCollectionViewCell
		{
			cell.initWith(character: item)
			return cell
		}
		
		fatalError("Unable to create cell")
	}
	
	
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}


}
