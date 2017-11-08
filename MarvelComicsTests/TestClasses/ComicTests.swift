//
//  ComicTests.swift
//  MarvelComicsTests
//
//  Created by Murat Sudan on 08/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import MarvelComics
import SwiftyJSON

class ComicTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func test_allPropertiesAreSetCorrectlyForDefaultInitializer() {
        
        let sut = Comic(id: "1000", title: "A hero comic", issueNumberString: "7", coverImageURL: "http://myhero.com/coverimage.jpg", description: "This comic is about a hero coming from space", characters: nil)
        
        
        XCTAssertEqual(sut.id, "1000")
        XCTAssertEqual(sut.title, "A hero comic")
        XCTAssertEqual(sut.issueNumberString, "7")
        XCTAssertEqual(sut.coverImageURL, "http://myhero.com/coverimage.jpg")
        XCTAssertEqual(sut.description, "This comic is about a hero coming from space")
        XCTAssertNil(sut.characters)
        
    }
    
    func test_allPropertiesAreSetCorrectlyForAValidJSON() {
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "Comic", ofType: "json")
        let url = URL(fileURLWithPath: path!)
        let data = try! Data(contentsOf: url )
        let json = JSON(data: data)
        
        let sut = Comic(json)
        
        XCTAssertEqual(sut.id, "10840")
        XCTAssertEqual(sut.title, "Spider-Man (1990) #76")
        XCTAssertEqual(sut.issueNumberString, "76")
        XCTAssertEqual(sut.coverImageURL, "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available.jpg")
        XCTAssertEqual(sut.description, "Spiderman is a great hero!")
        XCTAssertEqual(sut.characters!, ["Spider-Man", "Venom"])
    }
    
}
