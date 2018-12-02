//
//  RateBeer.swift
//  BeerLogger
//
//  Created by Katsuhiko Tamura on 2018/11/30.
//  Copyright © 2018 Katsuhiko Tamura. All rights reserved.
//

import UIKit
import ObjectMapper

class RateBeer: NSObject {
    var apiKey : String = ""
    
    func GetJson() -> String
    {
        let url = URL(string : "https://api.r8.beer/v1/api/graphql/")!
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField : "content-type")
        request.addValue("application/json", forHTTPHeaderField : "accept")
        request.addValue(apiKey, forHTTPHeaderField : "x-api-key")
        
        let query = BeerSearchString(SearchString: "minoh")//"query {\n beer(id: 4934) {\n id\n name\n }\n}"
        let body = ["query" : query]
        request.httpBody = try! JSONSerialization.data(withJSONObject: body, options: [])
        request.cachePolicy = .reloadIgnoringLocalCacheData
        
        let task = URLSession.shared.dataTask(with: request, completionHandler:{ data, _, error in
            if let error = error { print(error); return}
            guard let data = data else { print("Data is Missing."); return}
            do{
                let text = NSString(data : data, encoding : String.Encoding.utf8.rawValue)
                print( text! as String )
                let json = try JSONSerialization.jsonObject(with:data, options:[])
                print(json)
                let beerSearchQueryRoot : BeerSearchQueryRoot  = Mapper().map(JSONString: text! as String)!
                print(beerSearchQueryRoot.data!.beerSearch!.beers[0].name)
                
            }catch let e{
                print("Parse error : \(e)")
            }
        })
        task.resume()
        
        return ""
    }
    
    func AddOneLine( BaseString baseString : String, AddString addString : String ) -> String
    {
        let resultString = baseString + addString + "\n"
        return resultString
    }
    
    func BeerSearchString( SearchString searchString : String ) -> String
    {
        var baseString : String = ""
        baseString = AddOneLine( BaseString: baseString, AddString: "query{" )
        var beerSeachLineString : String = "beerSearch(query:\""
        beerSeachLineString = beerSeachLineString + searchString + "\", first:5, after:0)"
        
        baseString = AddOneLine( BaseString: baseString, AddString: beerSeachLineString)
        baseString = AddOneLine( BaseString: baseString, AddString: "{" )
        baseString = AddOneLine( BaseString: baseString, AddString: "totalCount" )
        baseString = AddOneLine( BaseString: baseString, AddString: "items{" )

        baseString = AddOneLine( BaseString: baseString, AddString: "id," )
        baseString = AddOneLine( BaseString: baseString, AddString: "name," )
        baseString = AddOneLine( BaseString: baseString, AddString: "imageUrl," )
        baseString = AddOneLine( BaseString: baseString, AddString: "abv," )
        baseString = AddOneLine( BaseString: baseString, AddString: "overallScore" )
        
        baseString = AddOneLine( BaseString: baseString, AddString: "}" )

        baseString = AddOneLine( BaseString: baseString, AddString: "last" )

        baseString = AddOneLine( BaseString: baseString, AddString: "}" )
        baseString = AddOneLine( BaseString: baseString, AddString: "}" )

        return baseString
        
    }
    
    
}
