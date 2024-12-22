//
//  getDataModel.swift
//  ModelApiTable
//
//  Created by MAC os on 2/24/21.
//

import Foundation
import Alamofire
import SwiftyJSON
public class GetDataModel{
    public static let shared = GetDataModel()
    var loadedPlaces = [PlaceData]()

    func getPlaceDetails(lat:Double , lng: Double , offset:Int ,completion: @escaping ([PlaceData]?) -> ()) {
        let url = "https://api.foursquare.com/v2/venues/explore?client_id=VLDBTIFGVFMH00MVJ0KMPH2IA2EJAE01UXGFYBY4S5V5XDYQ&client_secret=2Y1CDKT2R3VWGZZVVOFTBTY4GVAR0NSR3JZ2XNLMVUWLW1OB&v=20180323&sortByDistance=1&ll=\(lat),\(lng)&offset=\(offset)&limit=10"
        get(url:url) { (json) in
            if json == nil{
                print("nil")
                completion(nil)
            }else{
                for (_,subJson):(String,JSON) in json!["response"]["groups"][0]["items"] {
                    let item : PlaceData = PlaceData(jsonObject: subJson)
                    self.loadedPlaces.append(item)
                        
                }
                completion(self.loadedPlaces)
            }
        }
    }
    
    
    func postData(fname:String,lname:String, state:String ,completion: @escaping (JSON?) -> ()) {
        let url = "https://httpbin.org/post"
        
        let header: HTTPHeaders = [
            state:fname
        ]
        let param:Parameters = [fname:lname,
        ]
        
        post(url:url, parameter: param,header: header) { (json) in
            if json == nil{
                print("nil")
                completion(nil)
            }else{
                for (_,subJson):(String,JSON) in json!{
                  completion(subJson)
                }
            }
        }
    }
    func get(url : String, parameter:Parameters? = nil, header : HTTPHeaders? = nil,completion : @escaping (JSON?) -> ()){
        AF.request(url , method: .get,headers: nil).responseJSON { (response) in
            switch response.result {
            case .success(let response):
                let json = JSON(response)
                completion(json)
                
            case .failure( _):
                completion(nil)
            }
        }
    }
    func post(url : String, parameter:Parameters? = nil, header : HTTPHeaders? = nil,completion : @escaping (JSON?) -> ()){
        AF.request(url ,method: .post,parameters: parameter, headers: header).responseJSON { (response) in
            switch response.result {
            
            case .success(let response):
                let json = JSON(response)
                completion(json)
                
            case .failure( _):
                
                completion(nil)
            }
        }
    }
}



