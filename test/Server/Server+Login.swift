//
//  Login.swift
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
	
	//TODO: encode values.
	struct Params
	{
		static let ClientID			= "jduranc-pmvyz"
		static let ClientSecret		= "slFp4F7Fbcm71uZKAy"
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Login
	/////////////////////////////////////////////////////////////////////////////////////////////
	public func doLogin(handler: @escaping(_ token: AccessToken?, _ error: Error?) -> ())
	{
		print("[Login].doAuthorize")
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		// build request
		let url		= URL.Base + Endpoint.Login
		
		let params : [String:String] = [
			"grant_type" 	: "client_credentials",
			"client_id" 	: Params.ClientID,
			"client_secret" : Params.ClientSecret
		]
		
		let request = Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: nil)
		
		
		
		/////////////////////////////////////////////////////////////////////////////////////////////
		//send request
		request.responseJSON { (response) in
			
			
			//if get values
			if let values = response.result.value as? [String: AnyObject]
			{
				print("[Login].doAuthorize response: \(values)")

				var token : AccessToken? = nil
				let realm = try! Realm()
				try! realm.write
				{
					if let data = AccessToken(JSON: values)
					{
						token = data
						
						//add or update
						realm.add(data, update: true)
					}
				}
				
				
				//call handler
				handler(token, nil)
			}
				
			//no results
			else
			{
				print("[Login].doAuthorize No values in response: \(response)")
				
				//call handler
				handler(nil, response.error)
			}
		}
	}
	
	
	public func getLogin() -> (AccessToken?)
	{
		let realm	= try! Realm()
		let value	= realm.object(ofType: AccessToken.self, forPrimaryKey: AccessToken.UniqueID)
	
		return value
	}
	
	
}

