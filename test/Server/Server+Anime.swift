//
//  Anime.swift
//  test
//
//  Created by Luis Duran on 8/11/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

extension Server
{
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Get Anim
	/////////////////////////////////////////////////////////////////////////////////////////////
	public func getAnimes(season: Serie.Season, authorization: String,
								   handler: @escaping(_ animes: [Serie]?, _ error: Error?) -> ())
	{
		print("[Anime].get")
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build params
		let url		= Server.URL.Base + Endpoint.Browse
		
		
		let params : [String:String] = [
			"Authorization" : authorization,
			"season"		: season.rawValue,
			"full_page"		: "true",
			"sort"			: "score-desc"
		]

		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build request
		let request = Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: params)
		print("[Anime].get url: \(url) params:\(params)");
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		//send request
		request.responseJSON { (response) in
			
			//parse as series array
			self.parse(response: response, handler: handler)
		}
	}
	
	
	public func getAnime(serieId: Int, authorization: String,
	                     handler: @escaping(_ anime: Serie?, _ error: Error?) -> ())
	{
		print("[Anime].get")
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build params
		let endpoint	= Endpoint.Anime.replacingOccurrences(of: "{serie_id}", with: "\(serieId)")
		let url			= Server.URL.Base + endpoint
		
		let params : [String:String] = [
			"Authorization" : authorization,
		]
		
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build request
		let request = Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: params)
		print("[Anime].get url: \(url) params:\(params)");
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		//send request
		request.responseJSON { (response) in
//			print("[Anime].get response: \(response)")
			self.parse(response: response, handler: handler)
		}
	}
	
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Get Anim with Query
	/////////////////////////////////////////////////////////////////////////////////////////////
	public func getAnimes(query: String, authorization: String,
	                      handler: @escaping(_ animes: [Serie]?, _ error: Error?) -> ())
	{
		print("[Anime].get")
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build request
		if let encode = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
		{
			let url	= Server.URL.Base + Endpoint.Search + encode
			
			
			let params : [String:String] = [
				"Authorization" : authorization,
				"full_page"		: "true",
				"sort"			: "score-desc"
			]
			
			
			
			
			/////////////////////////////////////////////////////////////////////////////////////////////
			// build request
			let request = Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: params)
			print("[Anime].get url: \(url) params:\(params)");
			
			
			/////////////////////////////////////////////////////////////////////////////////////////////
			//send request
			request.responseJSON { (response) in
				//parse as series array
				self.parse(response: response, handler: handler)
			}
		}
		
		//something was wrong with query, was unable to encode string, return error.
		else
		{
			print("Unable to encode query")
			let error = NSError(domain: "Invalid query", code: 1, userInfo: nil)
			handler(nil, error)
		}
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Helpers
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// Parse data response as serie array
	private func parse(response: DataResponse<Any>,
	                   handler: @escaping(_ animes: [Serie]?, _ error: Error?) -> ())
	{
		//print("[Anime].get response: \(response)")
	
		//check for values in response
		if let values	= response.result.value as? Array<[String: AnyObject]>
		{
			//print("[Anime].get values: \(list)")
			
			var data	= [Serie]()
			
			
			//save items
			let realm	= try! Realm()
			try! realm.write
			{
				for current in values
				{
					if let object = Serie(JSON: current)
					{
						data.append(object)
						realm.add(object, update: true)
					}
					else
					{
						print("[Anime].get Invalid object: \(current)")
					}
				}
			}
			
			//send completion handler
			handler(data, nil)
		}
		else
		{
			print("[Anime].get No values in response: \(response)")
			
			//send completion handler
			handler(nil, response.error)
		}
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// Parse data response as single serie
	private func parse(response: DataResponse<Any>,
	                   handler: @escaping(_ anime: Serie?, _ error: Error?) -> ())
	{
		//check for values in response
		if let row	= response.result.value as? [String: AnyObject]
		{
//			print("[Anime].get values: \(row)")
			var data : Serie? = nil
			
			
			//save items
			let realm	= try! Realm()
			try! realm.write
			{
				if let item = Serie(JSON: row)
				{
					data = item
					realm.add(item, update: true)
				}
				else
				{
					print("[Anime].get Invalid object: \(row)")
				}
			}
			
			//send completion handler
			handler(data, nil)
		}
		else
		{
			print("[Anime].get No values in response: \(response)")
			
			//send completion handler
			handler(nil, response.error)
		}
	}

}

