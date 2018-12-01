//
//  RateBeer.swift
//  BeerLogger
//
//  Created by Katsuhiko Tamura on 2018/11/30.
//  Copyright © 2018 Katsuhiko Tamura. All rights reserved.
//

import UIKit

class RateBeer: NSObject {
    var apiKey : String = "CR1oSGui1u4tK7wbBqyDR9WpfkTHe0mm49PAqWek"
    
    func GetJson() -> String
    {
        let url = URL(string : "")!
        
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField : "content-type")
        request.addValue("application/json", forHTTPHeaderField : "accept")
        request.addValue(apiKey, forHTTPHeaderField : "x-api-key")
        
        let query = "query {\n beer(id: 4934) {\n id\n name\n }\n}"
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
            }catch let e{
                print("Parse error : \(e)")
            }
        })
        task.resume()
        
        return ""
    }
    
    
}
