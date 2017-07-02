

import Foundation
import SwiftyJSON

struct FlickrFeedItem {
    
    let id: String
    let owner: String
    let secret: String
    let server: String
    let farm: String
    let title: String
    
    
}

func mapFlickrFeedItem(_ input: JSON) -> FlickrFeedItem? {

    
    
    let id = input["photos", "photo", "id" ].stringValue
    let owner = input["photos", "photo", "owner" ].stringValue
    let secret = input["photos", "photo", "secret" ].stringValue
    let server = input["photos", "photo", "server" ].stringValue
    let farm = input["photos", "photo", "farm" ].stringValue
    let title = input["photos", "photo", "title" ].stringValue
    

   let item = FlickrFeedItem(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title)
    
    
    return item

}
