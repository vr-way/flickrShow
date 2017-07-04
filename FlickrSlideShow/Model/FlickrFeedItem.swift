

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

    
    
    let id = input["id" ].stringValue
    let owner = input["owner" ].stringValue
    let secret = input["secret" ].stringValue
    let server = input["server" ].stringValue
    let farm = input["farm" ].stringValue
    let title = input["title" ].stringValue
    
    
   

   let item = FlickrFeedItem(id: id, owner: owner, secret: secret, server: server, farm: farm, title: title)
    
    
    return item

}
