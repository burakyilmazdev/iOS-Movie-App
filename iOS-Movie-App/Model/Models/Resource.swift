//
//  Response.swift
//  iOS-Movie-App
//
//  Created by Burak Yılmaz on 27.05.2022.
//

import Foundation

struct Resource{

    var status:Status
    var data:MovieResponse?
    var message:String?
    
    init(_ status:Status, _ data:MovieResponse?, _ message:String?){
        self.status = status
        self.data = data
        self.message = message
    }
    
    static func success(data: MovieResponse) -> Resource {
        return Resource(.Success, data, nil)
        
    }
    
    static func loading() -> Resource {
        return Resource(.Loading, nil, nil)
        
    }
    
    static func failure(error : String) -> Resource {
        return Resource(.Failure, nil, error)
        
    }
    
    
}
