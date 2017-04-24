//
//  BasicJSONTests.swift
//  BasicJSONTests
//
//  Created by Theis Egeberg on 21/04/2017.
//  Copyright © 2017 Theis Egeberg. All rights reserved.
//

import XCTest


class BasicJSONTests: XCTestCase {
    
    var singlePost:Data!
    var multiplePosts:Data!
    
    func jsonData(fromBundledJsonFile file:String) -> Data {
        do {
            guard let url = Bundle(for: type(of: self)).url(forResource: file, withExtension: "json") else {
                XCTFail("Couldn't generate url")
                exit(0)
            }
            return try Data(contentsOf: url)
        } catch let error {
            XCTFail(error.localizedDescription)
            exit(0)
        }
    }
    
    override func setUp() {
        super.setUp()
        self.singlePost = self.jsonData(fromBundledJsonFile: "singlePost")
        self.multiplePosts = self.jsonData(fromBundledJsonFile: "multiplePosts")
    }
    
    
    override func tearDown() {
        super.tearDown()
    }
    
    
    
    func testJSONCreation() {
        do {
            guard case .object(let singlePostValue) = try singlePost.JSON() else {
                XCTFail("Single post did not contain a JSON.object")
                exit(0)
            }
            print(singlePostValue)

            guard case .list(let multiplePostsValue) = try multiplePosts.JSON() else {
                XCTFail("Multiple posts post did not contain a JSON.object")
                exit(0)
            }
            print(multiplePostsValue)

        } catch let error {
            XCTFail(error.localizedDescription)
            exit(0)
        }
    }
    
    
    
    func testObjectCreation() {
        do {
            
            if case .object(let rawJSON) = try singlePost.JSON() {
                let post:Post = JSON.buildObject(rawJSON: rawJSON)
                print(post)
            }
            
            
        } catch let error {
            XCTFail(error.localizedDescription)
            exit(0)
        }
    }
    
    func testObjectListCreation() {
        do {
            if case .list(let rawJSONList) = try multiplePosts.JSON() {
                let posts:[Post] = JSON.buildList(rawJSON: rawJSONList)
                print(posts)
            }
        } catch let error {
            XCTFail(error.localizedDescription)
            exit(0)
        }
    }
    
    
}
