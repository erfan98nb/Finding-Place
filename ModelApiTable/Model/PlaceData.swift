//
//  pgumOfferModel.swift
//  pgum
//
//  Created by Mohammad Gharari on 12/14/20.
//

import UIKit
import SwiftyJSON
struct PlaceData:Identifiable {
    var id: UUID
    
    var name:String
    var lat:Double
    var lng:Double
    var icon:String
    var shortname:String
    var address:String
    var distance:String
    var summary: String
    
    init(jsonObject: JSON)  {
        let venue = jsonObject["venue"]
        let location = venue["location"]
        let categories = venue["categories"][0]

        id = UUID()
        name = venue["name"].stringValue
        lat = location["lat"].doubleValue
        lng = location["lng"].doubleValue
        distance = location["distance"].stringValue
        address = location["address"].stringValue
        icon = categories["icon","prefix"].stringValue + "100" + categories["icon","suffix"].stringValue
        shortname = categories ["shortName"].stringValue
        summary = jsonObject["reasons","items"][0]["summary"].stringValue
        
    }
    
    
}

