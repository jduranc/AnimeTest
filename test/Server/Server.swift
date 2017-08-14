//
//  Server.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/11/17.
//  Copyright © 2017 valuout. All rights reserved.
//

import UIKit
import Alamofire
import RealmSwift


class Server: NSObject 
{
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - URLs
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	struct URL
	{
		static let Base			= "https://anilist.co/api/"
	}
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - URLS
	/////////////////////////////////////////////////////////////////////////////////////////////
	struct Endpoint
	{
		static let Login		= "auth/access_token"
		static let Browse		= "browse/anime"
		static let Search		= "anime/search/"
		static let Anime		= "anime/{serie_id}"
		static let Character	= "anime/{serie_id}/characters"
	}
	
	
	
	
	
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	public var authorizationToken : String?
	{
		var value : String? = nil
		if	let login = self.getLogin(),
			let token = login.token
			
		{
			value = String(format: "Bearer %@", token)
		}
		
		return value
	}
	
	
	
	
	
//	public func doRequest(url: String, method: HTTPMethod, parameters: Parameters? = nil, headers: HTTPHeaders? = nil,
//	                      handler: @escaping(_ response: DataResponse<Any>?, _ error: Error?)-> ())
//	{
//		print("[Server].doRequest")
//		
//		// build request
//		let request = Alamofire.request(url, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: headers)
//		print("[Server].doRequest url: \(url)");
//		
//		
//		//send request
//		request.responseJSON { (response) in
//			//check for values in response
//			if (response.error != nil)
//			{
//				handler(nil, response.error)
//			}
//			else
//			{
//				handler(response, nil)
//			}
//		}
//	}
	
	
	
	

	
}
