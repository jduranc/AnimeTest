//
//  SerieViewController.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit
import LGSideMenuController


class SerieViewController: UIViewController,
	UICollectionViewDataSource, //UICollectionViewDelegate		//collection delegates
	SideMenuDelegate
{

	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Outlets
	/////////////////////////////////////////////////////////////////////////////////////////////

	@IBOutlet weak var vwCollection: UICollectionView!
	 
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	var server	: Server!
	var data	: [SerieModel]?
	
	
	var dialog	= Dialog()
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		if(self.server == nil)
		{
			self.server = Server()
		}
		
		self.title	= "Anime"
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// - Configure collection view
//		self.vwCollection.delegate		= self
		self.vwCollection.dataSource	= self
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// Initial update data
		self.update(season: Serie.Season.winter)
    }


	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Navigation
	/////////////////////////////////////////////////////////////////////////////////////////////

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		
		if(segue.identifier == "details")
		{
			if	let dst		= segue.destination as? SerieDetailsViewController,
				let cell	= sender as? SerieCollectionViewCell,
				let data	= cell.model
			{
				dst.model	= data
			}
		}
    }
	
	
	
	
	@IBAction func onMenuClick(_ sender: Any)
	{
		self.showLeftViewAnimated(sender)
	}
	

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Update
	/////////////////////////////////////////////////////////////////////////////////////////////
	func update(season: Serie.Season)
	{
		if let auth = server.authorizationToken
		{
			self.dialog.wait(title: "Updating", message: "Please wait...")
			self.server.getAnimes(season: season, authorization: auth) { (series, error) in
				self.hanldeResponse(series: series, error)
			}
		}
		//no authorization token, user is not logged
		else
		{
			self.showNoLoginError()
		}
	}
	
	func search(query: String)
	{
		if let auth = server.authorizationToken
		{
			self.dialog.wait(title: "Searching", message: "Please wait...")
			self.server.getAnimes(query: query, authorization: auth) { (series, error) in
				self.hanldeResponse(series: series, error)
			}
		}
			
		//no authorization token, user is not logged
		else
		{
			self.showNoLoginError()
		}
	}
	
	private func hanldeResponse(series: [Serie]?, _ error: Error?)
	{
		if (error != nil)
		{
			self.showNetworkErrorDialog()
		}
		else if(series == nil || series!.count <= 0)
		{
			self.showNoContentError()
		}
		else
		{
			
			self.data = [SerieModel]()
			for serie in series!
			{
				let newItem = SerieModel(serie: serie)
				self.data?.append(newItem)
			}
			
			self.vwCollection.reloadData()
			
			self.dialog.hide()
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// Dialog helpers
	private func showNetworkErrorDialog()
	{
		self.dialog.error(title: "Unable to read content", message: "Check your internet connection, and try again.", autohide: true)
	}
	
	private func showNoLoginError()
	{
		print("Unable to login or access")
		self.dialog.error(title: "Unable to connect", message: "Check your internet connection, and try again.", autohide: true)
	}
	
	private func showNoContentError()
	{
		print("Unable to login or access")
		self.dialog.error(title: "Ups!!!", message: "No content found. Please try again", autohide: true)
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - SideMenuDelegate Delegate
	/////////////////////////////////////////////////////////////////////////////////////////////
	func onFilter(season: Serie.Season)
	{
		self.update(season: season)
	}

	func onSearch(query: String)
	{
		self.search(query: query)
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
			let cell = self.vwCollection.dequeueReusableCell(withReuseIdentifier: "SerieCell", for: indexPath) as? SerieCollectionViewCell
		{
			cell.initWith(model: item)
			return cell
		}
		
		fatalError("Unable to create cell")
	}
	
	
	func numberOfSections(in collectionView: UICollectionView) -> Int
	{
		return 1
	}

	
	func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
		
		switch kind {
			
		case UICollectionElementKindSectionHeader:
			let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath)
			headerView.backgroundColor = Theme.MainColorContrast
			return headerView
			
		case UICollectionElementKindSectionFooter:
			let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "HeaderCell", for: indexPath)
			footerView.backgroundColor = UIColor.green;
			return footerView
			
		default:

			assert(false, "Unexpected element kind")
		}
	}
	

}
