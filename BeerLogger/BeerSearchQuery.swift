//
//  BeerSearchQuery.swift
//  BeerLogger
//
//  Created by Katsuhiko Tamura on 2018/12/02.
//  Copyright © 2018 Katsuhiko Tamura. All rights reserved.
//

import UIKit
import ObjectMapper

class BeerSearchQueryRoot : Mappable{
    var data : BeerSearchQueryData?
    required init?(map: Map) {
    }
    func mapping(map: Map) {
        data <- map["data"]
    }
}

class BeerSearchQueryData : Mappable{
    var beerSearch : BeerSearchQuery?
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        beerSearch <- map["beerSearch"]
    }
}

class BeerSearchQuery: Mappable {
    var totalCount : Int = 0
    var last : Int = 0
    var beers : [Beer] = []
    
    required init?(map: Map) {
    }
    
    func mapping( map : Map)
    {
        totalCount <- map["totalCount"]
        last <- map["last"]
        beers <- map["items"]
        
    }
}

class Beer : Mappable{
    var id : String = ""
    var name : String = ""
    var ibu : Float = 0.0
    var imageUrl : String = ""
    var overallScore : Float = 0.0
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        imageUrl <- map["imageUrl"]
        overallScore <- map["overallScore"]
    }

}


