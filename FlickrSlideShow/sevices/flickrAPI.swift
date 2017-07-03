

import Foundation
import Alamofire
import SwiftyJSON

enum Result<T> {
    case success(T)
    case error(Error)
}

struct Config {
    static let apiKey = "76bd3d52c37d3da71f94e173c5b0a575"
    static let secret = "982ca61632aa431e"
    static let shotURL = "https://api.flickr.com/services/rest/?"
    static let getRecent = "method=flickr.photos.getRecent"
    static let getPopular = "method=flickr.photos.getPopular"
    static let perPage = 50
}


class FlickrServices {
    
    
    static let instance: FlickrServices = FlickrServices()
    private init() {}
    
    
    
   
    
    

func getShotsFeed(page: Int, successCallback: @escaping ([FlickrFeedItem]) -> Void, errorCallback: @escaping (Error) -> Void ) {
    
    
   
    let url = Config.shotURL + Config.getRecent + "&api_key=" + Config.apiKey + "&page=\(page)" + "&per_page=\(Config.perPage)" + "&format=json&nojsoncallback=1"
    
    print(url)
    
    getJSON (url: url) { response in
        switch response {
        case .success(let result):
           
           // print("result is \(result.array)")
            
            
            
            
            
            
            guard let array = result.array else { return }
           //let array = result.array
           let items =  array.flatMap { mapFlickrFeedItem($0) }
           //let items =  result["users"].arrayValue.map({$0["name"].stringValue})
            successCallback(items)
        case .error(let error):
            errorCallback(error)
        }
    }
}
    
    
    // MARK: private methods
    private func getJSON(url: String, calback: @escaping (Result<JSON>) -> Void) {
        
        Alamofire.request(url).responseJSON { response in
            
            if let jsonString = response.result.value {
                
                let json = JSON(jsonString)
                //print(json)
                
                let name = json["photos","photo"].arrayValue
               // print(name)
                let photosArray = JSON(name)
                
                calback(.success(photosArray))
            } else {
                let error = NSError(domain: "Couldn't get response", code: 501, userInfo: nil)
                calback(.error(error))
            }
        }
        
    }

    
    
    
    
}
