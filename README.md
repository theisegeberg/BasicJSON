# BasicJSON

An oversimplified Swift JSON Data -> Object mapping framework. Works well with the BasicNetwork library.

## Installation

Add repository as submodule.
```
git submodule add git@github.com:theisegeberg/BasicJSON.git
```
Drag project into your own project and add the binary, or simply use the "BasicJSON.swift" file in your project.

## Example use

### Convert data to JSON
```Swift

let singlePost:Data = Single JSON object as data...
let multiplePosts:Data = List of JSON objects as data...

// Single objects
do {
    if case .object(let rawJSON) = try singlePost.JSON() {
        let post:Post = JSON.buildObject(rawJSON: rawJSON)
        print(post)
    }
} catch let error {
    print(error.localizedDescription)
    
}

// Lists
do {
    if case .list(let rawJSONList) = try multiplePosts.JSON() {
        let posts:[Post] = JSON.buildList(rawJSON: rawJSONList)
        print(posts)
    }
} catch let error {
    print(error.localizedDescription)
    
}
```

### Implement JSONObject protocol
```Swift
import Foundation
import BasicJSON

struct Location:JSONObject {

    let latitude:Double
    let longitude:Double

    init() {
        latitude = 0
        longitude = 0
    }

    init(json: PureJSON) {
        latitude = json["latitude"].jsonValue()
        longitude = json["longitude"].jsonValue()
    }

}

struct Post:JSONObject {

    let title:String
    let location:Location
    let userId:Int
    let body:String
    let show:Bool

    init() {
        title = ""
        location = Location()
        userId = 0
        body = ""
        show = false
    }

    init(json: PureJSON) {
        title = json["title"].jsonValue()
        location = Location(json: json["location"].jsonValue())
        userId = json["userId"].jsonValue()
        body = json["body"].jsonValue()
        show = json["show"].jsonValue()
    }
}
```
