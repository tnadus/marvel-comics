//
//  ComicViewModelTests.swift
//  MarvelComicsTests
//
//  Created by Murat Sudan on 08/11/2017.
//  Copyright © 2017 Tarum Nadus. All rights reserved.
//

import XCTest
@testable import MarvelComics

class ComicViewModelTests: XCTestCase {
    
    var comic: Comic?
    var comicEmpty: Comic?
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    self.comic = Comic(id: "1000", title: "A hero comic # 7", issueNumberString: "7", coverImageURL: "http://myhero.com/coverimage.jpg", description: "This comic is about a hero coming from space", characters: ["Spiderman","Venom", "Dracula"])
       
        self.comicEmpty = Comic(id: nil, title: nil, issueNumberString: nil, coverImageURL: nil, description: nil, characters: nil)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func test_viewTitleIsSetCorrectly(){
        let sut = ComicViewModel(comic: comic!, coverImage: nil)
        XCTAssertEqual(sut.title, "Comic Details")
    }

    func test_nameTitleIsSetCorrectly() {
        let sut = ComicViewModel(comic: comic!, coverImage: nil)
        XCTAssertEqual(sut.nameTitle, "A hero comic ")
    }
    
    func test_nameTitleIsSetCorrectlyForAnEmptyComic() {
        let sut = ComicViewModel(comic: comicEmpty!, coverImage: nil)
        XCTAssertEqual(sut.nameTitle, "")
    }

    func test_issueNumberIsSetCorrectly() {
        let sut = ComicViewModel(comic: comic!, coverImage: nil)
        XCTAssertEqual(sut.issueNumberTitle, "Number: 7")
    }
    
    func test_issueNumberIsSetCorrectlyForAnEmptyComic() {
        let sut = ComicViewModel(comic: comicEmpty!, coverImage: nil)
        XCTAssertEqual(sut.issueNumberTitle, "")
    }

    func test_desciptionTextIsSetCorrectly() {
        let sut = ComicViewModel(comic: comic!, coverImage: nil)
        XCTAssertEqual(sut.descriptionText, "This comic is about a hero coming from space")
    }
    
    func test_desciptionTextIsSetCorrectlyForAnEmptyComic() {
        let sut = ComicViewModel(comic: comicEmpty!, coverImage: nil)
        XCTAssertEqual(sut.descriptionText, "No description found")
    }
    
    func test_heroNamesTextIsSetCorrectly() {
        let sut = ComicViewModel(comic: comic!, coverImage: nil)
        XCTAssertEqual(sut.heroNamesText, "Spiderman, Venom, Dracula")
    }
    
    func test_heroNamesTextIsSetCorrectlyForAnEmptyComic() {
        let sut = ComicViewModel(comic: comicEmpty!, coverImage: nil)
        XCTAssertEqual(sut.heroNamesText, "No hero found in this comic")
    }
    
}
