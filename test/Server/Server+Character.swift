//
//  Character.swift
//  test
//
//  Created by Luis Duran on 8/12/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift

extension Server
{
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Get Character
	/////////////////////////////////////////////////////////////////////////////////////////////
	public func getCharacter(serieId: Int, authorization: String,
							 handler: @escaping(_ animes: [Character]?, _ error: Error?) -> ())
	{
		print("[Character].get")
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build params
		let endpoint	= Endpoint.SerieCharacters.replacingOccurrences(of: "{serie_id}", with: "\(serieId)")
		let url			= Server.URL.Base + endpoint
		
		
		
		let params : [String:String] = [
			"Authorization" : authorization,
		]
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build request
		let request = Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: params)
		print("[Character].get url: \(url) params:\(params)");
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		//send request
		request.responseJSON { (response) in
			print("[Character].get response: \(response)")
			
			
			// NOTICE that endpoint return full serie information + characters info
			
			//check for values in response
			if	let serie		= response.result.value as? [String: AnyObject]
			{
				
				var data	= [Character]()
				
				if let characters	= serie["characters"]	as? Array<[String: AnyObject]>
				{
					//print("[Character].get values: \(characters)")
					
					//save items
					let realm	= try! Realm()
					try! realm.write
					{
						for row in characters
						{
							if let item = Character(JSON: row)
							{
								data.append(item)
								realm.add(item, update: true)
							}
							else
							{
								print("[Character].get Invalid object: \(row)")
							}
						}
					}
				}
				
				//send completion handler
				handler(data, nil)
			}
			else
			{
				print("[Character].get No values in response: \(response)")
				
				//send completion handler
				handler(nil, response.error)
			}
		}
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Get Character
	/////////////////////////////////////////////////////////////////////////////////////////////
	public func getCharacter(characterId: Int, authorization: String,
	                         handler: @escaping(_ character: Character?, _ error: Error?) -> ())
	{
		print("[Character].get")
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build params
		let url			= Server.URL.Base + Endpoint.Character + "\(characterId)"
		
		
		
		let params : [String:String] = [
			"Authorization" : authorization,
			]
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build request
		let request = Alamofire.request(url, method: .get, parameters: params, encoding: JSONEncoding.default, headers: params)
		print("[Character].get url: \(url) params:\(params)");
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		//send request
		request.responseJSON { (response) in
			print("[Character].get response: \(response)")
			
			
			// NOTICE that endpoint return full serie information + characters info
			
			//check for values in response
			if	let value = response.result.value as? [String: AnyObject]
			{
				
				var data : Character?
				
				//print("[Character].get value \(value)")
				
				//save items
				let realm	= try! Realm()
				try! realm.write
				{
					if let item = Character(JSON: value)
					{
						data = item
						realm.add(item, update: true)
					}
					else
					{
						print("[Character].get Invalid object: \(value)")
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
		
}

