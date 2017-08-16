//
//  Serie.swift
//  test
//
//  Created by Jose Luis Duran Cota on 8/11/17.
//  Copyright © 2017 . All rights reserved.
//

import UIKit
import RealmSwift
import ObjectMapper


class Serie: Object, Mappable 
{

	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Types
	/////////////////////////////////////////////////////////////////////////////////////////////
	enum Season: String
	{
		case winter
		case spring
		case summer
		case fall
	}

	
	/////////////////////////////////////////////////////////////////////////////////////////////
	// MARK: - Members
	/////////////////////////////////////////////////////////////////////////////////////////////
	
	struct Fields {
		static let Id			= "id"
		static let SerieType	= "series_type"
		static let Title		= "title_english"
		static let StartDate	= "start_date"
		static let EndDate		= "end_date"
		static let Season		= "season"
		static let Description	= "description"
		static let Synonyms		= "synonyms"
		
		static let Score		= "average_score"
		static let Adult		= "adult"
		static let Popularity	= "popularity"
		
		static let Image		= "image_url_lge"
		static let Banner		= "image_url_banner"
		static let Characters	= "characters"
		static let Video		= "youtube_id"
		
	}
	
	
	dynamic var id			: Int 		= 0
	dynamic var title		: String?
	dynamic var type		: String?
	dynamic var startDate	: String?
	dynamic var endDate		: String?
	dynamic var season		: Int 		= 0
	dynamic var desc		: String?
	dynamic var synonyms	: String?
	
	dynamic var score		: Float 	= 0
	dynamic var adult		: Bool 		= false
	dynamic var popularity	: Int 		= 0
	
	dynamic var imageUrl	: String?
	dynamic var bannerUrl	: String?
	dynamic var videoId		: String?
	
	
	
	
	
	
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
		title		<- map[Fields.Title]
		type		<- map[Fields.SerieType]
		startDate	<- map[Fields.StartDate]
		endDate		<- map[Fields.EndDate]
		season		<- map[Fields.Season]
		
		
		desc		<- map[Fields.Description]
		synonyms	<- map[Fields.Synonyms]
		
		score		<- map[Fields.Score]
		adult		<- map[Fields.Adult]
		popularity	<- map[Fields.Popularity]
		
		imageUrl	<- map[Fields.Image]
		bannerUrl	<- map[Fields.Banner]
		
		videoId		<- map[Fields.Video]

		
		// customize/modify some value?.
	}
}
