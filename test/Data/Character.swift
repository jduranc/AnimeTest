//
//  Character.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/11/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper


class Character: Object, Mappable 
{
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	struct Fields {
		static let Id			= "id"
		static let FirstName	= "name_first"
		static let LastName		= "name_last"
		static let AltName		= "name_alt"
		static let Role			= "role"
		
		static let Image		= "image_url_lge"
		static let Info			= "info"
		
	}
	
	
	dynamic var id			: Int 		= 0
	dynamic var firstName	: String?
	dynamic var secondName	: String?
	dynamic var altName		: String?
	dynamic var role		: String?
	
	dynamic var imageUrl	: String?
	dynamic var info		: String?
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// Mappeable object.
	// init with map.
	required convenience init?(map: Map) {
		self.init()
	}
	
	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Realm Properties
	/////////////////////////////////////////////////////////////////////////////////////////////
	override static func primaryKey() -> String? {
		return Fields.Id
	}
	
	
	override static func indexedProperties() -> [String] {
		return [Fields.Id]
	}
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Mappable
	/////////////////////////////////////////////////////////////////////////////////////////////
	func mapping(map: Map)
	{
		id			<- map[Fields.Id]
		firstName	<- map[Fields.FirstName]
		secondName	<- map[Fields.LastName]
		altName		<- map[Fields.AltName]
		role		<- map[Fields.Role]
		
//		//check for some value present
//		if let value : String? = try? map.value(Fields.Role)
//		{
//			role	= value
//		}
				
		imageUrl	<- map[Fields.Image]
		info		<- map[Fields.Info]
		
		// customize/modify some value?.
	}
}
